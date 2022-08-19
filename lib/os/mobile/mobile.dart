import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:pexels_api_flutter_ui/api/base_url.dart';
import 'package:pexels_api_flutter_ui/screen/fullscreenview.dart';
import 'package:pexels_api_flutter_ui/widgets/drawer.dart';
import 'package:pexels_api_flutter_ui/widgets/floatingActionButton.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class MobileBody extends StatefulWidget {
  static List<dynamic> image = [];

  const MobileBody({Key? key}) : super(key: key);

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  int page = 0;

  Future<void> fetchData() async {
    try {
      await http.get(Uri.parse(BaseUrl.getUrl.toString()),
          headers: {"Authorization": BaseUrl.apiKey.toString()}).then((value) {
        final resuilt = jsonDecode(value.body);
        final decodeData = resuilt["photos"];

        setState(() {
          MobileBody.image = decodeData;
        });
      }).timeout(const Duration(minutes: 5));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> moreData() async {
    page += 1;

    try {
      String url = BaseUrl.addDataUrl.toString() + page.toString();
      await http.get(Uri.parse(BaseUrl.addDataUrl.toString() + page.toString()),
          headers: {"Authorization": BaseUrl.apiKey.toString()}).then((value) {
        var resuilt = jsonDecode(value.body);
        final decodeData = resuilt["photos"];
        MobileBody.image.addAll(decodeData);

        setState(() {});
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Pexels"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/search");
                },
                icon: const Icon(Icons.search))
          ],
        ),
        drawer: MyDrawer(
          color: Colors.blueGrey,
          imageUrl:
              "https://images.pexels.com/photos/13146110/pexels-photo-13146110.jpeg?",
        ),
        floatingActionButton: MyFloatingActionButton(
          title: "Page",
          onPressed: () {
            moreData();
          },
          textColor: Colors.white,
          backgroundColor: Colors.blueGrey,
          icon: Icons.next_plan,
          textAlign: TextAlign.center,
          iconColor: Colors.white,
        ),
        body: MobileBody.image.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                children: [
                  _ImageSlider(),
                  _CircleImage(),
                  _GridViewLayout(),
                ],
              ))
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}

class _GridViewLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
        itemCount: MobileBody.image.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2),
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: () {
              String imageUrlPortrait =
                  MobileBody.image[index]["src"]["portrait"];
              String imageUrlOriginal =
                  MobileBody.image[index]["src"]["original"];
              String photographer = MobileBody.image[index]["photographer"];
              String avgColor = MobileBody.image[index]["avg_color"];
              String photographerUrl =
                  MobileBody.image[index]["photographer_url"];

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FullScreenView(
                        imageUrl: imageUrlPortrait,
                        imageUrlOriginal: imageUrlOriginal,
                        photographer: photographer,
                        color: avgColor,
                        photographerUrl: photographerUrl,
                      )));
            },
            child: Card(
              color: HexColor(MobileBody.image[index]["avg_color"]),
              child: CachedNetworkImage(
                imageUrl: MobileBody.image[index]['src']['large'],
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          );
        }));
  }
}

class _CircleImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: MobileBody.image.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 80,
              width: 80,
              child: CircleAvatar(
                foregroundColor: HexColor(MobileBody.image[index]["avg_color"]),
                backgroundImage: CachedNetworkImageProvider(
                    MobileBody.image[index]['src']['large'],
                    errorListener: () => CachedNetworkImage.evictFromCache(
                        "assets/images/image.png")),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ImageSlider extends StatelessWidget {
  @override
  Widget build(Object context) {
    return MobileBody.image.isNotEmpty
        ? CarouselSlider.builder(
            itemCount: MobileBody.image.length,
            itemBuilder: ((context, index, realIndex) {
              return CachedNetworkImage(
                imageUrl: MobileBody.image[index]['src']['landscape'],
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer(
                  duration: const Duration(seconds: 3), //Default value
                  interval: const Duration(seconds: 5), //Default value: Duration(seconds: 0)
                  color: Colors.white, //Default value
                  enabled: true, //Default value
                  direction: const ShimmerDirection.fromLTRB(),
                  child: Container(
                    color: HexColor(MobileBody.image[index]['avg_color'])

                  )
                ),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/image.png"),
              );
            }),
            options: CarouselOptions(
              autoPlay: true,
              enableInfiniteScroll: true,
              viewportFraction: 0.8,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: true,
              //  pauseAutoPlayOnTouch: true
            ))
        : const Center(
            child: Text(""),
          );
  }
}

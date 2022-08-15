import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:pexels_api_flutter_ui/api/base_url.dart';
import 'package:pexels_api_flutter_ui/screen/fullscreenview.dart';
import 'package:pexels_api_flutter_ui/widgets/drawer.dart';
import 'package:pexels_api_flutter_ui/widgets/floatingActionButton.dart';

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
        backgroundColor: Colors.black,
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
            ? GridView.builder(
                itemCount: MobileBody.image.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: ((context, index) {
                  String imageUrlLarge =
                      MobileBody.image[index]["src"]["original"];
                  String imageUrlOriginal =
                      MobileBody.image[index]["src"]["large"];
                  String photographer = MobileBody.image[index]["photographer"];
                  String avgColor = MobileBody.image[index]["avg_color"];
                  String photographerUrl =
                      MobileBody.image[index]["photographer_url"];
                  return Card(
                      color: HexColor(MobileBody.image[index]["avg_color"]),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => FullScreenView(
                                    imageUrl: imageUrlOriginal,
                                    color: avgColor,
                                    photographer: photographer,
                                    photographerUrl: photographerUrl,
                                  ))));
                        },
                        child: CachedNetworkImage(
                          imageUrl: imageUrlLarge,
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return const Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              ),
                            );
                          },
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ));
                }))
               : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}

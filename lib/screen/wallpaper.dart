import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_network/image_network.dart';
import 'package:pexels_api_flutter_ui/screen/fullscreenview.dart';
import 'package:pexels_api_flutter_ui/utils/datafile.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Wallpaper extends StatelessWidget {
  const Wallpaper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // backgroundColor: HexColor("#03fcc2"),
        centerTitle: true,
        title: const Text("Pexels"),
      ),
      body: const BodyWallpaper(),
    );
  }
}

class BodyWallpaper extends StatefulWidget {
  const BodyWallpaper({Key? key}) : super(key: key);

  @override
  State<BodyWallpaper> createState() => _BodyWallpaperState();
}

class _BodyWallpaperState extends State<BodyWallpaper> {
  List images = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  Future<void> fetchApi() async {
    try {
      print("get Data Url " + BaseUrl.getUrl.toString());
      await http.get(Uri.parse(BaseUrl.getUrl.toString()),
          headers: {"Authorization": BaseUrl.apiKey.toString()}).then((value) {
        Map result = jsonDecode(value.body);
        setState(() {
          images = result['photos'];
        });

        print(images[0]['src']["original"]);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> moreData() async {
    setState(() {
      page = page + 1;
    });

    try {
      String url = BaseUrl.addDataUrl.toString() + page.toString();
      print(url);
      await http.get(Uri.parse(url),
          headers: {"Authorization": BaseUrl.apiKey.toString()}).then((value) {
        Map result = jsonDecode(value.body);
        setState(() {
          images.addAll(result['photos']);
          // print(images);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (() => moreData()),
        backgroundColor: Colors.blueGrey,
        child: Text(
          "Page\n${page}",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2 / 3, // x/y
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    String imagesPath = images[index]['src']['large2x'];
                    return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => FullScreenView(
                                    imageUrl: images[index]['src']['large2x'],
                                    photographer: images[index]["photographer"],
                                    color: images[index]["avg_color"],
                                  )));
                        },
                        child: imagesPath == null
                            ? Image.asset("assets/images/image.png")
                            : Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: CachedNetworkImage(
                                  imageUrl: imagesPath,
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                  placeholder: (context, url) =>
                                      Image.network(url),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

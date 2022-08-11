import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:pexels_api_flutter_ui/fullscreenview.dart';
import 'package:pexels_api_flutter_ui/utils/datafile.dart';

class Wallpaper extends StatelessWidget {
  const Wallpaper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: HexColor("#03fcc2"),
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
      body:Column(
        children: <Widget>[
         Expanded(
              child: Container(
            child:GridView.builder(
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3, // x/y
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FullScreenView(
                                imageUrl: images[index]['src']['large2x'],
                                photographer: images[index]["photographer"],
                                color: images[index] ["avg_color"],
                              )));
                    },
                    // ignore: unnecessary_null_comparison
                    child:SizedBox(
                      child: Image.network(
                        images[index]['src']["large2x"],
                        //loadingBuilder: (context, child, loadingProgress) =>const CircularProgressIndicator(),
                        errorBuilder:(context, error, stackTrace) => const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    )
                  );
                }),
          ),
          ),

          InkWell(
            onTap: moreData,
            child: Container(
              width: double.infinity,
              height: 40,
              color: Colors.black,
              child: const Center(
                child: Text(
                  "More",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

// ignore: must_be_immutable
class FullScreenView extends StatefulWidget {
  String? imageUrl;
  String? photographer;
  String? color;

  FullScreenView({
    Key? key,
    this.imageUrl,
    this.photographer,
    this.color,
  }) : super(key: key);

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  Future<void> setWallpaper(location , title) async {
    File file = await DefaultCacheManager().getSingleFile(widget.imageUrl!);

    try {
      WallpaperManagerFlutter().setwallpaperfromFile(file, location);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(title)));
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(title)));
      print(e);
    }

    // int location = WallpaperManagerFlutter.HOME_SCREEN; //Choose screen type
    // final result = await WallpaperManagerFlutter().setwallpaperfromFile(cachedimage, location);
    // ignore: avoid_print
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: HexColor(widget.color.toString()), 
      extendBodyBehindAppBar: true,
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 700.0,
            child: Image.network(widget.imageUrl!)==null
                      ? Image.asset("assets/images/image.png ",scale: 1.0,)
                      : Image.network(
                        widget.imageUrl! ,
                        scale: 1.0,
                        fit: BoxFit.cover,
                      ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      color: HexColor(widget.color.toString()),
                      onPressed: () =>
                          setWallpaper(WallpaperManagerFlutter.BOTH_SCREENS,"Both Screen in set wallpaper"),
                      child: const Text(
                        "Set Both",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      color: HexColor(widget.color.toString()),
                      onPressed: () =>
                          setWallpaper(WallpaperManagerFlutter.HOME_SCREEN,"Home Screen in set wallpaper"),
                      child: const Text(
                        "Set Home",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: MaterialButton(
                      color: HexColor(widget.color.toString()),
                      onPressed: () =>
                          setWallpaper(WallpaperManagerFlutter.LOCK_SCREEN,"Lock Screen in set wallpaper"),
                      child: const Text(
                        "Set Lock",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              SizedBox(
                child: Text("PhotoGrapher : ${widget.photographer!}",
                  style: const TextStyle(
                    fontSize: 18
                  ),
                  ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

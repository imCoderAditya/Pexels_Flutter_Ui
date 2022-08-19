import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

// ignore: must_be_immutable
class FullScreenView extends StatefulWidget {
  String? imageUrl;
  String? imageUrlOriginal;
  String? photographer;
  String? color;
  String? photographerUrl;

  FullScreenView(
      {Key? key,
      this.imageUrl,
      this.photographer,
      this.color,
      this.imageUrlOriginal,
      this.photographerUrl})
      : super(key: key);

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {

  Future<void> setWallpaper(location, title) async {
    File file = await DefaultCacheManager().getSingleFile(widget.imageUrl!);

    try {
      WallpaperManagerFlutter().setwallpaperfromFile(file, location);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(title)));
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      print(e);
    }
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(widget.color.toString()),
      extendBodyBehindAppBar: true,
      body: ListView(
        children: <Widget>[
          CachedNetworkImage(
            height: 700,
            width: double.infinity,
            imageUrl: widget.imageUrlOriginal!.isEmpty
                      ?widget.imageUrl!
                      :widget.imageUrlOriginal!,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, progress) {
              return const Center(
                child: SizedBox(
                  width: 40.0,
                  height: 40.0,
                  child:  CircularProgressIndicator(),
                ),
              );
            },
            errorWidget: (context, url, error) =>const Icon(Icons.error),
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
                      onPressed: () => setWallpaper(
                          WallpaperManagerFlutter.BOTH_SCREENS,
                          "Both Screen in set wallpaper"),
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
                      onPressed: () => setWallpaper(
                          WallpaperManagerFlutter.HOME_SCREEN,
                          "Home Screen in set wallpaper"),
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
                      onPressed: () => setWallpaper(
                          WallpaperManagerFlutter.LOCK_SCREEN,
                          "Lock Screen in set wallpaper"),
                      child: const Text(
                        "Set Lock",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.imageUrl!)),
                  ),
                  SizedBox(
                    child: Text(
                      "PhotoGrapher : ${widget.photographer!}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

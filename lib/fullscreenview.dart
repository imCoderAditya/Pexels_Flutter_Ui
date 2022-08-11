import 'package:file/src/interface/file.dart';
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
  void setWallpaper() async {
    File cachedimage = await DefaultCacheManager()
        .getSingleFile(widget.imageUrl!); //image file
    int location = WallpaperManagerFlutter.HOME_SCREEN; //Choose screen type
    WallpaperManagerFlutter().setwallpaperfromFile(cachedimage, location);
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
            child: Image.network(
              widget.imageUrl.toString(),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: MaterialButton(
              color: HexColor(widget.color.toString()),
              onPressed: () => setWallpaper(),
              child: const Text(
                "Set Wallpaper",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

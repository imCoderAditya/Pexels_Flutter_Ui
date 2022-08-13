import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:pexels_api_flutter_ui/model/pexels_model.dart';
import 'package:pexels_api_flutter_ui/model/photos.dart';
import 'package:pexels_api_flutter_ui/screen/fullscreenview.dart';
import 'package:pexels_api_flutter_ui/utils/datafile.dart';
import 'package:pexels_api_flutter_ui/widgets/drawer.dart';
import 'package:pexels_api_flutter_ui/widgets/floatingActionButton.dart';

class MobileBody extends StatefulWidget {
  const MobileBody({Key? key}) : super(key: key);

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  List<dynamic> bgColor = [];
  int page = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      await http.get(Uri.parse(BaseUrl.getUrl.toString()),
          headers: {"Authorization": BaseUrl.apiKey.toString()}).then((value) {
        final resuilt = jsonDecode(value.body);
        final decodeData = resuilt["photos"];

        PexelsModel.photos = List.from(decodeData)
            .map<Photos>((e) => Photos.fromMap(e))
            .toList();

        setState(() {
          //  print(decodeData);
          bgColor = resuilt["photos"];
          print(bgColor);
        });
      }).timeout(const Duration(minutes: 5));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> moreData() async {
    setState(() {
      page += 1;
    });

    try {
      String url = BaseUrl.addDataUrl.toString() + page.toString();
      await http.get(Uri.parse(BaseUrl.addDataUrl.toString() + page.toString()),
          headers: {"Authorization": BaseUrl.apiKey.toString()}).then((value) {
        var resuilt = jsonDecode(value.body);
        final decodeData = resuilt["photos"];
        print(url);

        setState(() {
          PexelsModel.photos = List.from(decodeData)
            .map<Photos>((e) => Photos.fromMap(e))
            .toList();
          PexelsModel.photos!.addAll(decodeData);
          bgColor.addAll(decodeData);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text("Pexels"),
      ),
      drawer: MyDrawer(),
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
      body:GridView.builder(
            itemCount: PexelsModel.photos!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return Card(
                color: HexColor(bgColor[index]['avg_color']),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) => FullScreenView(
                       imageUrl: PexelsModel.photos![index].src!.large,
                       color: bgColor[index]["avg_color"],
                       photographer: PexelsModel.photos![index].photographer,
                       photographerUrl: PexelsModel.photos![index].photographerUrl,
                    ))));
                  },
                    child: Image.network(
                      PexelsModel.photos![index].src!.large.toString(),
                      fit: BoxFit.cover,
                      ),
                  ),
              );
            }),
      
    );
  }
}

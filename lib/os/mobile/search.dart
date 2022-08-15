import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pexels_api_flutter_ui/widgets/floatingActionButton.dart';
import '../../api/base_url.dart';
import '../../screen/fullscreenview.dart';
import 'package:http/http.dart' as http;

class SearchData extends StatefulWidget {
  static List<dynamic> search = [];
  static String searchValue = '';
  static final List<String> _suggestions = [
    'nature',
    'tigers',
    'independence day india',
    'Food',
    'Technology',
    'Indian Flag',
    'India',
    'Car',
    'Beach',
    'Sky',
    'Indian Army',
    'Forest',
    'Abstract',
    'Space',
    'Dark',
    'Sunset',
    'landscape',
    'Adrenaline',
    'Summer Mood',
    'Markus Spiske ',
  
  ];

  const SearchData({Key? key}) : super(key: key);

  @override
  State<SearchData> createState() => _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  int page = 0;

  Future<void> searchData({required String query}) async {
    print(query);
    try {
      String url =
          "${BaseUrl.searchDataUrl.toString() + query}&per_page=80&page=$page";
      await http.get(Uri.parse(url),
          headers: {"Authorization": BaseUrl.apiKey.toString()}).then((value) {
        final resuilt = jsonDecode(value.body);
        final decodeData = resuilt["photos"];
        SearchData.search = decodeData;
        setState(() { });

        print(url);
        print(decodeData[0]["photographer"]);
      }).timeout(const Duration(minutes: 5));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

   Future<void> moreSearchData({required String query}) async {
    page += 1;
    try {
      String url =
          "${BaseUrl.searchDataUrl.toString() + query}&per_page=80&page=$page";
      await http.get(Uri.parse(url),
          headers: {"Authorization": BaseUrl.apiKey.toString()}).then((value) {
        final resuilt = jsonDecode(value.body);
        final decodeData = resuilt["photos"];
        SearchData.search.addAll(decodeData);
        setState(() {});
  
        print(url);
        print(decodeData);
      }).timeout(const Duration(minutes: 5));
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: EasySearchBar(
        searchHintText: "search engine for image",
        searchHintStyle: const TextStyle(
            color: Colors.blueGrey, fontWeight: FontWeight.normal),
        suggestionTextStyle:
            const TextStyle(color: Colors.blueGrey, fontSize: 15),
        searchCursorColor: Colors.white,
        searchTextStyle: const TextStyle(color: Colors.white),
        searchBackIconTheme: const IconThemeData(color: Colors.white),
        suggestionBackgroundColor: Colors.black,
        title: const Text(
          "Search",
          textAlign: TextAlign.center,
        ),
        onSearch: (value) {
          setState(() {
            try{
            SearchData.searchValue = value;
            searchData(query: value);
            print(SearchData.searchValue);
            }catch(e){
              print(e);
            }
          });
        },
        suggestions: SearchData._suggestions,
      ),
       floatingActionButton:SearchData.search.isNotEmpty? MyFloatingActionButton(
        backgroundColor: Colors.blueGrey,
        icon: Icons.next_plan,
        textAlign: TextAlign.center,
        iconColor: Colors.white,
        onPressed: () {
          moreSearchData(query: SearchData.searchValue);
        },
      ):const Center(child: Text(""),),
      body: GridView.builder(
          itemCount: SearchData.search.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemBuilder: ((context, index) {
            String imageUrlLarge = SearchData.search[index]["src"]["original"];
            String photographer = SearchData.search[index]["photographer"];
            String avgColor = SearchData.search[index]["avg_color"];
            String photographerUrl =
                SearchData.search[index]["photographer_url"];
            return Card(
                color: HexColor(SearchData.search[index]["avg_color"]),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => FullScreenView(
                              imageUrl: imageUrlLarge,
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
          })),
    );
  }
}

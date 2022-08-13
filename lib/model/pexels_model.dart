// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: camel_case_types
import 'dart:convert';

import 'package:pexels_api_flutter_ui/model/photos.dart';

class PexelsModel {
  int? page;
  int? perPage;
  static List<Photos>? photos = [];
  int? totalResults;
  String? nextPage;
  PexelsModel({
    this.page,
    this.perPage,
    this.totalResults,
    this.nextPage,
  });


  PexelsModel copyWith({
    int? page,
    int? perPage,
    int? totalResults,
    String? nextPage,
  }) {
    return PexelsModel(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      totalResults: totalResults ?? this.totalResults,
      nextPage: nextPage ?? this.nextPage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page': page,
      'perPage': perPage,
      'totalResults': totalResults,
      'nextPage': nextPage,
    };
  }

  factory PexelsModel.fromMap(Map<String, dynamic> map) {
    return PexelsModel(
      page: map['page'] != null ? map['page'] as int : null,
      perPage: map['perPage'] != null ? map['perPage'] as int : null,
      totalResults: map['totalResults'] != null ? map['totalResults'] as int : null,
      nextPage: map['nextPage'] != null ? map['nextPage'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PexelsModel.fromJson(String source) => PexelsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PexelsModel(page: $page, perPage: $perPage, totalResults: $totalResults, nextPage: $nextPage)';
  }

  @override
  bool operator ==(covariant PexelsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.page == page &&
      other.perPage == perPage &&
      other.totalResults == totalResults &&
      other.nextPage == nextPage;
  }

  @override
  int get hashCode {
    return page.hashCode ^
      perPage.hashCode ^
      totalResults.hashCode ^
      nextPage.hashCode;
  }
}


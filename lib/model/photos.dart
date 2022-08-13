// ignore_for_file: public_member_api_docs, sort_constructors_first
// Photoes class 


import 'dart:convert';

import 'package:pexels_api_flutter_ui/model/src.dart';

class Photos {
  int? id;
  int? width;
  int? height;
  String? url;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  String? avgColor;
  Src? src;
  bool? liked;
  String? alt;
  Photos({
    this.id,
    this.width,
    this.height,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.avgColor,
    this.src,
    this.liked,
    this.alt,
  });
  

  Photos copyWith({
    int? id,
    int? width,
    int? height,
    String? url,
    String? photographer,
    String? photographerUrl,
    int? photographerId,
    String? avgColor,
    Src? src,
    bool? liked,
    String? alt,
  }) {
    return Photos(
      id: id ?? this.id,
      width: width ?? this.width,
      height: height ?? this.height,
      url: url ?? this.url,
      photographer: photographer ?? this.photographer,
      photographerUrl: photographerUrl ?? this.photographerUrl,
      photographerId: photographerId ?? this.photographerId,
      avgColor: avgColor ?? this.avgColor,
      src: src ?? this.src,
      liked: liked ?? this.liked,
      alt: alt ?? this.alt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'width': width,
      'height': height,
      'url': url,
      'photographer': photographer,
      'photographerUrl': photographerUrl,
      'photographerId': photographerId,
      'avgColor': avgColor,
      'src': src?.toMap(),
      'liked': liked,
      'alt': alt,
    };
  }

  factory Photos.fromMap(Map<String, dynamic> map) {
    return Photos(
      id: map['id'] != null ? map['id'] as int : null,
      width: map['width'] != null ? map['width'] as int : null,
      height: map['height'] != null ? map['height'] as int : null,
      url: map['url'] != null ? map['url'] as String : null,
      photographer: map['photographer'] != null ? map['photographer'] as String : null,
      photographerUrl: map['photographerUrl'] != null ? map['photographerUrl'] as String : null,
      photographerId: map['photographerId'] != null ? map['photographerId'] as int : null,
      avgColor: map['avgColor'] != null ? map['avgColor'] as String : null,
      src: map['src'] != null ? Src.fromMap(map['src'] as Map<String,dynamic>) : null,
      liked: map['liked'] != null ? map['liked'] as bool : null,
      alt: map['alt'] != null ? map['alt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Photos.fromJson(String source) => Photos.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Photos(id: $id, width: $width, height: $height, url: $url, photographer: $photographer, photographerUrl: $photographerUrl, photographerId: $photographerId, avgColor: $avgColor, src: $src, liked: $liked, alt: $alt)';
  }

  @override
  bool operator ==(covariant Photos other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.width == width &&
      other.height == height &&
      other.url == url &&
      other.photographer == photographer &&
      other.photographerUrl == photographerUrl &&
      other.photographerId == photographerId &&
      other.avgColor == avgColor &&
      other.src == src &&
      other.liked == liked &&
      other.alt == alt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      width.hashCode ^
      height.hashCode ^
      url.hashCode ^
      photographer.hashCode ^
      photographerUrl.hashCode ^
      photographerId.hashCode ^
      avgColor.hashCode ^
      src.hashCode ^
      liked.hashCode ^
      alt.hashCode;
  }
}

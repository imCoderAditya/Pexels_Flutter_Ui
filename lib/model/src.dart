// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Src {
  String? original;
  String? large2x;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;
  Src({
    this.original,
    this.large2x,
    this.large,
    this.medium,
    this.small,
    this.portrait,
    this.landscape,
    this.tiny,
  });


  Src copyWith({
    String? original,
    String? large2x,
    String? large,
    String? medium,
    String? small,
    String? portrait,
    String? landscape,
    String? tiny,
  }) {
    return Src(
      original: original ?? this.original,
      large2x: large2x ?? this.large2x,
      large: large ?? this.large,
      medium: medium ?? this.medium,
      small: small ?? this.small,
      portrait: portrait ?? this.portrait,
      landscape: landscape ?? this.landscape,
      tiny: tiny ?? this.tiny,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'original': original,
      'large2x': large2x,
      'large': large,
      'medium': medium,
      'small': small,
      'portrait': portrait,
      'landscape': landscape,
      'tiny': tiny,
    };
  }

  factory Src.fromMap(Map<String, dynamic> map) {
    return Src(
      original: map['original'] != null ? map['original'] as String : null,
      large2x: map['large2x'] != null ? map['large2x'] as String : null,
      large: map['large'] != null ? map['large'] as String : null,
      medium: map['medium'] != null ? map['medium'] as String : null,
      small: map['small'] != null ? map['small'] as String : null,
      portrait: map['portrait'] != null ? map['portrait'] as String : null,
      landscape: map['landscape'] != null ? map['landscape'] as String : null,
      tiny: map['tiny'] != null ? map['tiny'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Src.fromJson(String source) => Src.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Src(original: $original, large2x: $large2x, large: $large, medium: $medium, small: $small, portrait: $portrait, landscape: $landscape, tiny: $tiny)';
  }

  @override
  bool operator ==(covariant Src other) {
    if (identical(this, other)) return true;
  
    return 
      other.original == original &&
      other.large2x == large2x &&
      other.large == large &&
      other.medium == medium &&
      other.small == small &&
      other.portrait == portrait &&
      other.landscape == landscape &&
      other.tiny == tiny;
  }

  @override
  int get hashCode {
    return original.hashCode ^
      large2x.hashCode ^
      large.hashCode ^
      medium.hashCode ^
      small.hashCode ^
      portrait.hashCode ^
      landscape.hashCode ^
      tiny.hashCode;
  }
}

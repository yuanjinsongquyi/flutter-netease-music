import 'safe_convert.dart';
class ArtistList {
  ArtistList({
    this.id = "",
    this.name = "",
    this.pic = "",
    this.musicNum = '',
    this.country = "",
  });

  factory ArtistList.fromJson(Map<String, dynamic>? json) {

    return ArtistList(
      id: asString(json, 'id'),
      name: asString(json, 'name'),
      pic: asString(json, 'pic'),
      musicNum: asString(json, 'musicNum'),
      country: asString(json, 'musicNum'),

    );
  }

  final String id;
  final String name;
  final String pic;
  final String musicNum;
  final String country;

  Map<String, dynamic> toJson() => {

  };
}
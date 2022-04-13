import 'safe_convert.dart';
class AlumItem {
  AlumItem({
    this.id = 0,
    this.name = "",
    this.picUrl = "",
    this.info = "",
  });

  factory AlumItem.fromJson(Map<String, dynamic>? json) =>
      AlumItem(
          id: asInt(json, 'id'),
          picUrl: asString(json, 'img'),
          name: asString(json, 'name'),
          info: asString(json, 'info')
      );

  final int id;
  final String picUrl;
  final String name;
  final String info;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'picUrl': picUrl,
    'info': info,


  };
}
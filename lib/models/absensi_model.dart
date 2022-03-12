// To parse this JSON data, do
//
//     final absensi = absensiFromJson(jsonString);

import 'dart:convert';

Absensi absensiFromJson(String str) => Absensi.fromJson(json.decode(str));

String absensiToJson(Absensi data) => json.encode(data.toJson());

class Absensi {
  Absensi({
    this.id,
    this.tanggal,
    this.jam,
    this.lat,
    this.long,
    this.photo,
    this.type,
  });

  int? id;
  String? tanggal;
  String? jam;
  String? lat;
  String? long;
  String? photo;
  String? type;

  factory Absensi.fromJson(Map<String, dynamic> json) => Absensi(
        id: json["id"] == null ? null : json["id"],
        tanggal: json["tanggal"] == null ? null : json["tanggal"],
        jam: json["jam"] == null ? null : json["jam"],
        lat: json["lat"] == null ? null : json["lat"],
        long: json["long"] == null ? null : json["long"],
        photo: json["photo"] == null ? null : json["photo"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "tanggal": tanggal == null ? null : tanggal,
        "jam": jam == null ? null : jam,
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
        "photo": photo == null ? null : photo,
        "type": type == null ? null : type,
      };
}

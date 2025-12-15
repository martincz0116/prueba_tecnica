import 'dart:convert';

List<ApodList> apodListFromJson(String str) =>
    List<ApodList>.from(json.decode(str).map((x) => ApodList.fromJson(x)));

String apodListToJson(List<ApodList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApodList {
  final DateTime date;
  final String explanation;
  final String mediaType;
  final String serviceVersion;
  final String title;
  final String? url;
  final String? copyright;
  final String? hdurl;

  ApodList({
    required this.date,
    required this.explanation,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    this.url,
    this.copyright,
    this.hdurl,
  });

  ApodList copyWith({
    DateTime? date,
    String? explanation,
    String? mediaType,
    String? serviceVersion,
    String? title,
    String? url,
    String? copyright,
    String? hdurl,
  }) => ApodList(
    date: date ?? this.date,
    explanation: explanation ?? this.explanation,
    mediaType: mediaType ?? this.mediaType,
    serviceVersion: serviceVersion ?? this.serviceVersion,
    title: title ?? this.title,
    url: url ?? this.url,
    copyright: copyright ?? this.copyright,
    hdurl: hdurl ?? this.hdurl,
  );

  factory ApodList.fromJson(Map<String, dynamic> json) => ApodList(
    date: DateTime.parse(json["date"]),
    explanation: json["explanation"],
    mediaType: json["media_type"],
    serviceVersion: json["service_version"],
    title: json["title"],
    url: json["url"],
    copyright: json["copyright"],
    hdurl: json["hdurl"],
  );

  Map<String, dynamic> toJson() => {
    "date":
        "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "explanation": explanation,
    "media_type": mediaType,
    "service_version": serviceVersion,
    "title": title,
    "url": url,
    "copyright": copyright,
    "hdurl": hdurl,
  };
}

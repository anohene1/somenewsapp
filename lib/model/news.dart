import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class News extends ChangeNotifier {
  List<Article> articles = [];

  Future<void> fetchNews(String topic) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    final coordinates = Coordinates(position.latitude, position.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    String countryCode = addresses.first.countryCode;
    final response = await http.get(
        Uri.parse(
            "https://api.newscatcherapi.com/v2/latest_headlines?countries=$countryCode&topic=$topic"),
        headers: {'x-api-key': '9sMFtVKU3ZZsp3v1bkt6ouxJBDJGaY4PY-YgbQMgSBk'});

    final responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      responseJson['articles']
          .forEach((article) => articles.add(Article.fromJson(article)));

      notifyListeners();
    }
  }

  List<Article> get allNews {
    return articles;
  }
}

class Article {
  Article({
    required this.title,
    required this.author,
    required this.publishedDate,
    required this.link,
    required this.cleanUrl,
    required this.excerpt,
    required this.summary,
    required this.rank,
    // required this.authors,
    required this.media,
    required this.isOpinion,
    required this.twitterAccount,
    this.score,
    required this.id,
  });

  String title;
  String? author;
  DateTime publishedDate;
  String? link;
  String? cleanUrl;
  String? excerpt;
  String? summary;
  int? rank;
  // List<String> authors;
  String? media;
  bool? isOpinion;
  String? twitterAccount;
  dynamic score;
  String? id;

  String findTime(DateTime publishedDate) {
    final DateTime now = DateTime.now();
    final minuteDifference = now.difference(publishedDate).inMinutes;
    final hourDifference = now.difference(publishedDate).inHours;
    final DateFormat formatter = DateFormat.yMMMMd();
    final formattedDate = formatter.format(now);

    if (hourDifference > 24) {
      return formattedDate;
    }

    if (minuteDifference > 60) {
      if (hourDifference == 1) {
        return '$hourDifference hour ago';
      }
      return '$hourDifference hours ago';
    }

    if (minuteDifference == 1) {
      return '$minuteDifference minute ago';
    }
    return '$minuteDifference minutes ago';
  }

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        title: json["title"],
        author: json["author"] == null ? null : json["author"],
        publishedDate: DateTime.parse(json["published_date"]),
        link: json["link"],
        cleanUrl: json["clean_url"],
        excerpt: json["excerpt"],
        summary: json["summary"],
        rank: json["rank"],
        // authors: List<String>.from(json["authors"].map((x) => x)),
        media: json["media"],
        isOpinion: json["is_opinion"],
        twitterAccount:
            json["twitter_account"] == null ? null : json["twitter_account"],
        score: json["_score"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "author": author == null ? null : author,
        "published_date": publishedDate.toIso8601String(),
        "link": link,
        "excerpt": excerpt,
        "summary": summary,
        "rank": rank,
        // "authors": List<dynamic>.from(authors.map((x) => x)),
        "media": media,
        "is_opinion": isOpinion,
        "twitter_account": twitterAccount == null ? null : twitterAccount,
        "_score": score,
        "_id": id,
      };
}

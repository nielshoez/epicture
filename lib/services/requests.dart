import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_learn/models/users.dart';
import '../models/Image.dart';

class Request {
  Users user;
  int index;

  Request({this.index});
  void postImage(Users user, File image, String title, String description) async {
    var url = "https://api.imgur.com/3/image";

    List<int> imageBytes = image.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);

    var response = await post(url,
        headers: {
          "Authorization": "Bearer " + user.accessToken,
        },
        body: {
          "title": title,
          "description": description,
          "image": base64Image,
          "privacy": "Public",
        });
    Map data = jsonDecode(response.body);
    print(data['data']);
    // return (getLink(data));
  }

  void favoriteImage(Users user, String id) async {
    var url = "https://api.imgur.com/3/image/$id/favorite";

    var response = await post(url,
        headers: {
          "Authorization": "Bearer " + user.accessToken,
        });
    Map data = jsonDecode(response.body);
    print(data);
    // return (getLink(data));
  }
}
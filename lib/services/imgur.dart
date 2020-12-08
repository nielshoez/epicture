import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';

int pages = 0;
class Imgur {
  String link; // link for the image
  String filter; // search by (top / most viewed etc)
  String category;
  int index;

  Imgur({this.filter, this.index, this.category});

  Future<void> getData () async {
    if (index % 30 == 0)
      pages = pages + 1;
    var queryParameters = {
      'q': category,
    };
    var uri = Uri.https('api.imgur.com', '/3/gallery/search/$filter/$pages', queryParameters);
    try {
      Response response = await get(
        uri,
        headers: {HttpHeaders.authorizationHeader: "Client-ID 69f95c605501981"},
      );
      Map data = jsonDecode(response.body);
      if (data['data'][index]['is_album'] && data['data'][index]['is_album'] == true && data['data'][index]['images'] != null) {
        link = data['data'][index]['images'][0]['link'];

      } else if (data['data'][index]['type'] != null && data['data'][index]['type'] == "image/jpeg") {
        link = data['data'][index]['link'];
      } else {
        link = "https://i.pinimg.com/originals/0a/72/ef/0a72efd2abb871f9afb7d31b07142cb2.jpg";
      }
    } catch (e) {
      print(e);
      link = "https://i.pinimg.com/originals/0a/72/ef/0a72efd2abb871f9afb7d31b07142cb2.jpg";
    }
  }
}


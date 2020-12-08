import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

final tmpResponse = "https://imgur.com/#access_token=b3fed5334ce42622a3a6286e0909e0b3b9c8f38c&expires_in=315360000&token_type=bearer&refresh_token=2048ab193ad724169701a6ea017004e73ed597ea&account_username=lopes78chibre&account_id=139256175";
class Users {
  String accessToken;
  String typeToken;
  String refreshToken;
  String username;
  String id;
  String avatar;https://api.imgur.com/3/account/me/
  String reputation;
  String reputation_name;

  void parseResponse(String response) {
    this.accessToken = parseAccess(response);
    this.typeToken = parseTypeToken(response);
    this.refreshToken = parseRefreshToken(response);
    this.username = parseUsername(response);
    this.id = parseId(response);
    getUserInfo();
  }

  String parseAccess(String response) {
    const start = "access_token=";
    const end = "&expires_in";

    final startIndex = response.indexOf(start);
    final endIndex = response.indexOf(end, startIndex + start.length);

    return(response.substring(startIndex + start.length, endIndex));
  }

  String parseTypeToken(String response) {
    const start = "token_type=";
    const end = "&refresh_token";

    final startIndex = response.indexOf(start);
    final endIndex = response.indexOf(end, startIndex + start.length);

    return(response.substring(startIndex + start.length, endIndex));
  }

  String parseRefreshToken(String response) {
    const start = "refresh_token=";
    const end = "&account_username";

    final startIndex = response.indexOf(start);
    final endIndex = response.indexOf(end, startIndex + start.length);

    return(response.substring(startIndex + start.length, endIndex));
  }

  String parseUsername(String response) {
    const start = "account_username=";
    const end = "&account_id";

    final startIndex = response.indexOf(start);
    final endIndex = response.indexOf(end, startIndex + start.length);

    return(response.substring(startIndex + start.length, endIndex));
  }

  String parseId(String response) {
    const start = "account_id=";

    final startIndex = response.indexOf(start);

    return(response.substring(startIndex + start.length, response.length));
  }

  void getUserInfo() async {
    var url = 'https://api.imgur.com/3/account/me/account';

    var response = await get(url,
        headers: {
          "Authorization": "Bearer " + this.accessToken,
        });
    Map data = jsonDecode(response.body);

    this.avatar = data['data']['avatar'];
    this.reputation = data['data']['reputation'].toString();
    this.reputation_name = data['data']['reputation_name'];
  }
}
import 'package:flutter_learn/pages/loading.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter_learn/models/users.dart';

import '../models/Image.dart';
import '../models/ImagePage.dart';

const catalogLength = 200;
int pageCount = 0;
int pageCountHome = 0;
int pageCountFavorite = 0;

/// This function create an API call to user data on imgur

Future<ItemPage> fetchPage(int startingIndex, Users user) async {
  Map data = {};

  Response response = await get(
    'https://api.imgur.com/3/account/me/images',
    headers: {
      "Authorization": "Bearer " + user.accessToken,
    },
  );
  data = jsonDecode(response.body);

  if (startingIndex > catalogLength) {
    return ItemPage(
      items: [],
      startingIndex: startingIndex,
      hasNext: false,
    );
  }

  List<Item> itemList = [];
  data['data'].forEach((json) {
    if (json['is_album'] != null && json['is_album'] == true && json['images'] != null) {
      json['images'].forEach((image){
        if (image['type'] != null && image['type'] != "video/mp4") {
          itemList.add(Item(
              imgLink: image['link'],
              postLink: image['link'],
              title: image['title'],
              id: image['id']
          ));
        }
      });
    } else if(json['type'] != null && json['type'] != "video/mp4") {
      itemList.add(Item(
          imgLink: json['link'],
          postLink: json['link'],
          title: json['title'],
          id: json['id']
      ));
    }
  });

  // The page of items is generated here.
  return ItemPage(
    items: itemList,
    startingIndex: startingIndex,
    hasNext: startingIndex + itemsPerPage < catalogLength,
  );
}

Future<ItemPage> fetchPageHome(int startingIndex, Users user, String filter) async {
  if (index % 20 == 0)
    pageCountHome = pageCountHome + 1;
  Map data = {};


  Response response = await get(
    'https://api.imgur.com/3/gallery/$filter/viral/$pageCountHome',
    headers: {
      HttpHeaders.authorizationHeader: "Client-ID 69f95c605501981",
    },
  );
  data = jsonDecode(response.body);

  List<Item> itemList = [];
  data['data'].forEach((json) {
    if (json['is_album'] != null && json['is_album'] == true && json['images'] != null) {
      json['images'].forEach((image){
        if (image['type'] != null && image['type'] != "video/mp4") {
          itemList.add(Item(
            imgLink: image['link'],
            postLink: image['link'],
            title: image['title'],
            id: image['id']
          ));
        }
      });
    } else if(json['type'] != null && json['type'] != "video/mp4") {
      itemList.add(Item(
          imgLink: json['link'],
          postLink: json['link'],
          title: json['title'],
          id: json['id']
      ));
    }
  });


  if (startingIndex > catalogLength) {
    return ItemPage(
      items: [],
      startingIndex: startingIndex,
      hasNext: false,
    );
  }


  // The page of items is generated here.
  return ItemPage(
    items: itemList,
    startingIndex: startingIndex,
    hasNext: startingIndex + itemsPerPage < catalogLength,
  );
}


Future<ItemPage> fetchPageFavorite(int startingIndex, Users user) async {
  if (index % 20 == 0)
    pageCountHome = pageCountHome + 1;
  Map data = {};


  Response response = await get(
    'https://api.imgur.com/3/account/me/favorites/$pageCountFavorite',
    headers: {
      "Authorization": "Bearer " + user.accessToken,
    },
  );
  data = jsonDecode(response.body);

  List<Item> itemList = [];
  data['data'].forEach((json) {
    if (json['is_album'] != null && json['is_album'] == true &&
        json['images'] != null) {
      json['images'].forEach((image) {
        if (image['type'] != null && image['type'] != "video/mp4") {
          itemList.add(Item(
              imgLink: image['link'],
              postLink: image['link'],
              title: image['title'],
              id: image['id']
          ));
        }
      });
    } else if (json['type'] != null && json['type'] != "video/mp4") {
      itemList.add(Item(
          imgLink: json['link'],
          postLink: json['link'],
          title: json['title'],
          id: json['id']
      ));
    }
  });


  if (startingIndex > catalogLength) {
    return ItemPage(
      items: [],
      startingIndex: startingIndex,
      hasNext: false,
    );
  }


  // The page of items is generated here.
  return ItemPage(
    items: itemList,
    startingIndex: startingIndex,
    hasNext: startingIndex + itemsPerPage < catalogLength,
  );
}


///This function create an Imgur API call on search term. no user needed

Future<ItemPage> fetchPageSearch(int startingIndex, String search, String filter) async {
  if (index % 20 == 0)
    pageCount = pageCount+ 1;
  var queryParameters = {
    'q': search,
  };
  var uri;
  if (filter == 'new') {
    uri = Uri.https('api.imgur.com', '/3/gallery/search/top/week/$pageCount/', queryParameters);
  } else {
    uri = Uri.https('api.imgur.com', '/3/gallery/search/$filter/$pageCount/', queryParameters);
  }
  Response response = await get(
    uri,
    headers: {HttpHeaders.authorizationHeader: "Client-ID 69f95c605501981"},
  );
  Map data = jsonDecode(response.body);

  if (startingIndex > catalogLength) {
    return ItemPage(
      items: [],
      startingIndex: startingIndex,
      hasNext: false,
    );
  }

  List<Item> itemList = [];
  data['data'].forEach((json) {
    if (json['is_album'] != null && json['is_album'] == true && json['images'] != null) {
      json['images'].forEach((image){
        if (image['type'] != null && image['type'] != "video/mp4") {
          itemList.add(Item(
              imgLink: image['link'],
              postLink: image['link'],
              title: image['title'],
              id: image['id']
          ));
        }
      });
    } else if(json['type'] != null && json['type'] != "video/mp4") {
      itemList.add(Item(
          imgLink: json['link'],
          postLink: json['link'],
          title: json['title'],
          id: json['id']
      ));
    }
  });

  return ItemPage(
    items: itemList,
    startingIndex: startingIndex,
    hasNext: startingIndex + itemsPerPage < catalogLength,
  );
}
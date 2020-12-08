import 'package:flutter/material.dart';

class Item {
  final String imgLink;
  final String postLink;
  final String title;
  final String id;
  bool isLiked;
  Map data;

  Item({
    @required this.imgLink,
    @required this.postLink,
    @required this.title,
    @required this.id,
    this.isLiked = false,
  });

  Item.loading() : this(
    imgLink: "https://www.franceactive.org/wp-content/uploads/2017/11/default.png",
    postLink: "https://www.franceactive.org/wp-content/uploads/2017/11/default.png",
    title: "Pas de chance",
    id: "123456",
  );

  bool get isLoading => title == '...';
}
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_learn/services/imgur.dart';

int index = 0;
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  List<String> images = new List();
  ScrollController _scrollController = new ScrollController();

  void getImgur() async {
    index += 1;
    Imgur lopes = Imgur(filter: 'top', index: index, category: 'cats');
    await lopes.getData();
    images.add(lopes.link);
    setState(() {});
  }

  getFive() {
    for (int i = 0; i != 5; i++) {
      getImgur();
    }

  }
  @override
  void initState() {
    super.initState();
    getFive();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        getFive();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _scrollController,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int ImgIndex) {
          return Container (
            constraints: BoxConstraints.tightFor(height: 350),
            child: Image.network(images[ImgIndex], fit: BoxFit.fitWidth),
          );
        },
      )
    );
  }
}

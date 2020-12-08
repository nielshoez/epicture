import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'Image.dart';

const int itemsPerPage = 20;

class ItemPage {
  final List<Item> items;

  final int startingIndex;

  final bool hasNext;

  ItemPage({
    @required this.items,
    @required this.startingIndex,
    @required this.hasNext,
  });
}
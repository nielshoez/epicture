import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/models/users.dart';

import 'ImageFetch.dart';
import '../models/Image.dart';
import '../models/ImagePage.dart';


class Catalog extends ChangeNotifier {
  static const maxCacheDistance = 100;
  final Map<int, ItemPage> _pages = {};
  final Set<int> _pagesBeingFetched = {};
  int itemCount;
  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Item getByIndex(int index, Users user) {
    try {
      var startingIndex = (index ~/ itemsPerPage) * itemsPerPage;
      if (_pages.containsKey(startingIndex)) {
        var item = _pages[startingIndex].items[index - startingIndex];
        return item;
      }

      _fetchPage(startingIndex, user);

      return Item.loading();
    } catch (e) {
      return Item.loading();
    }
  }


  Future<void> _fetchPage(int startingIndex, Users user) async {
    if (_pagesBeingFetched.contains(startingIndex)) {
      return;
    }

    _pagesBeingFetched.add(startingIndex);
    final page = await fetchPage(startingIndex, user);
    _pagesBeingFetched.remove(startingIndex);

    if (!page.hasNext) {
      itemCount = startingIndex + page.items.length;
    }

    _pages[startingIndex] = page;
    _pruneCache(startingIndex);

    if (!_isDisposed) {
      notifyListeners();
    }
  }

  void _pruneCache(int currentStartingIndex) {
    final keysToRemove = <int>{};
    for (final key in _pages.keys) {
      if ((key - currentStartingIndex).abs() > maxCacheDistance) {
        keysToRemove.add(key);
      }
    }
    for (final key in keysToRemove) {
      _pages.remove(key);
    }
  }

  Item getByIndexHome(int index, Users user, String filter) {
    try {
      var startingIndex = (index ~/ itemsPerPage) * itemsPerPage;
      if (_pages.containsKey(startingIndex)) {
        var item = _pages[startingIndex].items[index - startingIndex];
        return item;
      }

      _fetchPageHome(startingIndex, user, filter);

      return Item.loading();
    } catch (e) {
      return Item.loading();
    }
  }


  Future<void> _fetchPageHome(int startingIndex, Users user, String filter) async {
    if (_pagesBeingFetched.contains(startingIndex)) {
      return;
    }

    _pagesBeingFetched.add(startingIndex);
    final page = await fetchPageHome(startingIndex, user, filter);
    _pagesBeingFetched.remove(startingIndex);

    if (!page.hasNext) {
      itemCount = startingIndex + page.items.length;
    }

    _pages[startingIndex] = page;
    _pruneCache(startingIndex);

    if (!_isDisposed) {
      notifyListeners();
    }
  }

  Item getByIndexFavorite(int index, Users user) {
    try {
      var startingIndex = (index ~/ itemsPerPage) * itemsPerPage;
      if (_pages.containsKey(startingIndex)) {
        var item = _pages[startingIndex].items[index - startingIndex];
        return item;
      }

      _fetchPageFavorite(startingIndex, user);

      return Item.loading();
    } catch (e) {
      return Item.loading();
    }
  }


  Future<void> _fetchPageFavorite(int startingIndex, Users user) async {
    if (_pagesBeingFetched.contains(startingIndex)) {
      return;
    }

    _pagesBeingFetched.add(startingIndex);
    final page = await fetchPageFavorite(startingIndex, user);
    _pagesBeingFetched.remove(startingIndex);

    if (!page.hasNext) {
      itemCount = startingIndex + page.items.length;
    }

    _pages[startingIndex] = page;
    _pruneCache(startingIndex);

    if (!_isDisposed) {
      notifyListeners();
    }
  }


  ///here is for the search terms no user needed

  Item getByIndexSearch(int index, String search, String filter) {
    try {
      var startingIndex = (index ~/ itemsPerPage) * itemsPerPage;
      if (_pages.containsKey(startingIndex)) {
        var item = _pages[startingIndex].items[index - startingIndex];
        return item;
      }

      _fetchPageSearch(startingIndex, search, filter);

      return Item.loading();
    } catch (e) {
      return Item.loading();
    }
  }


  Future<void> _fetchPageSearch(int startingIndex, String search, String filter) async {
    if (_pagesBeingFetched.contains(startingIndex)) {
      return;
    }

    _pagesBeingFetched.add(startingIndex);
    final page = await fetchPageSearch(startingIndex, search, filter);
    _pagesBeingFetched.remove(startingIndex);

    if (!page.hasNext) {
      itemCount = startingIndex + page.items.length;
    }

    _pages[startingIndex] = page;
    _pruneCache(startingIndex);

    if (!_isDisposed) {
      notifyListeners();
    }
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_learn/models/users.dart';
import 'package:flutter_learn/services/Catalog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_learn/models/ImageTile.dart';
import 'package:flutter_learn/models/Image.dart';


class Favorites extends StatefulWidget {
  final Users user;
  Favorites(this.user);
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  Users user;
  int currentIndex = 0;
  Map data = {};

  @override
  void initState() {
    // TODO: implement initState
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Catalog>(
        create: (context) => Catalog(),
        child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Favorites'),
              ),
              body: Selector<Catalog, int> (
                selector: (context, catalog) => catalog.itemCount,
                builder: (context, itemCount, child) => ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    var catalog = Provider.of<Catalog>(context);

                    var item = catalog.getByIndexFavorite(index, user);

                    if (item == null) {
                      item = Item.loading();
                    }
                    if (item.isLoading) {
                      return LoadingItemTile();
                    }

                    return ItemTile(item: item, user: user);
                  },
                ),
              ),
            )
        )
    );
  }
}
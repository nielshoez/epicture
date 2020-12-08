import 'package:flutter/material.dart';
import 'package:flutter_learn/models/users.dart';
import 'package:flutter_learn/services/requests.dart';
import 'package:flutter_learn/services/Catalog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_learn/models/ImageTile.dart';
import 'package:flutter_learn/models/Image.dart';



class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  Users imgurUser;
  int currentIndex = 0;
  Request request;
  Map data = {};

  void createData() async {
    data = ModalRoute.of(context).settings.arguments;
    imgurUser = data['user'];
  }


  @override
  Widget build(BuildContext context) {
    createData();
    return ChangeNotifierProvider<Catalog>(
        create: (context) => Catalog(),
        child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                title: Text('in userList'),
              ),
              body: Selector<Catalog, int> (
                selector: (context, catalog) => catalog.itemCount,
                builder: (context, itemCount, child) => ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    var catalog = Provider.of<Catalog>(context);

                    var item = catalog.getByIndex(index, imgurUser);

                    if (item == null) {
                      item = Item.loading();
                    }
                    if (item.isLoading) {
                      return LoadingItemTile();
                    }

                    return ItemTile(item: item);
                  },
                ),
              ),
            )
        )
    );
  }
}


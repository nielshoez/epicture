import 'package:flutter/material.dart';
import 'package:flutter_learn/models/users.dart';
import 'package:flutter_learn/services/requests.dart';
import 'package:flutter_learn/services/Catalog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_learn/models/ImageTile.dart';
import 'package:flutter_learn/models/Image.dart';



class HomePage extends StatefulWidget {
  final Users user;
  HomePage(this.user);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Users imgurUser;
  int currentIndex = 0;
  Request request;
  Map data = {};
  String dropdownValue = 'hot';

  void createData() async {
    imgurUser = widget.user;
  }


  @override
  Widget build(BuildContext context) {
    createData();
    return ChangeNotifierProvider<Catalog>(
        create: (context) => Catalog(),
        child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Home'),
                actions: [
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                      setState(() {});
                    },
                    items: <String>['hot', 'top']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              body: Selector<Catalog, int> (
                selector: (context, catalog) => catalog.itemCount,
                builder: (context, itemCount, child) => ListView.builder(
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    var catalog = Provider.of<Catalog>(context);

                    var item = catalog.getByIndexHome(index, imgurUser, dropdownValue);

                    if (item == null) {
                      item = Item.loading();
                    }
                    if (item.isLoading) {
                      return LoadingItemTile();
                    }

                    return ItemTile(item: item, user: imgurUser);
                  },
                ),
              ),
            )
        )
    );
  }
}


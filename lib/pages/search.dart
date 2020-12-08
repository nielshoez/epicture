import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_learn/models/users.dart';
import 'package:flutter_learn/services/Catalog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_learn/models/ImageTile.dart';
import 'package:flutter_learn/models/Image.dart';

class Search extends StatefulWidget {
  final Users user;
  Search(this.user);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Users user;
  String dropdownValue = 'top';
  @override
  void initState() {
    user = widget.user;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter a search term',
              suffixIcon: DropdownButton<String>(
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
                },
                items: <String>['top', 'viral', 'new']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
          ),
          onSubmitted: (value) {
            print('Value submitted');
            Navigator.pushNamed(context, '/search', arguments: {
              'value': value,
              'filter': dropdownValue,
              'user': user,
            });
          },
        ),
      ),
    );
  }
}

class ShowSearch extends StatefulWidget {
  @override
  _ShowSearchState createState() => _ShowSearchState();
}

class _ShowSearchState extends State<ShowSearch> {
  Map data = {};
  String value;
  String filter;
  Users user;

  void createData() async {
    data = ModalRoute.of(context).settings.arguments;
    value = data['value'];
    filter = data['filter'];
    user = data['user'];
  }

  @override
  Widget build(BuildContext context) {
    createData();
    return ChangeNotifierProvider<Catalog>(
        create: (context) => Catalog(),
        child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                title: Text(value),
              ),
              body:
                  Selector<Catalog, int> (
                    selector: (context, catalog) => catalog.itemCount,
                    builder: (context, itemCount, child) => ListView.builder(
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        var catalog = Provider.of<Catalog>(context);

                        var item = catalog.getByIndexSearch(index, value, filter);

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




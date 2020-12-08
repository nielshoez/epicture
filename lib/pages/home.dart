import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter_learn/pages/homePage.dart';
import 'package:flutter_learn/pages/userList.dart';
import 'package:flutter_learn/pages/search.dart';
import 'package:flutter_learn/pages/favorites.dart';
import 'package:flutter_learn/pages/addImage.dart';
import 'package:flutter_learn/models/users.dart';
import 'package:flutter_learn/pages/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;
  Users imgurUser;
  List<Widget> _children = [];
  Map data = {};

  void createData() async {
    data = ModalRoute.of(context).settings.arguments;
    imgurUser = data['user'];
    _children = [
      HomePage(imgurUser),
      Search(imgurUser),
      Favorites(imgurUser),
      AddImage(imgurUser),
      UserPage(imgurUser),
    ];
  }

  @override
  Widget build(BuildContext context) {
    createData();
    return Scaffold(
      body:  _children[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) => setState(() {
          _currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.star),
            title: Text('Favorites'),
            activeColor: Colors.yellow,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.add_photo_alternate_outlined),
            title: Text('Upload'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('User'),
            activeColor: Colors.black,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

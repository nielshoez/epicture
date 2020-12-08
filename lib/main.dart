import 'package:flutter/material.dart';
import 'package:flutter_learn/pages/userList.dart';
import 'package:flutter_learn/services/auth.dart';
import 'package:flutter_learn/pages/home.dart';
import 'package:flutter_learn/pages/search.dart';

void main() => runApp(MaterialApp(
 initialRoute: '/auth',
  routes: {
    '/home': (context) => Home(),
    '/auth':(context) => Auth(),
    '/search':(context) => ShowSearch(),
    '/userList':(context) => UserList(),
  },
));
import 'package:flutter/material.dart';
import 'package:flutter_learn/models/users.dart';
import 'package:flutter_learn/pages/userList.dart';
import 'package:flutter_learn/services/requests.dart';

class UserPage extends StatefulWidget {
  final Users user;
  UserPage(this.user);
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Users user;
  String userReputation;
  String userReputation_name;

  @override
  void initState() {
    user = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      title: new Text(user.username),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 120),
              child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 40.0,
              child: CircleAvatar(
                radius: 38.0,
                child: ClipOval(
                  child: Image.network(user.avatar),
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ),
          ),
          Container(
            height: 70,
            width: 145,
            //color: Colors.purple,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: Text("Reputation: ${user.reputation}",
                style: TextStyle(fontSize: 20)),
          ),
          Container(
            height: 70,
            width: 145,
            //color: Colors.purple,
            alignment: Alignment.centerRight,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: Text("Type: ${user.reputation_name}",
                style: TextStyle(fontSize: 20)),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/userList', arguments: {
                  'user': user,
                });
              },
              child: Text('My Pictures'),
            )
    ],
      ),
    );
  }
}
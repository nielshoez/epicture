import 'package:flutter/material.dart';
import 'package:flutter_learn/services/requests.dart';
import 'package:flutter_learn/models/users.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'Image.dart';


class ItemTile extends StatelessWidget {
  final Item item;
  final Users user;
  bool isLiked = false;
  Request request = Request(index: 0);
  final FlareControls flareControls = FlareControls();
  ItemTile({@required this.item, this.user, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onDoubleTap: () {
            item.isLiked = true;
            print("liked : ${item.title}, ${item.id}");
            request.favoriteImage(user, item.id);
            flareControls.play("like");
          },
          child: Stack(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(item.imgLink)
            ),
            Container(
              height: 240,
              child: Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: FlareActor(
                    'assets/instagram_like.flr',
                    controller: flareControls,
                    animation: 'idle',
                  ),
              ),
            ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class LoadingItemTile extends StatelessWidget {
  const LoadingItemTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: AspectRatio(
          aspectRatio: 1,
          child: Placeholder(),
        ),
      ),
    );
  }
}
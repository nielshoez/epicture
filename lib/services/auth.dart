import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_learn/models/users.dart';

final selectedUrl = "https://api.imgur.com/oauth2/authorize?client_id=69f95c605501981&response_type=token";


class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  StreamSubscription<String> authUrl;
  StreamSubscription<WebViewStateChanged> stateChangeWeb;
  Users imgurUser = Users();

  void createUser(String url) {
    imgurUser.parseResponse(url);
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'user': imgurUser
    });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stateChangeWeb = flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged lopes) {
      if (mounted) {
        setState(() {});
        createUser(lopes.url);
      }
    });
    authUrl = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {});
        createUser(url);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    authUrl.cancel();
    flutterWebViewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: selectedUrl,
      mediaPlaybackRequiresUserGesture: false,
      appBar: AppBar(
        title: const Text('Widget WebView'),
      ),
      hidden: true,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 'Feed Screen'.text.makeCentered(),
    );
  }
}

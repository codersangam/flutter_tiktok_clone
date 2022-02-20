import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 'Post Screen'.text.makeCentered(),
    );
  }
}

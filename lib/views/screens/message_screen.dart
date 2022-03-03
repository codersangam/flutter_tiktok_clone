import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 'Message Screen'.text.make(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SmsFeed extends StatefulWidget {
  const SmsFeed({Key? key}) : super(key: key);

  @override
  State<SmsFeed> createState() => _SmsFeedState();
}

class _SmsFeedState extends State<SmsFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'main.dart';

class Window_2 extends StatelessWidget {
  const Window_2({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text(text)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (c) => MyApp()));
        },
      ),
    );
  }
}

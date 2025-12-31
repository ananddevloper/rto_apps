import 'package:flutter/material.dart';

class Spleshscreen extends StatefulWidget {
  const Spleshscreen({super.key});

  @override
  State<Spleshscreen> createState() => _SpleshscreenState();
}

class _SpleshscreenState extends State<Spleshscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRO EXAM'),
      ),
    );
  }
}
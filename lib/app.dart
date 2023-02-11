import 'package:flutter/material.dart';

import 'package:guitar/scales/screen.dart';

class GuitarApp extends StatelessWidget {
  const GuitarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guitar Scales Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const ScaleScreen(title: 'Guitar Scales'),
    );
  }
}

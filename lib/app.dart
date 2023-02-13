import 'package:flutter/material.dart';

import 'package:guitar/scales/screen.dart';

class GuitarApp extends StatelessWidget {
  const GuitarApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GuitarApp',
      home: const ScaleScreen(title: 'Guitar Scales'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}

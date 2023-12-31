import 'package:concurrency_demo/screen/photo_screen.dart';
import 'package:concurrency_demo/screen/task_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      
      debugShowCheckedModeBanner: false,
      //home: TaskScreen(),
      home: PhotoScreen(),
    );
  }
}

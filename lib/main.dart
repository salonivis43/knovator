import 'package:flutter/material.dart';
import 'screens/post_list_screen.dart';

void main() {
  runApp(PostListApp());
}

class PostListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner
      title: 'Post List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostListScreen(),
    );
  }
}

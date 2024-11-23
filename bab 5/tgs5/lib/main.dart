import 'package:flutter/material.dart';
import 'list_book.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Buku',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BooksListScreen(),
    );
  }
}
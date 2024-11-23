import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  DetailScreen({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail News'),
      ), // AppBar
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl, // Tambahkan URL dasar di sini
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.broken_image, size: 100),
              ), // Image.network
              SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ), // TextStyle
              ), // Text
              SizedBox(height: 16),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                ), // TextStyle
              ), // Text
            ], // <Widget>[]
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}

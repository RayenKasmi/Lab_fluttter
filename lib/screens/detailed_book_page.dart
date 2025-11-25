import 'package:flutter/material.dart';
import 'package:tp0/models/book.dart';
import 'package:tp0/widgets/detailed_book.dart';

class DetailedBookPage extends StatelessWidget {

  final String title;
  final Book book;

  const DetailedBookPage({super.key, required this.title, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ) ,
          ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 34, 99, 238),
      ),
      body: BookDetailPage(book: book),
    );
  }
}
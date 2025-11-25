import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp0/models/book.dart';
import 'package:tp0/screens/detailed_book_page.dart';
import 'package:tp0/widgets/detailed_book.dart';
import '../services/book_service.dart';
import '../widgets/book_container.dart';

class BookSlide extends StatelessWidget {
  final String title;
  
  const BookSlide({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    return FutureBuilder<List<Book>>(
        future: BookService.loadBooksFromAssets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final books = snapshot.data ?? [];
          // Use ListView.builder for an efficient, scrollable column of cards.
          return 
          /*GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 12,
              childAspectRatio: 0.8, // Width / height ratio of each tile
            ), 
            itemCount: books.length,
            itemBuilder: (context, index) {
              return BookCard(book: books[index], currencyFormat: currency);
            }
          );*/
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: books.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailedBookPage(title: title, book: books[index])
                      )
                  );
                },
                child: BookCard(book: books[index], currencyFormat: currency),
              )
              ;
            },
          );
        },
    );
  }
}

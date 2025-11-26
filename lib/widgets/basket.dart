import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tp0/models/book.dart';
import 'package:tp0/services/database_helper.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {

  @override
  Widget build(BuildContext context) {
    return 
    FutureBuilder<List<Book>>(
        future: DatabaseHelper().fetchBasketBooks(), // The async task
        builder: (context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final books = snapshot.data!;
          if (books.isEmpty) {
            return const Center(child: Text("Basket is empty"));
          }

          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 110,
                      height: 160,
                      child: _buildImage(books[index].image),
                    ),
                  ), 
                  title: Text(books[index].name),
                  subtitle: Text("${books[index].price} TND"),
                ),
              );
            },
          );
        },
    );
  }

  Widget _buildImage(path) {
    return CachedNetworkImage(
      imageUrl: path,
      fit: BoxFit.fitHeight,
      placeholder: (context, url) => Container(
        color: Colors.grey[200],
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey[200],
        child: const Center(child: Icon(Icons.broken_image)),
      ),
    );
  }
}
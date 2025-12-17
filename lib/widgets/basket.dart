import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tp0/models/book.dart';
import 'package:tp0/services/database_helper.dart';
import 'package:tp0/services/firebase_service.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {

  @override
  Widget build(BuildContext context) {
    return 
    /*
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
    );*/
  StreamBuilder<QuerySnapshot>(
  stream: FireStoreService().getBooksStream(), // Listening to the stream
  builder: (context, snapshot) {
    
    if (snapshot.hasError) {
      return const Text('Something went wrong');
    }

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const CircularProgressIndicator();
    }

    // Reactivity happens here: whenever DB changes, this rebuilds automatically
    final data = snapshot.requireData;
    
        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            var bookData = data.docs[index];
            return Card(
              child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 110,
                      height: 160,
                      child: _buildImage(bookData["image"]),
                    ),
                  ), 
                  title: Text(bookData["name"]),
                  subtitle: Text("${bookData["price"]} TND"),
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
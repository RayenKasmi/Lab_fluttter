import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tp0/models/book.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  late double bookPrice;
  bool is_discount_applied = false;

  @override
  void initState() {
    super.initState();
    bookPrice = widget.book.price;
  }

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.currency(locale: 'en_US', symbol: '\$');

    return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: widget.book.image,
                height: 280,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            // Title
            Text(
              widget.book.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 16),

            // Price
            Text(
              currency.format(bookPrice),
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 0, 0),
              ),
            ),

            const SizedBox(height: 24),

            // Optional description placeholder
            Text(
              "This is a detailed description of the book.\n"
              "You can add more info such as author, rating, etc.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text("Back to Catalogue"),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  if(!is_discount_applied){
                    bookPrice = bookPrice*0.8;
                    is_discount_applied = true;
                  }
                });
              }, 
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(!is_discount_applied ? Colors.red : Colors.green)
              ),
              child: Text(!
                is_discount_applied ? "20% Discount!!!!" : "Discount Applied",
                style: TextStyle(
                ),
              ),
            ),
          ],
        ),
      );
  }
}

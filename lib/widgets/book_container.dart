import 'package:flutter/material.dart';
import 'package:intl/intl.dart';               // for currency formatting
import '../models/book.dart';
import 'package:cached_network_image/cached_network_image.dart'; // optional

class BookCard extends StatelessWidget {
  final Book book;
  final NumberFormat currencyFormat;

  BookCard({
    super.key,
    required this.book,
    NumberFormat? currencyFormat,
  }) : currencyFormat = currencyFormat ?? NumberFormat.currency(locale: 'en_US', symbol: '\$');

  @override
  Widget build(BuildContext context) {
    // Card gives material effect; Container inside for custom decoration
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          // subtle "post-it" feel
          color: const Color.fromARGB(255, 56, 148, 235),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Image block
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 110,
                height: 160,
                child: _buildImage(),
              ),
            ),

            const SizedBox(width: 12),

            // Text block (name + price)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    book.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 50),

                  // Price aligned to the left under name
                  Center(
                    child: Text(
                      currencyFormat.format(book.price),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    // If cached_network_image is available use it for caching & placeholders.
    // If you didn't add cached_network_image, replace with Image.network(...)
    return CachedNetworkImage(
      imageUrl: book.image,
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

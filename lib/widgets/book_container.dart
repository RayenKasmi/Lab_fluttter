import 'package:flutter/material.dart';
import 'package:intl/intl.dart';               // for currency formatting
import 'package:tp0/services/generate_random_color.dart';
import '../models/book.dart';
import 'package:cached_network_image/cached_network_image.dart'; // optional

class BookCard extends StatefulWidget {
  final Book book;
  final NumberFormat currencyFormat;

  BookCard({
    super.key,
    required this.book,
    NumberFormat? currencyFormat,
  }) : currencyFormat = currencyFormat ?? NumberFormat.currency(locale: 'en_US', symbol: '\$');

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> {
  Color cardColor = Color.fromARGB(255, 56, 148, 235);

  @override
  Widget build(BuildContext context) {
    // Card gives material effect; Container inside for custom decoration
    return InkWell(
      onTap:() => {
        setState(() {
          cardColor = getRandomColor();
        })
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor ,
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
                      widget.book.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 50),
      
                    Center(
                      child: Text(
                        widget.currencyFormat.format(widget.book.price),
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
      ),
    );
  }

  Widget _buildImage() {
    return CachedNetworkImage(
      imageUrl: widget.book.image,
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

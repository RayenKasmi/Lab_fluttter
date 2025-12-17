import 'package:flutter/material.dart';
import '../models/quote.dart';
import '../services/quote_service.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  late Future<Quote> _quoteFuture;

  @override
  void initState() {
    super.initState();
    _quoteFuture = QuoteService.fetchQuote();
  }

  // Method to refresh and fetch a new quote
  void _fetchNewQuote() {
    setState(() {
      _quoteFuture = QuoteService.fetchQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<Quote>(
            future: _quoteFuture,
            builder: (context, snapshot) {
              // Handle loading state
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text(
                      'Loading quote...',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                );
              }
              // Handle error state
              else if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _fetchNewQuote,
                      child: const Text('Try Again'),
                    ),
                  ],
                );
              }
              // Handle success state - display quote
              else if (snapshot.hasData) {
                final quote = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.format_quote,
                      size: 60,
                      color: Color.fromARGB(255, 34, 99, 238),
                    ),
                    const SizedBox(height: 30),
                    // Display quote text
                    Text(
                      '"${quote.text}"',
                      style: const TextStyle(
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    // Display author
                    Text(
                      '- ${quote.author}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 34, 99, 238),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: _fetchNewQuote,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Get New Quote'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 34, 99, 238),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                      ),
                    ),
                  ],
                );
              }
              // Fallback for no data
              else {
                return const Text('No quote available');
              }
            },
          ),
        ),
      ),
    );
  }
}

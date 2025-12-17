import 'package:flutter/material.dart';
import '../models/quote.dart';
import '../services/quote_service.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  late Future<List<Quote>> _quotesFuture;

  @override
  void initState() {
    super.initState();
    _quotesFuture = QuoteService.fetchQuotes();
  }

  // Method to refresh and fetch new quotes
  void _fetchNewQuotes() {
    setState(() {
      _quotesFuture = QuoteService.fetchQuotesRetrofit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Quote>>(
        future: _quotesFuture,
        builder: (context, snapshot) {
          // Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text(
                    'Loading quotes...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          }
          // Handle error state
          else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
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
                      onPressed: _fetchNewQuotes,
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }
          // Handle success state - display multiple quotes using ListView.builder
          else if (snapshot.hasData) {
            final quotes = snapshot.data!;
            
            // Show message if no quotes available
            if (quotes.isEmpty) {
              return const Center(
                child: Text('No quotes available'),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: quotes.length,
                    itemBuilder: (context, index) {
                      final quote = quotes[index];
                      
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Quote number badge
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 34, 99, 238),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Quote ${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Display quote text
                              Text(
                                '"${quote.text}"',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // Display author
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    size: 20,
                                    color: Color.fromARGB(255, 34, 99, 238),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      quote.author,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 34, 99, 238),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _fetchNewQuotes,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Get New Quotes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 34, 99, 238),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                )
              ],
            );
          }
          // Fallback for no data
          else {
            return const Center(
              child: Text('No quotes available'),
            );
          }
        },
      ),
    );
  }
}

import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/quote.dart';
import 'package:http/http.dart' as http;
import 'quote_api_client.dart';


class QuoteService {
  static const address = 'https://zenquotes.io/api/random';
  static const addressMult = 'https://zenquotes.io/api/quotes';

  static Future<List<Quote>> fetchQuotes() async {
    // Create Dio instance - Cleaner code, better error handling
    Dio dio = Dio();

    try {
      final response = await dio.get(addressMult);

      if (response.statusCode == 200) {
        // Response.data is already parsed - Dio auto-parses JSON
        final List quotesJson = response.data;

        List<Quote> quotes = quotesJson
            .map((quoteJson) => Quote.fromJSON(quoteJson))
            .toList();

        return quotes;
      } else {
        throw Exception('Failed to load quotes');
      }
    } on DioException catch (e) {
      // Dio provides better error handling
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout');
      } else if (e.response != null) {
        throw Exception('Server error: ${e.response?.statusCode}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    }
  }

  //http version
  static Future<Quote> fetchQuote() async {

    final Uri url = Uri.parse(address);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Convert JSON string → Dart List
      final List quoteJson = json.decode(response.body);

      // Convert Map → Quote object
      Quote quote = Quote.fromJSON(quoteJson[0]);
      
      return quote;
    } else {
      throw Exception('Failed to load quote');
    }
  }

  // Retrofit version - Type-safe API client with code generation
  static Future<List<Quote>> fetchQuotesRetrofit() async {
    // Create Dio instance with base configuration
    Dio dio = Dio();

    try {
      // Create Retrofit client
      final client = QuoteApiClient(dio);

      // Make type-safe API call - Retrofit handles serialization!!
      List<Quote> quotes = await client.getQuotes();

      return quotes;
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout');
      } else if (e.response != null) {
        throw Exception('Server error: ${e.response?.statusCode}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to load quotes: $e');
    }
  }
}

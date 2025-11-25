import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/book.dart';

class BookService {
  static List<Book>? _cache;

  static Future<List<Book>> loadBooksFromAssets() async {
    if (_cache != null) return _cache!;

    final jsonString = await rootBundle.loadString('assets/data/books.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);

    _cache = jsonList.map((e) => Book.fromJson(e)).toList();
    return _cache!;
  }

  static Future<Book?> findBookFromAssests(int id) async {
    List<Book> books =  await loadBooksFromAssets();
    try {
      return books.firstWhere((book) => book.id == id);
    } catch (e) {
      return null;
    }
  }
}



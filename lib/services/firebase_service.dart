import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final CollectionReference booksCollection = 
      FirebaseFirestore.instance.collection('books');

  // STREAM: This keeps the connection open
  Stream<QuerySnapshot> getBooksStream() {
    return booksCollection.snapshots();
  }

  Future<void> addBook(String name, double price, String path) {
    return booksCollection.add({
      'name': name,
      'price': price,
      'image': path 
    });
  }
}
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tp0/models/book.dart';

class DatabaseHelper {
  // Singleton pattern logic
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'FDTP.db');

    return await openDatabase(path, version: 1,
      onCreate: (db, version) async {
        // Create the 'book' table
        await db.execute(
          "CREATE TABLE IF NOT EXISTS book(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, price REAL, image TEXT)"
        );
      },
    );
  }

  Future<void> insertBook(Book book) async {
    final db = await database;
    
    await db.transaction((txn) async {
      await txn.rawInsert(
        "INSERT INTO book(name, price, image) VALUES(?, ?, ?)",
        [book.name, book.price, book.image]
      );
    });
    print("Book added: ${book.name}");
  }

  // 3. Fetch all Books
  Future<List<Book>> fetchBasketBooks() async {
    final db = await database;
    List<Book> books = [];
    
    await db.transaction((txn) async {
      // Get the raw list of maps
      List<Map> list = await txn.rawQuery("SELECT * FROM book");
      
      // Convert Map to Book objects
      for (var element in list) {
        books.add(Book(
          id: element["id"] as int,
          name: element["name"] as String,
          image: element["image"].toString(),
          price: element["price"],
        ));
      }
    });
    return books;
  }
  
  // Optional: Delete all books (for testing)
  Future<void> deleteAll() async {
    final db = await database;
    await db.rawDelete("DELETE FROM book");
  }
}
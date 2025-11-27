import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../views/cart/model/cart_model.dart';

class CartDatabaseHelper {
  static final CartDatabaseHelper _instance = CartDatabaseHelper._();
  static Database? _database;

  CartDatabaseHelper._();

  factory CartDatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cart_items.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart_items(
            id TEXT PRIMARY KEY,
            name TEXT,
            price TEXT,
            main_price TEXT,
            shipment_type TEXT,
            offer_price TEXT,
            image TEXT,
            quantity INTEGER,
            available_quantity TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertCartItem(CartDatum item) async {
    final db = await database;
    await db.insert(
      'cart_items',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CartDatum>> getAllCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart_items');
    return maps.map((map) => CartDatum.fromMap(map)).toList();
  }

  Future<void> updateCartItem(CartDatum item) async {
    final db = await database;
    await db.update(
      'cart_items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<void> deleteCartItem(String id) async {
    final db = await database;
    await db.delete(
      'cart_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart_items');
  }
}

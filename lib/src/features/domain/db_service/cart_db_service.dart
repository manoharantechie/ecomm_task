import 'package:e_comm/src/features/data/product_model.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const cartTable = 'cart';

@singleton
class CartDatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $cartTable (
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER NOT NULL,
        title TEXT NOT NULL,
        price TEXT NOT NULL,
        image TEXT NOT NULL,
        count INTEGER NOT NULL
      )
    ''');
  }

  Future<void> addToCart(ProductDetails product) async {
    final db = await database;

    final existing = await db.query(
      cartTable,
      where: 'productId = ?',
      whereArgs: [product.id],
    );

    if (existing.isNotEmpty) {
      final currentCount = existing.first['count'] as int;
      await db.update(
        cartTable,
        {
          'count': currentCount + 1,
        },
        where: 'productId = ?',
        whereArgs: [product.id],
      );
    } else {
      await db.insert(cartTable, {
        'productId': product.id,
        'title': product.title,
        'price': product.price,
        'image': product.image,
        'count': 1,
      });
    }
  }

  Future<void> removeFromCart(int productId) async {
    final db = await database;

    final existing = await db.query(
      cartTable,
      where: 'productId = ?',
      whereArgs: [productId],
    );

    if (existing.isNotEmpty) {
      final currentCount = existing.first['count'] as int;
      if (currentCount > 1) {
        await db.update(
          cartTable,
          {
            'count': currentCount - 1,
          },
          where: 'productId = ?',
          whereArgs: [productId],
        );
      } else {
        await db.delete(
          cartTable,
          where: 'productId = ?',
          whereArgs: [productId],
        );
      }
    }
  }

  Future<List<Map<String, dynamic>>> readCartItems() async {
    final db = await database;
    return await db.query(cartTable);
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete(cartTable);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}

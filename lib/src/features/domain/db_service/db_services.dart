
import 'package:e_comm/src/features/data/product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;
  var db;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('ecomm.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath;

    dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE products (
      _id INTEGER PRIMARY KEY AUTOINCREMENT,
      isImportant BOOLEAN NOT NULL,
      title TEXT NOT NULL,
      price TEXT NOT NULL,
      description TEXT NOT NULL,
      category TEXT NOT NULL,
      image TEXT NOT NULL,
      rate TEXT NOT NULL,
      count TEXT NOT NULL
    )
  ''');
  }

  Future<ProductDetails> create(ProductDetails product) async {
    final db = await instance.database;
    final id = await db.insert(prdTable, product.toJson());
    return product.copy(id: id);
  }

  Future<ProductDetails> readproduct({required int id}) async {
    final db = await instance.database;

    final maps = await db.query(
      prdTable,
      columns: ProductFields.values,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ProductDetails.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<ProductDetails>> readAllList() async {
    final db = await instance.database;
    final result = await db.query(prdTable,);

    return result.map((json) => ProductDetails.fromJson(json)).toList();
  }

  Future<int> update({required ProductDetails product}) async {
    final db = await instance.database;

    return db.update(
      prdTable,
      product.toJson(),
      where: '${ProductFields.id} = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> delete({required int id}) async {
    final db = await instance.database;

    return await db.delete(
      prdTable,
      where: '${ProductFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future<void> truncateTable(String tableName) async {
    final db = await instance.database;
    await db.transaction((txn) async {
      await txn.delete(tableName);
      await txn.rawDelete("DELETE FROM sqlite_sequence WHERE name = ?", [tableName]);
    });
  }

}

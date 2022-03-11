import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../data/product.dart';

class DbHelper {
//  static final DbHelper _instance = DbHelper.internal();
//
//  factory DbHelper() => _instance;
//
//  DbHelper.internal();

  static Database _db;

  Future<Database> createDatabase() async {
    if (_db != null) {
      return _db;
    }
    //define the path to the database
    String path = join(await getDatabasesPath(), 'extenses.db');
    _db = await openDatabase(path, version: 1, onCreate: (Database db, int v) {
      //create all tables
      db.execute(
          "create table extenses(id integer primary key autoincrement, title Text, price Real, number integer , date Text , week Text)");
    });
    return _db;
  }

  Future<int> createProduct(Product data) async {
    Database db = await createDatabase();
    //db.rawInsert('insert into courses')
    return db.insert('extenses', data.toMap());
  }

  Future<List> allProducts() async {
    Database db = await createDatabase();
    //db.rawQuery("select * from courses")
    return db.query('extenses');
  }

  Future<int> deleteProduct(int id) async {
    Database db = await createDatabase();
    return db.delete('extenses', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> cleanDatabase() async {
    try {
      final db = await createDatabase();
      await db.transaction((txn) async {
        var batch = txn.batch();
        batch.delete('extenses');
        await batch.commit();
      });
    } catch (error) {
      throw Exception('DbBase.cleanDatabase: ' + error.toString());
    }
  }

//  Future<int> getCount() async {
//    Database db = await createDatabase();
//    List<Map<String, dynamic>> x =
//    await db.rawQuery('select count (*) from extenses');
//    int result = Sqflite.firstIntValue(x);
//    return result;
//  }

  Future<List<Product>> getProductList() async {
    var productMapList = await allProducts();
    int count = productMapList.length;
    List<Product> productList = [];
    for (int i = 0; i < count; i++) {
      productList.add(Product.fromMapObject(productMapList[i]));
    }
    return productList;
  }
}

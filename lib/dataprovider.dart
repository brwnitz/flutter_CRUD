import 'package:flutter_treinamento/product.dart';
import 'package:flutter_treinamento/databasehelper.dart';

class DataProvider{
  DatabaseHelper db = DatabaseHelper();

  void addItem(Product product) async {
    var dbClient = await db.database;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
        'INSERT INTO products(name, price, description) VALUES("${product.name}", ${product.price}, "${product.description}")'
      );
    });
  }

  void deleteItem(int id) async{
    var dbClient = await db.database;
    await dbClient.transaction((txn) async {
      return await txn.rawDelete('DELETE FROM products WHERE id = $id');
    });
  }

  void updatedItem(Product updatedProduct) async{
    var dbClient = await db.database;
    await dbClient.transaction((txn)async{
      return await txn.rawUpdate('''
        UPDATE products
        SET name = "${updatedProduct.name}",
            price = ${updatedProduct.price},
            description = "${updatedProduct.description}"
        WHERE id = ${updatedProduct.id}
      ''');
    });
  }

  Future<List<Product>> getItems() async{
    var dbClient = await db.database;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM products');
    List<Product> products = [];
    for(int i = 0; i < list.length; i++){
      products.add(Product(
        id: list[i]['id'],
        name: list[i]['name'],
        price: list[i]['price'],
        description: list[i]['description'],
      ));
    }
    return Future.value(products);
  }
}
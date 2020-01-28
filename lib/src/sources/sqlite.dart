import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../mixins/jsonModel.dart';

class SqlLite {
  main() async {
    return openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'feiradolivro.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE feiralivro(json TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<void> insertData(JsonModel json) async {
    // Get a reference to the database.
    final Database db = await main();

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await getData().then((List<Map<String, dynamic>> maps) async => {
          if (maps.isEmpty)
            {
              await db.insert(
                'feiralivro',
                json.toMap(),
                conflictAlgorithm: ConflictAlgorithm.replace,
              )
            }
          else
            {
              await db.update(
                'feiralivro',
                json.toMap(),
              )
            }
        });
  }

  Future<List<Map<String, dynamic>>> getData() async {
    // Get a reference to the database.
    final Database db = await main();

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('feiralivro');
    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return maps;
  } //JsonModel(maps.isNotEmpty ? maps.first.values.first.toString() : '')
}

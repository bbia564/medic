import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

class DatabaseService extends GetxService {
  late Database db;

  Future<DatabaseService> init() async {
    await initDB();
    return this;
  }

  initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes_db.db');

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      print('==============================================');
      await createTable(db);
      await createDefaultData(db);
    });
  }

  createTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS tea (id INTEGER PRIMARY KEY, title TEXT, evaluation TEXT, image TEXT, experience TEXT, time TEXT)');
  }

  createDefaultData(Database db) async {
    final titles = ['Quercetin','Caltrate','Claritin'];
    final times = ['07:00 AM', '11:00 AM', '18:00 PM'];
    for (var i = 0; i < 3; i++) {
      db.insert(
        'tea',
        {
          'title': titles[i],
          'evaluation': '${faker.randomGenerator.integer(3, min: 1)} pieces',
          'image': 'assets/images/icon$i.webp',
          'experience': 'flaking',
          'time': times[i]
        },
      );
    }
  }

  insert(Tea tea) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes_db.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    await db.insert('tea', {
      'title': tea.title,
      'evaluation': tea.evaluation,
      'image': tea.image,
      'experience': tea.experience,
      'time': tea.time
    });
  }

  update(Tea tea) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes_db.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    await db.update(
        'tea',
        {
          'id': tea.id,
          'title': tea.title,
          'evaluation': tea.evaluation,
          'image': tea.image,
          'experience': tea.experience,
          'time': tea.time
        },
        where: 'id = ?',
        whereArgs: [
          tea.id,
        ]);
  }

  delete(int id) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes_db.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});

    db.delete('tea', where: 'id = ?', whereArgs: [id]);
  }

  clean() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes_db.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    await db.delete('tea');
  }

  Future<List<Tea>> getAll() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes_db.db');

    db = await openDatabase(path,
        version: 1, onCreate: (Database db, int version) async {});
    var result = await db.query('tea');
    return result.map((e) => Tea.fromJson(e)).toList();
  }
}

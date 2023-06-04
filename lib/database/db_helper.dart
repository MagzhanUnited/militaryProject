import 'package:flutter_application_kr/models/guns_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class GunsDatabaseHelper {
  static const _databaseName = "guns.db";
  static const _databaseVersion = 1;

  static const tableGuns = 'guns';
  static const columnId = '_id';
  static const columnName = 'name';
  static const columnInParts = 'inParts';
  static const columnInBrigade = 'inBrigade';

  static const tableConParts = 'conparts';
  static const columnConPartsId = '_id';
  static const columnConPartsName = 'name';
  static const columnGunsId = 'guns_id';

  // make this a singleton class
  GunsDatabaseHelper._privateConstructor();
  static final GunsDatabaseHelper instance =
      GunsDatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // open the database
  _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableGuns (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnInParts REAL,
        $columnInBrigade REAL
      )
    ''');
    await db.execute('''
      CREATE TABLE $tableConParts (
        $columnConPartsId INTEGER PRIMARY KEY,
        $columnConPartsName TEXT NOT NULL,
        $columnGunsId INTEGER,
        FOREIGN KEY ($columnGunsId) REFERENCES $tableGuns($columnId)
      )
    ''');
  }

  // CRUD operations

  Future<int> insertGun(Guns gun) async {
    Database db = await database;
    int id = await db.insert(tableGuns, gun.toMap());
    return id;
  }

  Future<List<Guns>> getAllGuns(kig) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableGuns);
    return List.generate(maps.length, (i) {
      return Guns(
          name: maps[i][columnName],
          inParts: maps[i][columnInParts],
          inBrigade: maps[i][columnInBrigade],
          kig: kig);
    });
  }

  Future<int> updateGun(Guns gun) async {
    Database db = await database;
    int count = await db.update(
      tableGuns,
      gun.toMap(),
      where: '$columnId = ?',
      whereArgs: [gun.id],
    );
    return count;
  }

  Future<int> deleteGun(int id) async {
    Database db = await database;
    int count = await db.delete(
      tableGuns,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return count;
  }

  Future<int> insertConPart(ConParts conPart) async {
    Database db = await database;
    int id = await db.insert(tableConParts, conPart.toMap());
    return id;
  }

  Future<List<ConParts>> getAllConParts(kig) async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query(tableConParts);
    return List.generate(maps.length, (i) {
      return ConParts(
        name: maps[i][columnConPartsName],
        guns: Guns(
            name: maps[i][columnName],
            inParts: maps[i][columnInParts],
            inBrigade: maps[i][columnInBrigade],
            kig: kig),
      );
    });
  }

  Future<int> updateConPart(ConParts conPart) async {
    Database db = await database;
    int count = await db.update(
      tableConParts,
      conPart.toMap(),
      where: '$columnConPartsId = ?',
      whereArgs: [conPart.id],
    );
    return count;
  }

  Future<int> deleteConPart(int id) async {
    Database db = await database;
    int count = await db.delete(
      tableConParts,
      where: '$columnConPartsId = ?',
      whereArgs: [id],
    );
    return count;
  }
}

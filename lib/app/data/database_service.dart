import 'package:samwise/app/data/buy_model.dart';
import 'package:samwise/app/data/client_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  DatabaseService._privateConstructor();

  static final DatabaseService _instance =
      DatabaseService._privateConstructor();

  factory DatabaseService() {
    return _instance;
  }
  static final DatabaseService instance = DatabaseService._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase;
    return _database!;
  }

  Future<Database> get _initDatabase async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/app_database.db';

    return await databaseFactoryFfi.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE clients (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              email TEXT NOT NULL,
              phone TEXT NOT NULL,
              address TEXT NOT NULL,
              points INTEGER DEFAULT 0
            )
          ''');
          await db.execute('''
            CREATE TABLE buys(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              client_id INTEGER NOT NULL,
              description TEXT NOT NULL,
              value REAL NOT NULL,
              FOREIGN KEY(client_id) REFERENCES clients(id) ON DELETE CASCADE
            )
            ''');
        },
      ),
    );
  }

  Future<List<ClientModel>> getAllclients() async {
    final db = await database;
    final maps = await db.query('clients', orderBy: 'id DESC');
    return maps.map((map) => ClientModel.fromJson(map)).toList();
  }

  Future<void> insertClient(ClientModel client) async {
    final db = await database;
    await db.insert(
      'clients',
      client.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> addBuy(BuyModel buy) async {
    final db = await database;
    await db.insert('buys', buy.toMap());
  }

  Future<List<BuyModel>> getBuysByClientId(int clientId) async {
    final db = await database;
    final maps = await db.query(
      'buys',
      where: 'client_id = ?',
      whereArgs: [clientId],
      orderBy: 'id DESC',
    );
    return maps.map((map) => BuyModel.fromJson(map)).toList();
  }
}

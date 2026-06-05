import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _init();

    return _database!;
  }

  Future<Database> _init() async {
    String path = join(await getDatabasesPath(), 'standardization.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate,);
  }

  // id INTEGER PRIMARY KEY AUTOINCREMENT,

  Future<void> _onCreate(Database db, int version) async {

    await db.execute('''
      CREATE TABLE users (
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_login TEXT NOT NULL,
        user_nom TEXT NOT NULL,
        user_prenoms TEXT NOT NULL,
        user_email TEXT NOT NULL,
        user_password TEXT NOT NULL,
        user_mobile TEXT NOT NULL UNIQUE,
        user_token TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE notifications (
        id TEXT NOT NULL UNIQUE,
        title TEXT NOT NULL,
        body TEXT NOT NULL,
        data TEXT NOT NULL,
        isRead TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');

    await db.execute('''    
      CREATE TABLE members (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        memb_id INTEGER NOT NULL UNIQUE,
        memb_nomprenoms TEXT NOT NULL,
        memb_mobile TEXT NOT NULL UNIQUE,
        memb_adhanne TEXT NOT NULL,
        memb_whatsapp TEXT NOT NULL,
        memb_date TEXT NOT NULL
      )
    ''');

    await db.execute('''    
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tran_id INTEGER NOT NULL UNIQUE,
        rubr_id INTEGER NOT NULL,
        rubr_nom TEXT NOT NULL,
        tran_nomprenoms TEXT NOT NULL,
        tran_mobile TEXT NOT NULL,
        tran_moyenpay TEXT NOT NULL,
        tran_amount INTEGER NOT NULL,
        tran_date TEXT NOT NULL
      );
    ''');

    await db.execute('''    
      CREATE TABLE messages (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mesg_id INTEGER NOT NULL UNIQUE,
        mesg_type TEXT NOT NULL,
        mesg_canal TEXT NOT NULL,
        mesg_ext TEXT,
        mesg_contenu TEXT NOT NULL,
        mesg_filename TEXT,
        mesg_date TEXT NOT NULL,
        mesg_date2 TEXT NOT NULL
      );
    ''');
  }


  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

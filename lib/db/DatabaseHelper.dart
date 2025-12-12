import 'package:sqflite/sqflite.dart';

//데이터베이스 작업 함수 등록.. 개발자 일종이 util
class DatabaseHelper {
  //이 클래스의 객체가 여러개 생성될 필요가 없어보여서.. singleton으로 이용되게
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // 싱글톤
  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    //데이터베이스 이용객체 생성준비
    return await openDatabase(
      'my_db.db', //db file name
      version: 1,
      // 앱 인스톨 후 최초한번만 호출.. 주로 테이블 create
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE TB_MYINFO(id INTEGER PRIMARY KEY AUTOINCREMENT,email TEXT,phone TEXT,photo TEXT)',
        );
      },
    );
  }

  Future<int> insertMyInfo(Map<String, dynamic> data) async {
    final db = await database;
    await db.delete('TB_MYINFO');
    return await db.insert('TB_MYINFO', data);
  }

  Future<List<Map<String, dynamic>>> getMyInfo() async {
    final db = await database;
    return await db.query('TB_MYINFO');
  }
}

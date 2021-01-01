import 'package:ispecx_expense/src/models/receipts_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

final String tableName = 'receipt';
final String columnId = 'id';
final String columnMarcent = 'marcent';
final String columnDate = 'date';
final String columnAccount = 'account';
final String columnTotal = 'total';
final String columnCategory = 'category';
final String columnTags = 'tags';
final String columnNotes = 'notes';
final String columnisBill = 'isBill';
final String columnColorIndex = 'colorIndex';

final String columnTitle = 'title';
final String columnDateTime = 'alarmDateTime';
final String columnPending = 'isPending';
//final String columnColorIndex = 'gradientColorIndex';

class ReceiptHelper {
  static Database _database;
  static ReceiptHelper _receiptHelper;

  ReceiptHelper._createInstance();
  factory ReceiptHelper() {
    if (_receiptHelper == null) {
      _receiptHelper = ReceiptHelper._createInstance();
    }
    return _receiptHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "receipt.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableName ( 
          $columnId integer primary key autoincrement, 
          $columnMarcent text not null,
          $columnDate text not null,
          $columnTotal double,
          $columnColorIndex integer,
          $columnCategory text not null,
          $columnAccount text not null,
          $columnTags text not null,
          $columnisBill integer,
          $columnNotes text not null)
        ''');
      },
    );
    return database;
  }

  //  Future<Database> initializeDatabase() async {
  //   var dir = await getDatabasesPath();
  //   var path = dir + "alarm.db";

  //   var database = await openDatabase(
  //     path,
  //     version: 1,
  //     onCreate: (db, version) {
  //       db.execute('''
  //         create table $tableName (
  //         $columnId integer primary key autoincrement,
  //         $columnTitle text not null,
  //         $columnDateTime text not null,
  //         $columnPending integer,
  //         $columnColorIndex integer)
  //       ''');
  //     },
  //   );
  //   return database;

  //  }

  void insertReceipt(ReceiptsModel receiptsModel) async {
    var db = await this.database;
    var result = await db.insert(tableName, receiptsModel.toMap());
    print('result : $result');
  }

  Future<List<ReceiptsModel>> getReceiptsData() async {
    List<ReceiptsModel> receipts = [];

    var db = await this.database;
    var result = await db.query(tableName);
    result.forEach((element) {
      var receiptInfo = ReceiptsModel.fromMap(element);
      receipts.add(receiptInfo);
    });

    return receipts;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(ReceiptsModel receiptsModel) async {
    var db = await this.database;
    return await db.update(tableName, receiptsModel.toMap(),
        where: '$columnId = ?', whereArgs: [receiptsModel.id]);
  }

  Future close() async {
    var db = await this.database;
    db.close();
  }
}

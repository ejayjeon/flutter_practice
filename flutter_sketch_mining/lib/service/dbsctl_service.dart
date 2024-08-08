
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:miner_skale_proto/mixins/logger_mixin.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


typedef SqlResultSet = List<Map<String, Object?>>;

class DbsctlService {

  static final DbsctlService _dbsctlService = DbsctlService._();
  factory DbsctlService () {
    return _dbsctlService;
  }

  DbsctlService._();

  /// connection resource
  Database? _db;

  Future<SqlResultSet?> getPowHash(String addr, int nonce) async {
    const sql = '''
      select nonce, powHash, powHashTime from sfule_tb
      where addr = ? and nonce = ? and txId is null
      limit 1
    ''';

    final rs = await _db?.rawQuery(sql, [
      addr,
      nonce
    ]);

    return Future.value(rs);
  }

  /// Querys database and returns the latest mined nonce number
  Future<int> lastNonceMined(String addr) async {

    const sql = 'select max(nonce) as Result from sfule_tb where addr = ?';
    final rs = await _db?.rawQuery(sql, [addr]);

    if(null == rs) {
      return Future.value(-1);
    }

    int? nonce = Sqflite.firstIntValue(rs);
    print('lastNonceMined: $nonce');

    return null != nonce ? Future.value(nonce) : Future.value(-2);
  }

  /// Call after powHash is used in transaction
  Future<int> addTxHash(String addr, int nonce, String txReceipt) async {

    const sql = ''' 
      update sfule_tb 
      set txId = ?
      where addr = ? and nonce = ? and txId is null
    ''';

    final rs = await _db?.rawUpdate(sql, [
      txReceipt,
      addr,
      nonce
    ]);

    if(null == rs) {
      print('addTxHash().rs is null');
      return Future.value(-1);
    }
    return Future.value(rs);
  }

  /// Call after powHash is mined
  Future<int> addPoWHash(int nonce, String addr, BigInt powHash, String genTime) async {

    final powHashStr = powHash.toString();
    const sql = '''
      insert or replace into sfule_tb (addr, nonce, powHash, powHashTime)
        select ?, ?, ?, ?
          where not exists (
            select * from sfule_tb
            where addr = ? and nonce = ?
          );
    ''';

    final rs = await  _db?.rawInsert(sql, [
      addr,
      nonce,
      powHashStr,
      genTime,
      addr,
      nonce
    ]);

    if(null == rs) {
      print('addPowHash().rs is null');
      return Future.value(-1);
    }
    return Future.value(rs);
  }

  Future<SqlResultSet> getPoWHashResreveCounts(String addr) async {

    const sql = 'select count(*) as PoWHashCount from sfule_tb where addr = ?';
    final rz = await _db?.rawQuery(sql, [addr]);

    return Future.value(rz);
  }
  /// debug
  void devPrintFreeGasList() async {
    final sql = 'select * from sfule_tb';
    final rs = await _db?.rawQuery(sql);

    print(rs);
  }

  /// non-transaction query
  void exec(String sql) async {
    // _db.rawQuery(sql)
  }

  /// 1. check and create db if not exists
  /// 2. open conn to it.
  Future<int> load({String dbFileName = 'miner.db'}) async {

    final appPath = await getDatabasesPath();
    final dbPath = join(appPath, dbFileName);

    final hasDbFile = await File(dbPath).exists();
    if(!hasDbFile) {
      ByteData data = await rootBundle.load(join('assets', dbFileName));
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes, 
        data.lengthInBytes
      );

      await File(dbPath).writeAsBytes(bytes);
      print('db.write ok to path: $dbPath');
    } else {
      print('dbPath: $dbPath');
    }

    _db = await openDatabase(
      dbPath, 
      version: 1, 
      onOpen: (db) {
        
      },
    );

    return Future.value(_db != null ? 0 : -1);
  }
}
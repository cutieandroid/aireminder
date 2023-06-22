import 'package:sqflite/sqflite.dart';

import '../Models/taskmodel.dart';

class DBHelper{
  static Database? _db;
  static final int _version= 1;
  static final String _tablename="tasks";

  static initDb() async{
    if(_db!=null){
      return;
    }
    try{
      String _path= await getDatabasesPath()+'tasks.db';
      _db= await openDatabase(_path,version: _version,onCreate: (db,verion){
        print("Creating new");
        return db.execute("Create table $_tablename("
            "id integer primary key autoincrement,"
            "title string, note text, date string,"
            "StartTime string,endTime string,"
            "remind integer,repeat string,"
            "color integer,"
            "iscompleted integer)",
        );
      });
    } catch(e){
      print(e);
    }

  }

  static Future<int?> inserttask (Task? task) async{

    return await _db?.insert(_tablename,task!.toJson());

  }

  static Future <List<Map<String,dynamic>>> query() async{
    return await _db!.query(_tablename);
  }
  static del(Task task)async {
    return await _db?.delete(_tablename,where: 'id=?',whereArgs: [task.id]);

  }
  static update(Task task) async{
    return await _db?.rawUpdate('''update $_tablename set iscompleted= ? where id= ?''',[1,task.id]);
}


}
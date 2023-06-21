import 'package:aireminder/Models/taskmodel.dart';
import 'package:aireminder/db/dbhelper.dart';
import 'package:get/get.dart';

class TaskController extends GetxController{
  @override
   void onReady(){
     super.onReady();
   }
   var tasklist=<Task>[].obs;

   Future<int?>addtask({Task? task}) async{
     return await DBHelper.inserttask(task);
   }
   void gettasks() async{
     List<Map<String,dynamic>> tasks= await DBHelper.query();
     tasklist.assignAll(tasks.map((data)=>new Task.fromJson(data)).toList());

   }
}
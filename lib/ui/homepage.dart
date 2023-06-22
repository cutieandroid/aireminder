

import 'package:aireminder/Controllers/taskcontroller.dart';
import 'package:aireminder/services/notiication_service.dart';
import 'package:aireminder/services/themeservices.dart';
import 'package:aireminder/ui/TaskForm.dart';
import 'package:aireminder/ui/homepagewidgets/AddTaskButton.dart';
import 'package:aireminder/ui/homepagewidgets/AddedTasks.dart';
import 'package:aireminder/ui/theme.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../Models/taskmodel.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _taskcontroller= Get.put(TaskController());
  var selecteddate;

  var notifyhelper;
  @override
  void initState(){
    super.initState();
    notifyhelper= new Notifyhelper();
    notifyhelper.initializenotification();
    _taskcontroller.gettasks();

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _appbar(context,notifyhelper),

          body: Column(
            children: [
              _addtasktaskbar(_taskcontroller),
              _datepickerwidget(selecteddate),
              _showtasks(_taskcontroller),
              
            ],
          ),

    );
  }
}

_showtasks (TaskController _taskcontroller){
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      child: Obx((){
        return ListView.builder(
          itemCount:_taskcontroller.tasklist.length,
            itemBuilder: (context,index){
            print(_taskcontroller.tasklist.length);

          return AnimationConfiguration.staggeredList(
            position: index,
            child:FadeInAnimation(
                child: GestureDetector(
                  onTap: (){_bottomsheet(context, _taskcontroller.tasklist[index],_taskcontroller);},
                    child: TaskTile(_taskcontroller.tasklist[index]))),
          );


        });
      }),
    ),
  );

}
_bottomsheet(BuildContext context,Task task,TaskController _taskcontroller){
  Get.bottomSheet(
    Container(
      color: ThemeServices().loadThemeFromStore()?Colors.black:Colors.white,
      padding: EdgeInsets.only(top: 4),
      height:task.iscompleted==1?MediaQuery.of(context).size.height*0.24:MediaQuery.of(context).size.height*0.32 ,
      child:Column(
        children: [
          Container(
            height: 6,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
            ),
          ),
          task.iscompleted==1?Container():_bottomsheetbtn(label: "Complete",onclick: (){
            Get.back();
            _taskcontroller.markcomplete(task);
            _taskcontroller.gettasks();
          },clr: primcolor, context: context),

          _bottomsheetbtn(context: context, label: "Delete", onclick: (){
            Get.back();
            _taskcontroller.deltask(task);_taskcontroller.gettasks();
            },
              clr: Colors.red),

          _bottomsheetbtn(context: context, label: "Close", onclick: (){Get.back();}, clr: Colors.red,isclose: true),
        ],
      ) ,
    )
  );
}
_bottomsheetbtn({required BuildContext context ,required String label,required Function() onclick, required Color clr, bool isclose=false}){

  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: GestureDetector(
      onTap: onclick,
      child: Container(
        alignment: Alignment.center,
        child: Text(label,style: TextStyle(color: isclose?Get.isDarkMode?Colors.white:Colors.black:Colors.white),),
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
            color: isclose?Colors.transparent:clr,
          border: Border.all(width: 2,color: isclose?Colors.grey:clr),
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    ),
  );
}

_datepickerwidget( selecteddate){
  return
    Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primcolor,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(fontSize: 20,fontWeight:FontWeight.w600,color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(fontSize: 14,fontWeight:FontWeight.w600,color: ThemeServices().loadThemeFromStore()?Colors.white:Colors.black),
        ),
        dayTextStyle:GoogleFonts.lato(
          textStyle: TextStyle(fontSize: 12,fontWeight:FontWeight.w600,color: ThemeServices().loadThemeFromStore()?Colors.white:Colors.black),
        ) ,
        onDateChange: (date){
          selecteddate=date;
        },

      ),
    );
      
}

_addtasktaskbar(TaskController _taskcontroller){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(DateFormat.yMMMd().format(DateTime.now()),style: subheadingstyle,),
            Text("Today",style:headingstyle),
          ],

        ),
        //ElevatedButton(onPressed: ()=>null, child: Text("+addtask")),

        AddTaskButton(onTap: ()async {await Get.to(TaskForm()); _taskcontroller.gettasks();}, label: "+AddTask")
      ],
    ),
  );

}

_appbar(BuildContext context,Notifyhelper notifyhelper){
  return AppBar(
    elevation: 0,
    backgroundColor: Theme.of(context).backgroundColor,

    leading: GestureDetector(
      onTap: (){
        ThemeServices().switchtheme();
        //notifyhelper.displaynotification(title: "Theme Changed", body:ThemeServices().loadThemeFromStore()?"Dark mode Activated": "Activated light theme");
       notifyhelper.schedulednotification("Theme Changed", ThemeServices().loadThemeFromStore()?"Dark mode Activated": "Activated light theme");
        },
      child:  Icon(Icons.nightlight_round,size: 20,
        color: ThemeServices().loadThemeFromStore()?Colors.white:Colors.black,
      ),

  ),
    actions: [
      Icon(Icons.person,size: 20,color: ThemeServices().loadThemeFromStore()?Colors.white:Colors.black ),
      SizedBox(width: 20,)


    ],

  );
}



import 'package:aireminder/Controllers/taskcontroller.dart';
import 'package:aireminder/services/notiication_service.dart';
import 'package:aireminder/services/themeservices.dart';
import 'package:aireminder/ui/TaskForm.dart';
import 'package:aireminder/ui/homepagewidgets/AddTaskButton.dart';
import 'package:aireminder/ui/theme.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
            itemBuilder: (_,context){
            print(_taskcontroller.tasklist.length);

          return Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: 100,
            height: 50,
            color: primcolor,
          );


        });
      }),
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

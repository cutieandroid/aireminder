import 'package:aireminder/services/notiication_service.dart';
import 'package:aireminder/services/themeservices.dart';
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
  var selecteddate;

  var notifyhelper;
  @override
  void initState(){
    super.initState();
    notifyhelper= new Notifyhelper();
    notifyhelper.initializenotification();

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _appbar(context,notifyhelper),

          body: Column(
            children: [
              _addtasktaskbar(),
              Container(
                child: DatePicker(
                  DateTime.now(),
                  height: 100,
                  width: 80,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: primcolor,
                  selectedTextColor: Colors.white,
                  dateTextStyle: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 20,fontWeight:FontWeight.w600,color: Colors.grey)
                  ),
                  onDateChange: (date){
                    selecteddate=date;
                  },

                ),
              )
            ],
          ),

    );
  }
}

_addtasktaskbar(){
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

        AddTaskButton(ontap: ()=>null, label: "+AddTask")
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

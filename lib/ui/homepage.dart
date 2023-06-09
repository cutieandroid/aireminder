import 'package:aireminder/services/notiication_service.dart';
import 'package:aireminder/services/themeservices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}


class _HomepageState extends State<Homepage> {


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
      appBar: _appbar(context,notifyhelper)



    );
  }
}
_appbar(BuildContext context,Notifyhelper notifyhelper){
  return AppBar(
    backgroundColor: Theme.of(context).primaryColor,

    leading: GestureDetector(
      onTap: (){
        ThemeServices().switchtheme();
        //notifyhelper.displaynotification(title: "Theme Changed", body:ThemeServices().loadThemeFromStore()?"Dark mode Activated": "Activated light theme");
       notifyhelper.schedulednotification("Theme Changed", ThemeServices().loadThemeFromStore()?"Dark mode Activated": "Activated light theme");
        },
      child: const Icon(Icons.nightlight_round,size: 20),

  ),
    actions:const  [
      Icon(Icons.person,size: 20,),
      SizedBox(width: 20,)


    ],

  );
}

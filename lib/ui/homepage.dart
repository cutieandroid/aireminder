
import 'package:aireminder/services/themeservices.dart';
import 'package:aireminder/ui/theme.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _appbar(context)



    );
  }
}
_appbar(BuildContext context){
  return AppBar(
    backgroundColor: Theme.of(context).primaryColor,

    leading: GestureDetector(
      onTap: (){
        ThemeServices().switchtheme();
      },
      child: const Icon(Icons.nightlight_round,size: 20),

  ),
    actions:const  [
      Icon(Icons.person,size: 20,),
      SizedBox(width: 20,)


    ],

  );
}

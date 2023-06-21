import 'package:aireminder/ui/TaskForm.dart';
import 'package:aireminder/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddTaskButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  const AddTaskButton({Key? key, required this.onTap, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 120,
        height: 50,
        decoration: BoxDecoration(
            color: primcolor,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Text(label,style: TextStyle(color: Colors.white)),

      ),
    );



    /*InkWell(
      onTap: ()=>ontap,
      child: Container(
           width: 100,
          height: 60,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
        ),
        color: Theme.of(context).primaryColor,
          child: Text(label)
      ),
    );*/
  }
}



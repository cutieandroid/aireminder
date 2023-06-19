import 'package:aireminder/ui/theme.dart';
import 'package:flutter/material.dart';

class AddTaskButton extends StatelessWidget {
  final Function ontap;
  final String label;
  const AddTaskButton({Key? key, required this.ontap, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>null,
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



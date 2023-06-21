
import 'package:aireminder/Controllers/taskcontroller.dart';
import 'package:aireminder/ui/TaskFormWidgets/inputfield.dart';
import 'package:aireminder/ui/homepagewidgets/AddTaskButton.dart';
import 'package:aireminder/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../Models/taskmodel.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final TaskController _taskController=Get.put(TaskController());
  TextEditingController _titleCointroller=TextEditingController();
  TextEditingController _notecontroller= TextEditingController();
  DateTime _selecteddate=DateTime.now();
  String? _starttime=DateFormat("hh:mm a").format(DateTime.now());
  String? _endtime=DateFormat("hh:mm a").format(DateTime.now().add(Duration(hours: 8)));
  int _selectedremind=5;
  String _selectedrepeat="Daily";
  List<int> remindlist=[
    5,10,15,20
  ];
  List<String> repeatlsit=[
    "Daily",
    "weekly",
    "Monthly"

  ];
  int _selectedcolor=0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body:
        SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add Task",style: headingstyle,),
                  InputField(title: "Title",hint:"Task Name",TextEditingController: _titleCointroller,),
                  InputField(title: "Note",hint:"Add a note",TextEditingController: _notecontroller,),
                  InputField(widget:IconButton(
                    icon:Icon(Icons.calendar_month_outlined ),
                    onPressed: (){
                      _getdatefromuser();
                    },
                  )
                      ,title: "Date",hint:DateFormat.d().format(_selecteddate)+"/"+DateFormat.M().format(_selecteddate)+"/"+DateFormat.y().format(_selecteddate)),
                  Row(

                    children: [
                      Expanded(
                        child: InputField(widget:IconButton(
                          icon: Icon(Icons.access_time_outlined),
                          onPressed: () {
                            _gettimefromuser(true);

                          },

                        ),
                        title: "Start Time", hint: _starttime.toString()),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InputField(widget:IconButton(
                          icon: Icon(Icons.access_time_outlined),
                          onPressed: () {

                            _gettimefromuser(false);

                          },

                        ),
                            title: "End Time", hint: _endtime.toString()),
                      )
                    ],
                  ),
                  InputField(title:"Remind", hint: "$_selectedremind minutes early",
                   widget: DropdownButton(
                     items: remindlist.map<DropdownMenuItem<String>>(
                           (int value ){
                             return DropdownMenuItem<String>(
                               value: value.toString(),
                                 child: Text(
                                   value.toString()
                                 )
                             );

                       }
                     ).toList(),
                    onChanged: (String? newvalue) {

                       setState(() {
                         _selectedremind=int.parse(newvalue.toString());
                       });

                    },
                    icon: Icon(Icons.keyboard_arrow_down),
                     iconSize: 32,
                     elevation: 4,

                  ),
                  ),
                  InputField(title:"Repeat", hint: "$_selectedrepeat",
                    widget: DropdownButton(
                      items: repeatlsit.map<DropdownMenuItem<String>>(
                              (String value ){
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                    value
                                )
                            );

                          }
                      ).toList(),
                      onChanged: (String? newvalue) {

                        setState(() {
                          _selectedrepeat=newvalue.toString();
                        });

                      },
                      icon: Icon(Icons.keyboard_arrow_down),
                      iconSize: 32,
                      elevation: 4,

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Color",style:inputfieldstyle),
                            Wrap(
                              children: List<Widget>.generate(
                                  3,
                                      (int index) {
                                    return GestureDetector(
                                      onTap:(){
                                        setState(() {
                                          _selectedcolor=index;
                                        });


                                      } ,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                                        child: CircleAvatar(
                                          child: _selectedcolor==index?Icon(Icons.done):Container(),
                                          radius: 14,
                                          backgroundColor: index==0?primcolor:index==1?Colors.yellow:Colors.pink,
                                        ),
                                      ),
                                    );

                                      })
                              ,
                            )
                          ],

                        ),
                        AddTaskButton(onTap:()=> _validatedata(), label: "Create Task")



                      ],
                    ),
                  ),



                ],
              ),
            ),
          ),
        )

    );
  }
  _getdatefromuser() async{
    DateTime? _pickeddate= await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));
    if(_pickeddate!=null){
      setState(() {
        _selecteddate=_pickeddate;
      });
    }
  }
  _gettimefromuser(bool isstarttime) async{
    String? _curentstarttime=DateFormat("hh:mm a").format(DateTime.now());
    
    var pickedtime= await showTimePicker(context: context,
        initialEntryMode: TimePickerEntryMode.input,
        initialTime:  TimeOfDay(hour: int.parse(_curentstarttime.toString().split(":")[0]),
            minute: int.parse(_curentstarttime.toString().split(":")[1].split(" ")[0]))
    );

    var _formatedtime= pickedtime?.format(context);

     if(_formatedtime==null){
       setState(() {
         _starttime=_starttime;
       });
     }
     else
       {
         if(isstarttime==true){
           setState(() {
             _starttime=_formatedtime;
           });

         }
         else if(isstarttime==false){
           setState(() {
             _endtime=_formatedtime;
           });
         }
       }
    
  }

  _validatedata(){
    if(_titleCointroller.text.isNotEmpty &&_notecontroller.text.isNotEmpty){
      _addtasktodb();
      //_taskController.gettasks();
      Get.back();
    }
    else if(_titleCointroller.text.isEmpty ||_notecontroller.text.isEmpty)
      {
        Get.snackbar("Ahh !", "All the fields are required",snackPosition:SnackPosition.BOTTOM );
      }
  }

  _addtasktodb() async{

    int? value=await _taskController.addtask(
        task: Task(
        note: _notecontroller.text,
        title: _titleCointroller.text,
        date:DateFormat.d().format(_selecteddate)+"/"+DateFormat.M().format(_selecteddate)+"/"+DateFormat.y().format(_selecteddate),
        StartTime: _starttime,
        endTime: _endtime,
        remind: _selectedremind,
        repeat: _selectedrepeat,
        color: _selectedcolor,
        iscompleted: 0
    )
    );
    print(value);



  }

}

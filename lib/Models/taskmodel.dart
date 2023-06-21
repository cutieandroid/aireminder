class Task{
  int? id;
  String? title;
  String? note;
  int? iscompleted;
  String? date;
  String? StartTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task({this.id,this.title,this.note,this.iscompleted,this.date,this.StartTime,this.endTime,this.color,this.remind,this.repeat});

  Task.fromJson(Map<String,dynamic> json){
    id=json['id'];
    title=json['title'];
    note=json['note'];
    iscompleted=json['iscompleted'];
    date=json['date'];
    StartTime=json['StartTime'];
    endTime=json['endTime'];
    color=json['color'];
    remind=json['remind'];
    repeat=json['repeat'];
  }

  Map<String,dynamic>toJson(){
    final Map<String,dynamic>data= new Map<String,dynamic>();

    data['id']=this.id;
    data['title']=this.title;
    data['note']=this.note;
    data['iscompleted']=this.iscompleted;
    data['date']=this.date;
    data['StartTime']=this.StartTime;
    data['endTime']=this.endTime;
    data['color']=this.color;
    data['remind']=this.remind;
    data['repeat']=this.repeat;

    return data;
  }


}



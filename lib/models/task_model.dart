import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String title;
  String description;
  DateTime date;
   bool isDane;

  TaskModel({
    this.id='',
    required this.title,
    required this.description,
    required this.date,
    this.isDane = false,
  });
  TaskModel.fromJson(Map<String,dynamic>json): 
  this(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    date: (json["date"] as Timestamp).toDate(),
    isDane: json["isDane"],
  );


  Map<String,dynamic> toJson()=>{
    "id":id,
   "title":title,
   "description":description,
   "date":Timestamp.fromDate(date),
   "isDane":isDane,
  };
}

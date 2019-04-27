import 'package:flutter/material.dart';
import 'package:to_do_app/DatabaseHelper.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/model.dart';
import 'package:intl/intl.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  TextEditingController nameEditingController= new TextEditingController();
  TextEditingController descriptionEditingController= new TextEditingController();
  TimeOfDay time= TimeOfDay.now();
  String selectedTime="Select Task Time";
  DateTime today= DateTime.now();
  var timedDate= DateFormat.yMMMMd("en_US");
  String formatted="Seleck Task Date";
  String icon="another";


  _selectTime(BuildContext context)async{
    final TimeOfDay picked= await showTimePicker(context: context, initialTime: time);
    if(picked!=null){
      selectedTime="${picked.hour.toString()} : ${picked.minute}";
      setState(() {

      });
    }
  }
  _selectDay(context)async{
    final DateTime picked= await showDatePicker(context: context, initialDate: today, firstDate: DateTime(2019), lastDate: DateTime(2022));
    if(picked!=null){
      formatted= timedDate.format(picked);
      setState(() {

      });
    }
  }

  Widget creatIcon(String icon) {
    if (icon == "shop") {
      return Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.redAccent,
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFFEA2E7D),
                  Color(0xFFF28E63),
                ]),
          ),
          child: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ),
      );
    }
    else if (icon == "work" || icon == "spor") {
      return Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.redAccent,
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFF4C44C7),
                  Color(0xFFDA43A5),
                ]),
          ),
          child: icon == "spor"
              ? Icon(
                  Icons.language,
                  color: Colors.white,
                )
              : Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                ),
        ),
      );
    }
    else if (icon == "location") {
      return Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.redAccent,
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFF3D4181),
                  Color(0xFF445BC5),
                ]),
          ),
          child: icon == "spor"
              ? Icon(
                  Icons.language,
                  color: Colors.white,
                )
              : Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
        ),
      );
    }
    else if(icon=="food"){
      return Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.redAccent,
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFF1E70E4),
                  Color(0xFF08D6F7),
                ]),
          ),
          child: icon == "spor"
              ? Icon(
            Icons.language,
            color: Colors.white,
          )
              : Icon(
            Icons.fastfood,
            color: Colors.white,
          ),
        ),
      );
    }
    else {
      return Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.redAccent,
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Color(0xFF717289),
                  Color(0xFF242442),
                ]),
          ),
          child: icon == "spor"
              ? Icon(
                  Icons.language,
                  color: Colors.white,
                )
              : Icon(
                  Icons.scatter_plot,
                  color: Colors.white,
                ),
        ),
      );
    }
  }

  void saveTask(String icon, String name, String description, String dateTime)async{
    DatabaseHelper _db=DatabaseHelper();
    int eklemeIslemi= await _db.saveTask(Task(icon,name,description,dateTime,0));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/background.jpeg"), fit: BoxFit.fill)),
        child: Row(
          children: <Widget>[
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50,),
                Text("New Task",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),
                Text("Icon",style: TextStyle(color: Colors.grey),),
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width-40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Opacity(
                        opacity: icon=="shop"?
                            0.5:1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              icon="shop";
                            });
                          },
                          child: creatIcon("shop"),

                        ),
                      ),
                      Opacity(
                        opacity: icon=="spor" ?
                        0.5:1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              icon="spor";
                            });
                          },
                          child: creatIcon("spor"),
                        ),
                      ),
                      Opacity(
                        opacity: icon=="location"?
                        0.5:1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              icon="location";
                            });
                          },
                          child: creatIcon("location"),
                        ),
                      ),
                      Opacity(
                        opacity: icon=="food"?
                        0.5:1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              icon="food";
                            });
                          },
                          child: creatIcon("food"),
                        ),
                      ),
                      Opacity(
                        opacity: icon=="work"?
                        0.5:1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              icon="work";
                            });
                          },
                          child: creatIcon("work"),
                        ),
                      ),
                      Opacity(
                        opacity: icon=="another"?
                        0.5:1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              icon="another";
                            });
                          },
                          child: creatIcon("another"),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Text("Name",style: TextStyle(color: Colors.grey),),
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width-40,
                  height: 50,
                  child: TextField(
                    controller: nameEditingController,
                    decoration: InputDecoration(
                        hintText: "Enter Task Name",
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Text("Decription",style: TextStyle(color: Colors.grey),),
                SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width-40,
                  height: 100,
                  child: TextField(
                    maxLines: 20,
                    controller: descriptionEditingController,
                    decoration: InputDecoration(
                      border:OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 10),
                          borderRadius: BorderRadius.circular(10)
                      ),
                        hintText: "Enter Task Description",
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                Text("Date",style: TextStyle(color: Colors.grey),),
                SizedBox(height: 10,),
                Container(
                  width: 250,
                  height: 50,
                  child: InkWell(
                    onTap: (){
                      _selectDay(context);
                    },
                    child: ListTile(
                      title: Text("$formatted"),
                      trailing: Icon(Icons.today)
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Text("Time",style: TextStyle(color: Colors.grey),),
                SizedBox(height: 10,),
                Container(
                  width: 250,
                  height: 50,
                  child: InkWell(
                    onTap: (){
                      _selectTime(context);
                    },
                    child: ListTile(
                        title: Text("$selectedTime"),
                        trailing: Icon(Icons.timer)
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                InkWell(
                  onTap: (){
                    setState(() {
                      saveTask(icon, nameEditingController.text, descriptionEditingController.text,formatted+" "+selectedTime);
                      var route= MaterialPageRoute(builder: (context){
                        return ToDo();
                      });
                      Navigator.push(context, route);
                    });
                  },
                  child: Container(
                    width: 100,
                    child: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.redAccent,
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF1E70E4),
                                Color(0xFF08D6F7),
                              ]),
                        ),
                        child: Center(child: Text("ADD",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight:FontWeight.bold)))
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(width: 20,)
          ],
        ),
      ),
    );
  }
}

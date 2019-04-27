import 'package:flutter/material.dart';
import 'package:to_do_app/DatabaseHelper.dart';
import 'package:to_do_app/new_task.dart';
import 'package:to_do_app/task_details.dart';
import 'model.dart';

void main()async{
  DatabaseHelper _db=DatabaseHelper();
  //int eklemeIslemi= await _db.saveTask(Task("shop","Go shopping ","Do this day todo app","2019-0-12-13-30",1));
  List task= await _db.getAllTask();
  for(int i=0;i<task.length;i++){
    _db.deleteTask(task[i]["id"]);
  }

  runApp(MaterialApp(home: ToDo(),));
}
class ToDo extends StatefulWidget {
  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/background.jpeg"),fit: BoxFit.fill)
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(width: 100,),
                Text("TODO",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                SizedBox(width: 50,),
                Image(image: AssetImage("images/menu.jpeg"),height: 30,width: 30,)
              ],
            ),
            Container(
                height: MediaQuery.of(context).size.height-80,
                width: 400,
                child: getAllData()
            ),

          ],
        ),
      ),
      floatingActionButton:  Padding(
        padding: const EdgeInsets.only(left:20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(25),
              child: InkWell(
                onTap: (){
                },
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
                  child: Icon(Icons.check,color: Colors.white,),
                ),
              ),
            ),
            Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: (){
                  var route = MaterialPageRoute(builder: (context){
                    return NewTask();
                  });
                  Navigator.push(context, route);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Image(image: AssetImage("images/date-filter.jpeg"),width: 40,height: 40,),
                ),
              ),
            ),
            Material(
              elevation: 0,
              borderRadius: BorderRadius.circular(25),
              child: InkWell(
                onTap: (){
                  var route = MaterialPageRoute(builder: (context){
                    return NewTask();
                  });
                  Navigator.push(context, route);
                },
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
                  child: Icon(Icons.add,color: Colors.white,),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
class getAllData extends StatefulWidget {
  @override
  _getAllDataState createState() => _getAllDataState();
}
class _getAllDataState extends State<getAllData> {
  DatabaseHelper _db= DatabaseHelper();


  void updateTaskDone(int id ,int done) async{
    Task task = await _db.getTask(id);

    if(done==1){
    task.done = 0;
    }
    else
      task.done = 1;

    await _db.updateTask(task);

    setState(() {
    });

  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _db.getAllTask(),builder: (context,snapshot){
      if(snapshot.hasData){
        List task=snapshot.data;
        return ListView.builder(itemCount: task.length,itemBuilder: (context,i){
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5,),
                Row(children: <Widget>[SizedBox(width: 5,),creatDot(task[i]["icon"])],),
                ListTile(
                  onTap: (){
                      alertBox(context, task[i]["icon"], task[i]["name"], task[i]["dateTime"], task[i]["description"]);
                  },
                  leading: creatIcon(task[i]["icon"]),
                  title: Text("${task[i]["name"]}"),
                  trailing: InkWell(
                    onTap: (){
                      setState(() {
                        if(task[i]["done"]==1){
                          updateTaskDone(task[i]["id"],task[i]["done"]);
                         //updateTaskDone(task[i]["id"].toString(), task[i]["name"], task[i]["decription"], task[i]["dateTime"], 0);
                        }
                        else{
                          updateTaskDone(task[i]["id"],task[i]["done"]);
                         // updateTaskDone(task[i]["id"].toString(), task[i]["name"], task[i]["decription"], task[i]["dateTime"], 1);
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey)
                      ),
                      child: task[i]["done"]==1 ?
                      Image(image: AssetImage("images/done.jpeg"),width: 15,height: 15,)
                          :
                      Icon(Icons.done,color: Colors.white,size: 0,),
                    ),
                  ),
                ),
                SizedBox(height: 15,)
              ],
            ),
          );
        });
      }
      else{
        return Center(child: CircularProgressIndicator(),);
      }
    }
    );
  }
}
void alertBox(BuildContext context, String icon,String name,String dateTime,String description){
  var alert= AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    actions: <Widget>[
      Container(
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFB),
          //borderRadius: BorderRadius.circular(5)
        ),
        height: 500,
        child: Column(
          children: <Widget>[
            creatIcon(icon),
            SizedBox(height: 20,),
            Text("$name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22)),
            SizedBox(height: 10,),
            Text("$dateTime",style: TextStyle(color: Colors.grey),),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 250,
              color: Colors.white,
              child: Center(child: Text("$description",style: TextStyle(color: Colors.grey),)),
            ),
            SizedBox(height: 50,),
            InkWell(
              onTap: (){
                  Navigator.pop(context);
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
                      child: Center(child: Text("DONE",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight:FontWeight.bold)))
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ],
  );
  showDialog(context: context,builder: (context)=>alert);
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

Widget creatDot(String icon) {
  if (icon == "shop") {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.redAccent,
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFFEA2E7D),
                Color(0xFFF28E63),
              ]),
        ),
      ),
    );
  }
  else if (icon == "work" || icon == "spor") {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.redAccent,
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF4C44C7),
                Color(0xFFDA43A5),
              ]),
        ),
      ),
    );
  }
  else if (icon == "location") {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.redAccent,
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF3D4181),
                Color(0xFF445BC5),
              ]),
        ),
      ),
    );
  }
  else if(icon=="food"){
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.redAccent,
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF1E70E4),
                Color(0xFF08D6F7),
              ]),
        ),
      ),
    );
  }
  else {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.redAccent,
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFF717289),
                Color(0xFF242442),
              ]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:to_do_app/main.dart';

class TaskDetails extends StatefulWidget {
  final icon,name,dateTime,description;

  const TaskDetails({Key key, this.icon, this.name, this.dateTime, this.description}) : super(key: key);
  @override
  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {
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
            creatIcon(widget.icon),
            SizedBox(height: 20,),
            Text("${widget.name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22)),
            SizedBox(height: 10,),
            Text("${widget.dateTime}",style: TextStyle(color: Colors.grey),),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              color: Colors.white,
              child: Center(child: Text("${widget.description}",style: TextStyle(color: Colors.grey),)),
            ),
            SizedBox(height: 50,),
            InkWell(
              onTap: (){
                setState(() {
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
                      child: Center(child: Text("DONE",style: TextStyle(color: Colors.white,fontSize: 14,fontWeight:FontWeight.bold)))
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


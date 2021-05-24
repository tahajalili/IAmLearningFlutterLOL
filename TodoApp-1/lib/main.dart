import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyTaskList(),
    );
  }
}

class MyTaskList extends StatefulWidget {

  @override
  _MyTaskListState createState() => _MyTaskListState();
}

class _MyTaskListState extends State<MyTaskList> {
  final _taskItems = <String>[];

  final myController = TextEditingController();


  @override
  void dispose(){
    myController.dispose();
    super.dispose();
  }

  void _addTask(String task){
    setState(() {
      _taskItems.add(task);
    });
    myController.clear();
  }


  Widget _buildTaskList() {
    return new ListView.separated(
        itemCount: _taskItems.length,
        itemBuilder: (BuildContext context, index) {
          print(_taskItems);
          return _buildTask(_taskItems[index],index);
        },

        separatorBuilder: (BuildContext context, int index) => const Divider(height: 3,color: Colors.black38,)
    );

  }

  Widget _buildTask(String task, index){
    if(index % 2 != 0){
      return new ListTile(
        tileColor: Colors.blueGrey[600],
        title: new Text(task, style: TextStyle(color: Colors.white, fontSize: 20),),
      );
    } else{
      return new ListTile(
        tileColor: Colors.black38,
        title: new Text(task, style: TextStyle(color: Colors.black, fontSize: 20),),
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(

          title: Text("ToDo List"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("New Task"),
              content: TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter New Task",
                ),
              ),

              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      _addTask(myController.text);
                      Navigator.pop(context, "ok");

                      print(_taskItems);


                    },
                    child: const Text("OK")),

              ],
            )
          ),
          child: Center(child:Icon(Icons.add)),

        ),
        body: _buildTaskList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late String _userTODO;
  List todoList = [];

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: FirebaseOptions(
          appId: "1:100304136807:android:325d1225734a1f664f82c2",
          projectId: "todo-flutter-ca415",
          messagingSenderId: "100304136807",
          apiKey: "AIzaSyDSUA3Qc99Rg1zS2215Krsscw9IBPqV_Uk",
        )
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initFirebase();

    todoList.addAll(['Buy milk', 'Wash car', 'change count']);
  }

  void _menuOpen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Menu'),),
          body: Row(
            children: [
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/one', (route) => false);
              }, child:  Text('On main')),
              Padding(padding: EdgeInsets.only(left: 15)),
              Text('Simple menu')
            ],
          ),
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
        title: Text('Task List'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _menuOpen, icon: Icon(Icons.menu_outlined),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(!snapshot.hasData) return Text('No any tasks');
          return ListView.builder(
              itemCount: (snapshot.data! as QuerySnapshot).docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  key: Key((snapshot.data! as QuerySnapshot).docs[index].id),
                  child: Card(
                    child: ListTile(
                      title: Text((snapshot.data! as QuerySnapshot).docs[index].get('item')),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_forever,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          FirebaseFirestore.instance.collection('items').doc((snapshot.data! as QuerySnapshot).docs[index].id).delete();
                        },
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    FirebaseFirestore.instance.collection('items').doc((snapshot.data! as QuerySnapshot).docs[index].id).delete();
                  } ,
                );
              }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
            title: Text("Add task"),
            content: TextField(
              onChanged: (String value) {
                _userTODO = value;
                },
              ),
              actions: [
                ElevatedButton(onPressed: () {
                  FirebaseFirestore.instance.collection('items').add({'item': _userTODO});


                  Navigator.of(context).pop();
                }, child: Text("ADD"))
              ],
            );
          });
        },
        child: Icon(
          Icons.add_box,
          color: Colors.white60,
        ),
      ),
    );
  }
}

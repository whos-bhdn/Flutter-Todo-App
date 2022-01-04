import 'package:flutter/material.dart';

class MainScreen  extends StatelessWidget {
  const MainScreen ({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white60,
          appBar: AppBar(
          title: Text('Task List'),
          centerTitle: true,
        ),
        body: Column(
        children: [
          Text('MainScreen', style: TextStyle(color: Colors.black54),),
          ElevatedButton(onPressed: () {
            Navigator.pushReplacementNamed(context, '/todo');
          }, child: Text('Go to tasks')),
        ],
        )
    );
  }
}

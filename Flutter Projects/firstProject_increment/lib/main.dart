
import 'dart:io';
import 'package:flutter_projects/main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget //Has to be a stateful widget because its going to CHANGE. not STATIC.
{
  @override
  State<MyHomePage> createState() => _MyHomePageState();
  //Creates a state object of type <MyHomePage> and this is the syntax.
  //createState() creates a states and returns object _MyHomePageState();
  /*  We have to create a state of my homepage(_MyHomePageState) because if the main
      widget  gets redrawn since its a stateful, everything gets reset and values dont change.
      counter will remain at 0!

      The main widget is what SHOWS data, and gets redrawn, its like the grid draw function
      that just gets data everytime from other places and just keeps redrawing itself with the
      data that keep changing given by other places (Sorry this is the best i can do to explain to myself also)

      The state widget of a certain widget is actually a private class preferably (starts with '_'),
      and it's what updates the data and CONTAINS the data.
      in this case the data is the build(), counter and increment() and the whole homepage so that's where we store the
      actual home page.

      The state is PERSISTENT, the widget is UNCHANGEABLE
  * */
}

class _MyHomePageState extends State<MyHomePage>
{
  int counter = 0;

  void increment()
  {
    /*Everytime this function is called it prompts Flutter to REDRAW the widget therefore(MyHomePage does it)
    showing the new value.
    This runs the widget's build() everytime the button is clicked (onPressed: increment)
    */
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      appBar: AppBar(title: Text("Nothing Generator")),

      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Click to increment",
                  style: TextStyle(fontSize: 30,),
                  textAlign: TextAlign.center,

                ),
                const SizedBox(height: 20),
                Text("$counter", style: TextStyle(fontSize: 100)),
              ]

          )),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
            onPressed: increment,
            child: Icon(Icons.plus_one_outlined),
          )
      ),
    );
  }

}


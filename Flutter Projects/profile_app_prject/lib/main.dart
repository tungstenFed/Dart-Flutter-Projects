/// This file is the main entry point for the Flutter application.
/// It contains the [MyApp] widget, which is the root of the application,
/// as well as the [LoginPage] and [ProfilePage] widgets.
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'globalvariables.dart';
import 'package:image_picker/image_picker.dart';

/// The main entry point for the application.
void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  /// Creates a [MyApp] widget.
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Jeje',
      home: LoginPage(),
    );
  }
}

/// A widget that displays the login page.
class LoginPage extends StatefulWidget
{
  /// Creates a [LoginPage] widget.
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _StateMyHomePage();
}
/// A widget that displays the profile page.
class ProfilePage extends StatefulWidget
{
  /// Creates a [ProfilePage] widget.
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _StateProfilePage();
}

class _StateMyHomePage extends State<LoginPage>
{
  String inputUsername = "";
  String inputPassword = "";
  List<Shadow> shadowz =  [Shadow(blurRadius: 5, color: Colors.grey)];

  /// Checks the user's credentials and navigates to the profile page if they are correct.
  void checkCredentials()
  {
    if(inputPassword == "password")
    {
      print("pass ok");
      Navigator.push( //push on top e background c'è login page
        //pag iniziale
          context,
          //destinazione + materialpageRoute fa slide animation su android
          MaterialPageRoute(builder: (BuildContext context) => ProfilePage())

        //you can also go back as it creates a button automatically to go back
      );
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 100,
        title: Container(
          padding: EdgeInsets.all(5),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: BoxBorder.all(width: 2),
            color: Color.alphaBlend(Colors.white, Colors.red),
            boxShadow: [BoxShadow(blurRadius: 2, spreadRadius: 2, color: Colors.grey),]
          ),
          child: Text(

            "Customize Your Profile",
            style: GoogleFonts.alice(
              fontSize: 35,
              shadows: shadowz,
            ),
          ),
        ),
          centerTitle: true,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min, //as tall as the widgets
            children: [
              Text("Create your Profile:", style: GoogleFonts.alice(fontSize: 42, shadows: [Shadow(blurRadius: 10, color: Colors.grey),]),textAlign: TextAlign.center,),
              SizedBox(height: 35,),
              //username
              Text("Username:", style: GoogleFonts.alice(fontSize: 30,shadows: shadowz),),
              //username text field
              SizedBox( //since underline of text field takes upp all of widget's width
                width: 300,
                child: TextField(
                    onChanged: (value){ inputUsername = value;globalUsername = value;  }, //chose to use brackets and not arrow function
                    //onChanged = change means when insert a text, triggers a function which detects ur text and assigns it to a var
                    keyboardType: TextInputType.name,
                    cursorWidth: 3,
                    textAlign: TextAlign.center,

                    maxLength: 20,
                    style: GoogleFonts.alice(fontSize: 18)

                ),
              ),

              SizedBox(height: 25),
              //password
              Text("Password:", style: GoogleFonts.alice(fontSize: 30,shadows: shadowz)),
              SizedBox(
                width: 300,
                child: TextField(
                  //password text field
                    onChanged: (value){ inputPassword = value;  },
                    decoration: InputDecoration(label:Text("Password: 'password'")),
                    keyboardType: TextInputType.name,
                    cursorWidth: 3,
                    textAlign: TextAlign.center,
                    maxLength: 20,
                    obscuringCharacter: '•',
                    obscureText: true,
                    style: GoogleFonts.alice(fontSize: 18)

                ),
              ),

              SizedBox(height: 20,),
              //Confirm button
              ElevatedButton(onPressed: checkCredentials,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical:5),
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                        fontSize: 22,
                      shadows: shadowz,
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}

class _StateProfilePage extends State<ProfilePage>
{
  var changeImgBTN = Image.asset('assets/images/changes.png', height: 30, width: 39,);
  List<Shadow> shadowz = [Shadow(blurRadius: 5, color: Colors.grey)];

  ImageProvider currentImg = AssetImage('assets/images/user.png');
  //AssetImage looks in the pubspec.yaml if file is present or not (so inside the project). so it doesnt read files.
  //FileImage looks up bytes you've give along with the file you uploaded and decodes it.
  //there for an asset Img cant be assigned to a File img. different stuff
  //| Class          | How it loads |
  //| -------------- | ------------ |
  //| `AssetImage`   | Asset bundle |
  //| `FileImage`    | File system  |
  //| `NetworkImage` | HTTP         |
  //| `MemoryImage`  | Raw bytes    |
  //image source decides the class

  //now it works by giving it 'ImageProvider' because it doesnt lock the source to one thing, but accepts every source!

  var imagePicker = ImagePicker();

  void changeImgFunc() async
  {
    XFile? chosenFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if(chosenFile == null)
    {return null;}  //do nothing

    setState(() { //get a image from a file. i used image.file because it returns a regular image object
      //which matches the currentImg file type
      currentImg  = FileImage(File(chosenFile.path));
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: BoxBorder.all(width: 2),
                color: Color.alphaBlend(Colors.white, Colors.red),
                boxShadow: [BoxShadow(blurRadius: 2, spreadRadius: 2, color: Colors.grey),]
            ),
            child: Text(
              "Customize Your Profile",
              style: GoogleFonts.alice(
                  fontSize: 30,
                  shadows: shadowz
              ),
            ),
          ),
          centerTitle: true,
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Profile Image", style: GoogleFonts.allerta(fontSize: 20, shadows: shadowz)),
            SizedBox(height: 10,),

            //profile image bundle
            SizedBox( //for max width
              width: 210,
              child: Stack( //stack imgs on top of eachother
              alignment: AlignmentGeometry.center,
              children: [
                Container(
                  height: 150,width: 150,
                  decoration: BoxDecoration(image: DecorationImage(image: currentImg,fit: BoxFit.fill),
                  shape: BoxShape.circle),
                ),

                Positioned(
                  top: 110, //lowers the change img (x from the top so goes down)
                  right: 0, //on the right (0 from the right so far right)
                  child: IconButton(onPressed: changeImgFunc, icon: changeImgBTN,iconSize: 18,)
                ),
              ]
              ),
            ),
            SizedBox(height:9),
            Text("Welcome, ${globalUsername}.", style: GoogleFonts.allerta(fontSize: 18)),
            SizedBox(height:5),
            Text("Bio:", style: GoogleFonts.allerta(fontSize: 25, decoration: TextDecoration.underline),textAlign: TextAlign.left,),
            SizedBox( //for max width and spacing with text field
              width: 235,
              height: 50,
              child:  TextField(
                textAlign: TextAlign.center,
                minLines: 1,
                maxLines: 3,
              )
            )
          ],
        ),
    )
    );
  }
}
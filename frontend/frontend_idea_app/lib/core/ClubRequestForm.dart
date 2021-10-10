import "package:flutter/material.dart";
import 'package:frontend_idea_app/core/AppLogo.dart';
import 'package:frontend_idea_app/core/CoreAll.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/screens/MainPage.dart';
import 'package:http/http.dart';

class SubClubRequestForm extends StatefulWidget {
  String parentClub;
  SubClubRequestForm(this.parentClub);

  @override
  _SubClubRequestFormState createState() =>
      _SubClubRequestFormState(this.parentClub);
}

class _SubClubRequestFormState extends State<SubClubRequestForm> {
  final _formKey = GlobalKey<FormState>();
  //final parentNameController = TextEditingController();
  final nameController = TextEditingController();
  final imageUrlController = TextEditingController();

  String parentClub;

  _SubClubRequestFormState(this.parentClub);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 24),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            prefixIcon: Icon(
                              Icons.drive_file_rename_outline,
                              color: Colors.grey,
                              size: 30,
                            ),
                            hintText: "Enter Sub Group Name",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            contentPadding: EdgeInsets.all(15)),
                        validator: (String email) {
                          if (email == null || email.isEmpty) {
                            return "This field cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: imageUrlController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            prefixIcon: Icon(
                              Icons.emoji_objects_outlined,
                              color: Colors.grey,
                              size: 30,
                            ),
                            hintText: "Enter reason",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            contentPadding: EdgeInsets.all(15)),
                        validator: (String email) {
                          if (email == null || email.isEmpty) {
                            return "This field cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.width / 1.5,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: GestureDetector(
                  child: RaisedButton(
                      color: Colors.blue,
                      shape: StadiumBorder(),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        if (nameController.text == '') {
                          final snackBar = SnackBar(
                            content: Text('Subclub name cannot be empty'),
                            backgroundColor: const Color(0xFF3A4750),
                            duration: const Duration(seconds: 3),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (imageUrlController.text == '') {
                          final snackBar = SnackBar(
                            content: Text('Reason cannot be empty'),
                            backgroundColor: const Color(0xFF3A4750),
                            duration: const Duration(seconds: 3),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          _submitClub();
                          //Navigator.pop(context);
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitClub() {
    if (_formKey.currentState.validate()) {
      postRequestSubClub();
      final snackBar = SnackBar(
        content: Text('Yay you made it!'),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 3),
      );
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    }
  }

  void postRequestSubClub() async {
    String url = 'http://' +
        localhost +
        ':8080/addsubclubrequest'; // addsubclubrequest olacak bu
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody = '{"name":"' +
        nameController.text +
        '","parentClub":"' +
        parentClub +
        '","reason":"' +
        imageUrlController.text +
        '"}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: jsonBody);
  }
}

class ClubRequestForm extends StatefulWidget {
  @override
  _ClubRequestFormState createState() => _ClubRequestFormState();
}

class _ClubRequestFormState extends State<ClubRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final imageUrlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 24),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            prefixIcon: Icon(
                              Icons.drive_file_rename_outline,
                              color: Colors.grey,
                              size: 30,
                            ),
                            hintText: "Enter Club Name",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            contentPadding: EdgeInsets.all(15)),
                        validator: (String email) {
                          if (email == null || email.isEmpty) {
                            return "This field cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: imageUrlController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFFFFFFF),
                            prefixIcon: Icon(
                              Icons.emoji_objects_outlined,
                              color: Colors.grey,
                              size: 30,
                            ),
                            hintText: "Enter reason",
                            hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            contentPadding: EdgeInsets.all(15)),
                        validator: (String email) {
                          if (email == null || email.isEmpty) {
                            return "This field cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.width / 1.5,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: GestureDetector(
                  child: RaisedButton(
                      color: Colors.blue,
                      shape: StadiumBorder(),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        if (nameController.text == '') {
                          final snackBar = SnackBar(
                            content: Text('Club name cannot be empty'),
                            backgroundColor: const Color(0xFF3A4750),
                            duration: const Duration(seconds: 3),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (imageUrlController.text == '') {
                          final snackBar = SnackBar(
                            content: Text('Reason cannot be empty'),
                            backgroundColor: const Color(0xFF3A4750),
                            duration: const Duration(seconds: 3),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          _submitClub();
                          //Navigator.pop(context);
                        }
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitClub() {
    if (_formKey.currentState.validate()) {
      postRequestClub();
      final snackBar = SnackBar(
        content: Text('Yay you made it!'),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 3),
      );
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    }
  }

  void postRequestClub() async {
    String url = 'http://' +
        localhost +
        ':8080/addclubrequest'; // addsubclubrequest olacak bu
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody = '{"name":"' +
        nameController.text +
        '","reason":"' +
        imageUrlController.text +
        '"}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: jsonBody);
  }
}

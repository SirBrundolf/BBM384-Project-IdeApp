import "package:flutter/material.dart";
import 'package:frontend_idea_app/core/AppLogo.dart';
import 'package:frontend_idea_app/core/CoreAll.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/screens/MainPage.dart';
import 'dart:math';
import 'package:http/http.dart';

Random random = new Random();
int statusGlb = 0;

class AddClubForm extends StatefulWidget {
  @override
  _AddClubFormState createState() => _AddClubFormState();
}

class _AddClubFormState extends State<AddClubForm> {
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
                            hintText: "Enter Group Name",
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
                              Icons.crop_original_outlined,
                              color: Colors.grey,
                              size: 30,
                            ),
                            hintText: "Enter Url for Group Image",
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
                          content: Text('Image url cannot be empty'),
                          backgroundColor: const Color(0xFF3A4750),
                          duration: const Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        _submitClub();
                        //Navigator.pop(context);
                      }
                    },
                  ),
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
      postRequestAddClub();
      if (statusGlb == 0) {
        final snackBar = SnackBar(
          content: Text('Club is saved to our database'),
          backgroundColor: Colors.blue,
          duration: const Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: Text('An error occured when saving process'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => MainPage()));
    }
  }

  Future<void> postRequestAddClub() async {
    String url = 'http://' + localhost + ':8080/addclub';
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonBody = '{"name":' +
        '"' +
        nameController.text +
        '"' +
        ', "imageUrl":' +
        '"' +
        imageUrlController.text +
        '"' +
        "}";
    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);

    // check the status code for the result
    int statusCode = response.statusCode;

    // this API passes back the id of the new item added to the body
    statusGlb = statusCode;
  }
}

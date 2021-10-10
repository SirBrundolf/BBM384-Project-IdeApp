import "package:flutter/material.dart";
import 'package:frontend_idea_app/core/CoreAll.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:http/http.dart';
import 'dart:async';

class AddEvent extends StatefulWidget {
  String clubName, subClubName;
  AddEvent(this.clubName, this.subClubName);

  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController nameController, dateController;

  @override
  void initState() {
    nameController = TextEditingController();
    dateController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
                            hintText: "Enter Event Name",
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
                        controller: dateController,
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
                            hintText: "Enter Date",
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
                    color: Colors.green,
                    shape: StadiumBorder(),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      addEvent();
                      Navigator.pop(context);
                    }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addEvent() async {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    String url = 'http://' + localhost + ':8080/addevent';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"event" :{ "name":"' +
        nameController.text +
        '","date":"' +
        dateController.text +
        '","timestamp":"' +
        time +
        '"},"clubName":"' +
        this.widget.clubName +
        '","subClubName":"' +
        this.widget.clubName +
        '"}';

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
    if (response.statusCode == 200) {
      // success falan
    }
  }
}

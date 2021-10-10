import "package:flutter/material.dart";
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';
import 'package:frontend_idea_app/core/AppLogo.dart';
import 'package:frontend_idea_app/core/CoreAll.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:http/http.dart';

class AddPost extends StatefulWidget {
  final String clubName, subClubName;
  AddPost(this.clubName, this.subClubName);
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

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
                        controller: titleController,
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
                            hintText: "Enter Title",
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
                        controller: contentController,
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
                            hintText: "Enter Content",
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
                    onPressed: (){
                    if(contentController.text != ''){
                     addPost();
                     Navigator.pop(context);
                     }
                     else{
                     final snackBar = SnackBar(
                          content: Text('Content cannot be empty'),
                          backgroundColor: const Color(0xFF3A4750),
                          duration: const Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  Future<void> addPost() async {
    User user = User.fromJson(await SharedPref().read("user"));
    String url = 'http://' + localhost + ':8080/addpost';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"post":{' +
        '"author":"' +
        user.username +
        '","title":"' +
        titleController.text +
        '","content":"' +
        contentController.text +
        '","vote":0, "timestamp":""' +
        '},"clubName":"' +
        widget.clubName +
        '","subClubName":"' +
        widget.subClubName +
        '"}';
    await post(Uri.parse(url), headers: headers, body: jsonBody);
  }
}

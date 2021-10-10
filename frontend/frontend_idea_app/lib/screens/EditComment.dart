import "package:flutter/material.dart";
import 'package:frontend_idea_app/core/AppLogo.dart';
import 'package:frontend_idea_app/core/CoreAll.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:http/http.dart';

class EditComment extends StatefulWidget {
  final String clubName, subClubName, timestamp, postTimestamp, content;
  EditComment(this.clubName, this.subClubName, this.timestamp,
      this.postTimestamp, this.content);
  @override
  _EditCommentState createState() => _EditCommentState();
}

class _EditCommentState extends State<EditComment> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController contentController;

  @override
  void initState() {
    contentController = TextEditingController(text: widget.content);
    super.initState();
  }

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
                        maxLines: 10,
                        minLines: 1,
                        controller: contentController,
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
                            hintText: "Enter new content",
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
                      editComment();
                      Navigator.pop(context);// bunu yapınca geri dönüyor fakat sayfa update olmuyor
                      }
                      else{
                      final snackBar = SnackBar(
                          content: Text('Comment cannot be empty'),
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

  void editComment() async {
    String url = 'http://' + localhost + ':8080/editcomment';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"timestamp":"' +
        widget.timestamp +
        '","postTimestamp":"' +
        widget.postTimestamp +
        '","subClubName":"' +
        widget.subClubName +
        '","clubName":"' +
        widget.clubName +
        '","content":"' +
        contentController.text +
        '"}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: jsonBody);
  }
}

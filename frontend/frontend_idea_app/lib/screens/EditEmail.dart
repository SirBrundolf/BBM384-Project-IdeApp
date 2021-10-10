import 'package:frontend_idea_app/main.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';

class EditEmail extends StatefulWidget {
  @override
  _EditEmailState createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  final validator = GlobalKey<FormState>();
  User user;
  String username, email;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPref().read("user"),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            user = User.fromJson(snapshot.data);
            username = user.username;
            email = user.mailAddress;
            final emailController = TextEditingController(text: email);
            return Scaffold(
                appBar: AppBar(
                  elevation: 1,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                body: Container(
                  padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Form(
                    key: validator,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of((context)).unfocus();
                      },
                      child: ListView(
                        children: [
                          Text(
                            "Edit E-Mail",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                filled: true,
                                fillColor: const Color(0xFFFFFFFF),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                                hintText: "Enter the new e-mail:",
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                contentPadding: EdgeInsets.all(15)),
                            validator: (String email) {
                              if (email == null || email.isEmpty) {
                                return "This field cannot be empty";
                              }
                              return null;
                            },
                            //initialValue: user.mailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          OutlineButton(
                            onPressed: () {
                              if (validator.currentState.validate()) {
                                email = emailController.text;
                                //DELETE
                                user.mailAddress = email;
                                postRequestEditEmail();
                                //ADD
                                SharedPref().save("user", user.toJson());
                                final snackBar = SnackBar(
                                  content: Text('E-Mail changed successfully!'),
                                  backgroundColor: Colors.blue,
                                  duration: const Duration(seconds: 3),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(context);
                              }
                            },
                            child: Text("Save"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
          } else {
            return Scaffold();
          }
        });
  }

  Future<void> postRequestEditEmail() async {
    String url = 'http://' + localhost + ':8080/editprofile';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = ' {"username" :"' +
        this.username +
        '","updatedField" :"mailAddress' +
        '","updatedData" :"' +
        this.email +
        '"}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: json);
  }
}

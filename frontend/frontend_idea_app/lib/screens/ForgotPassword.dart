import 'package:flutter/material.dart';
import 'package:frontend_idea_app/core/AppLogo.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/screens/SignIn.dart';
import 'package:http/http.dart';

class ForgotPass extends StatefulWidget {
  final String username;

  ForgotPass(this.username);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final verificationController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newPassword2Controller = TextEditingController();
  final validator = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        title: AppLogo(),
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 100, 20, 10),
        child: Form(
          key: validator,
          child: Column(
            children: [
              TextFormField(
                controller: newPasswordController,
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
                    hintText: "Enter new password:",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.all(15)),
                validator: (String password) {
                  if (password == null || password.isEmpty) {
                    return "This field cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: newPassword2Controller,
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
                    hintText: "Enter new password again:",
                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.all(15)),
                validator: (String password) {
                  if (password == null || password.isEmpty) {
                    return "This field cannot be empty";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 80,
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () async {
                  if (validator.currentState.validate()) {
                    if (newPasswordController.text ==
                        newPassword2Controller.text) {
                      if (newPasswordController.text.length > 4 &&
                          newPasswordController.text.length < 16) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            resetPassword();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ),
                            );
                            final snackBar = SnackBar(
                              content: Text('Password changed successfully!'),
                              backgroundColor: Colors.blue,
                              duration: const Duration(seconds: 3),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                        );
                      } else {
                        final snackBar = SnackBar(
                          content: Text(
                              'The length of a password has to be between 4-16!'),
                          backgroundColor: Colors.blue,
                          duration: const Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } else {
                      final snackBar = SnackBar(
                        content: Text(
                            'The length of a password has to be between 4-16!'),
                        backgroundColor: Colors.blue,
                        duration: const Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    final snackBar = SnackBar(
                      content: Text('New passwords are not matching!'),
                      backgroundColor: Colors.blue,
                      duration: const Duration(seconds: 3),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> resetPassword() async {
    String url = 'http://' + localhost + ':8080/resetpassword';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = ' {"username" :"' +
        widget.username +
        '","password" :"' +
        newPasswordController.text +
        '"}';

    // make POST request
    await post(Uri.parse(url), headers: headers, body: json);
  }
}

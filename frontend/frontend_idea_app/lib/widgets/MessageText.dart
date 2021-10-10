import 'package:flutter/material.dart';

class MessageText extends StatefulWidget {
  String text, timestamp;
  int sender;
  MessageText(this.text, this.timestamp, this.sender);

  @override
  _MessageTextState createState() => _MessageTextState();
}

class _MessageTextState extends State<MessageText> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: this.widget.sender == 1
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        decoration: BoxDecoration(
          color: this.widget.sender == 1 ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.text,
              style: TextStyle(
                color: this.widget.sender == 1 ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                DateTime.fromMillisecondsSinceEpoch(
                  int.parse(widget.timestamp),
                ).toString(),
                style: TextStyle(
                  fontSize: 8.0,
                  color: this.widget.sender == 1 ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

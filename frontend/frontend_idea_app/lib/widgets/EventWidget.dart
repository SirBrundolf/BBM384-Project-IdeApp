import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/models/Comment.dart';
import 'package:frontend_idea_app/screens/AddComment.dart';
import 'package:frontend_idea_app/screens/EditPost.dart';
import 'package:frontend_idea_app/widgets/CommentWidget.dart';
import 'package:frontend_idea_app/screens/JoinedClubScreen.dart';
import 'package:http/http.dart';

// ignore: must_be_immutable
class EventWidget extends StatefulWidget {
  final String date,
      name,
      
      timestamp;
  int vote;

  EventWidget(this.date, this.name, this.timestamp);

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  int vote;
  bool votedUp = false;
  bool votedDown = false;
  Color votedUpColor = Colors.black;
  Color votedDownColor = Colors.black;
  bool isExpanded = false;

  _EventWidgetState();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                        ),
                      ),
                      child: Column(
                        children: [
                          
                          ConstrainedBox(
                            constraints: isExpanded
                                ? new BoxConstraints()
                                : new BoxConstraints(maxHeight: 45),
                            child: Text(
                              widget.name,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ConstrainedBox(
                      constraints: isExpanded
                          ? new BoxConstraints()
                          : new BoxConstraints(
                              maxHeight: 165,
                              minHeight: 165,
                            ),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.black),
                          ),
                        ),
                        child: Text(
                          widget.date,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                  ),
        
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void reportUser() async {}

  
}

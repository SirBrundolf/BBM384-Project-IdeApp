import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:frontend_idea_app/main.dart';
import 'package:frontend_idea_app/models/Message.dart';
import 'package:frontend_idea_app/widgets/MessageText.dart';
import 'package:http/http.dart';

class MessageScreen extends StatefulWidget {
  String receiver, sender;
  MessageScreen(this.sender, this.receiver);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  StreamController<List<Message>> streamController;
  List<Message> allMessagesSeen;
  String lastTimestamp = '';
  ScrollController scrollController;
  TextEditingController messageController;
  Timer _timer;
  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    scrollController = new ScrollController();
    allMessagesSeen = <Message>[];
    streamController = StreamController<List<Message>>();
    getMessagesPeriodically('0').then((value) => {
          if (value.length > 0)
            {
              allMessagesSeen = value,
              lastTimestamp = value.first.timestamp,
              streamController.sink.add(allMessagesSeen),
            }
        });
    _timer = new Timer.periodic(
        Duration(seconds: 3),
        (_) => getLastMessagesPeriodically(lastTimestamp).then((value) => {
              if (value.length > 0)
                {
                  lastTimestamp = value.first.timestamp,
                  streamController.sink.add(allMessagesSeen),
                }
            }));
  }

  @override
  void dispose() {
    streamController.close();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(this.widget.receiver)),
        body: StreamBuilder(
            stream: streamController.stream,
            builder: (builder, AsyncSnapshot<List<Message>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.active:
                  if (snapshot.hasData)
                    return Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ListView.separated(
                              reverse: true,
                              controller: scrollController,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 6);
                              },
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data[index].whoSent ==
                                    this.widget.sender) {
                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              deleteMessage(
                                                  snapshot
                                                      .data[index].timestamp,
                                                  index);
                                            }),
                                        MessageText(snapshot.data[index].text,
                                            snapshot.data[index].timestamp, 1)
                                      ]);
                                } else {
                                  return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        MessageText(snapshot.data[index].text,
                                            snapshot.data[index].timestamp, 0),
                                        IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              deleteMessage(
                                                  snapshot
                                                      .data[index].timestamp,
                                                  index);
                                            })
                                      ]);
                                }
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0 / 2,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 32,
                                color: Color(0xFF087949).withOpacity(0.08),
                              ),
                            ],
                          ),
                          child: SafeArea(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.0 * 0.75,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          Color(0x00000000).withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: messageController,
                                            decoration: InputDecoration(
                                              hintText: "Type message",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.send_rounded,
                                              color: Color(0x00000000)
                                                  .withOpacity(0.64),
                                            ),
                                            onPressed: () {
                                              if (messageController.text !=
                                                  '') {
                                                sendMessage(
                                                    messageController.text);
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  else
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0 / 2,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 32,
                                color: Color(0xFF087949).withOpacity(0.08),
                              ),
                            ],
                          ),
                          child: SafeArea(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.0 * 0.75,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          Color(0x00000000).withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: messageController,
                                            decoration: InputDecoration(
                                              hintText: "Type message",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.send_rounded,
                                              color: Color(0x00000000)
                                                  .withOpacity(0.64),
                                            ),
                                            onPressed: () {
                                              if (messageController.text !=
                                                  '') {
                                                sendMessage(
                                                    messageController.text);
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  break;
                case ConnectionState.waiting:
                  if (snapshot.hasData)
                    return Container(
                      child: Text("Okey"),
                    );
                  else
                    return Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ListView.separated(
                              reverse: true,
                              controller: scrollController,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 6);
                              },
                              scrollDirection: Axis.vertical,
                              itemCount: 0,
                              itemBuilder: (context, index) {
                                if (snapshot.data[index].whoSent ==
                                    this.widget.sender) {
                                  return MessageText(snapshot.data[index].text,
                                      snapshot.data[index].timestamp, 1);
                                } else {
                                  return MessageText(snapshot.data[index].text,
                                      snapshot.data[index].timestamp, 0);
                                }
                              },
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 10.0 / 2,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 32,
                                color: Color(0xFF087949).withOpacity(0.08),
                              ),
                            ],
                          ),
                          child: SafeArea(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.0 * 0.75,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          Color(0x00000000).withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: messageController,
                                            decoration: InputDecoration(
                                              hintText: "Type message",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.send_rounded,
                                              color: Color(0x00000000)
                                                  .withOpacity(0.64),
                                            ),
                                            onPressed: () {
                                              if (messageController.text !=
                                                  '') {
                                                sendMessage(
                                                    messageController.text);
                                              }
                                            })
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  break;
                case ConnectionState.done:
                  if (snapshot.hasData)
                    return Container(
                      child: Text("Done"),
                    );
                  else
                    return Container(
                      child: Text("error2"),
                    );
                  break;
              }
            }));
  }

  Future<List<Message>> getMessagesPeriodically(String timestamp) async {
    String url = 'http://' + localhost + ':8080/getmessage';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"sender" :"' +
        this.widget.sender +
        '","receiver" : "' +
        this.widget.receiver +
        '","timestamp": "' +
        timestamp +
        '"}';

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
    Iterable l = json.decode(utf8.decode(response.bodyBytes));
    List<Message> posts =
        List<Message>.from(l.map((model) => Message.fromJson(model)));
    return posts.reversed.toList();
  }

  Future<List<Message>> getLastMessagesPeriodically(String timestamp) async {
    String url = 'http://' + localhost + ':8080/getmessage';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = '{"sender" :"' +
        this.widget.sender +
        '","receiver" : "' +
        this.widget.receiver +
        '","timestamp": "' +
        timestamp +
        '"}';

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);
    Iterable l = json.decode(utf8.decode(response.bodyBytes));
    List<Message> posts =
        List<Message>.from(l.map((model) => Message.fromJson(model)));
    allMessagesSeen.insertAll(0, posts.reversed.toList());
    return posts;
  }

  Future<int> sendMessage(String message) async {
    String url = 'http://' + localhost + ':8080/sendmessage';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String visibility1 = "visibility_" + this.widget.sender;
    String visibility2 = "visibility_" + this.widget.receiver;
    Map<String, bool> visibility = {visibility1: true, visibility2: true};
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    Message messageSent = Message(message, time, visibility, widget.sender);
    String jsonBody = ' {"message" : {"text" :"' +
        message +
        '","timestamp" : "' +
        time +
        '","whoSent" : "0"},"sender" :"' +
        widget.sender +
        '","receiver" :"' +
        widget.receiver +
        '"}';

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);

    // check the status code for the result
    int statusCode = response.statusCode;
    lastTimestamp = time;
    allMessagesSeen.insert(0, messageSent);
    streamController.sink.add(allMessagesSeen);
    return statusCode;
  }

  Future<void> deleteMessage(String timestamp, int index) async {
    String url = 'http://' + localhost + ':8080/deletemessage';
    Map<String, String> headers = {
      "Content-type": "application/json",
      'Access-Control-Allow-Origin': '*'
    };
    String jsonBody = ' {"timestamp": "' +
        timestamp +
        '","messageSendRequest" :{"message" : {},"sender" :"' +
        widget.sender +
        '","receiver" :"' +
        widget.receiver +
        '"},"sender" :"' +
        widget.sender +
        '","receiver" :"' +
        widget.receiver +
        '"}';

    // make POST request
    Response response =
        await post(Uri.parse(url), headers: headers, body: jsonBody);

    // check the status code for the result
    int statusCode = response.statusCode;
    if (index == allMessagesSeen.length) {
      lastTimestamp = allMessagesSeen.elementAt(index - 1).timestamp;
    }
    allMessagesSeen.removeAt(index);
    streamController.sink.add(allMessagesSeen);
    return statusCode;
  }
}

import 'package:flutter/material.dart';
import 'package:frontend_idea_app/core/SubClubNavBar.dart';
import 'package:frontend_idea_app/screens/Members.dart';
import 'package:frontend_idea_app/screens/PostAndComments.dart';
import 'package:frontend_idea_app/screens/InformationScreen.dart';
import 'package:frontend_idea_app/screens/EventScreen.dart';

class SubClubPage extends StatefulWidget {
    final String clubName, subClubName, description;
  int vote;

  SubClubPage(this.clubName, this.subClubName, this.vote, this.description);

  @override
  _SubClubPageState createState() => _SubClubPageState();
}

class _SubClubPageState extends State<SubClubPage>
    with TickerProviderStateMixin {
  SubClubNavBar navBar;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Color(0xFFDADADA),
      appBar: new PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight * 2.35),
        child: Column(
          children: [
            AppBar(
              elevation: 0,
            ),
            SubClubNavBar(_tabController),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
           InformationScreen(widget.clubName, widget.subClubName, widget.vote,
              widget.description),
          PostAndComments(widget.clubName, widget.subClubName, ""),
          EventScreen(widget.clubName, widget.subClubName),
          Members(widget.clubName, widget.subClubName),
        ],
      ),
    );
  }
}

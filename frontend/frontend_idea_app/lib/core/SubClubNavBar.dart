import 'package:flutter/material.dart';

class SubClubNavBar extends StatefulWidget {
  final TabController _tabController;
  SubClubNavBar(this._tabController);

  @override
  _SubClubNavBarState createState() => _SubClubNavBarState(_tabController);
}

class _SubClubNavBarState extends State<SubClubNavBar> {
  TabController _tabController;

  _SubClubNavBarState(TabController _tabController) {
    this._tabController = _tabController;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.white,
      labelColor: Colors.white,
      controller: _tabController,
      onTap: (value) => {
        setState(() {
          switch (value) {
            case 0:
              _tabController.animateTo(0);
              break;
            case 1:
              _tabController.animateTo(1);
              break;
            case 2:
              _tabController.animateTo(2);
              break;
            case 3:
              _tabController.animateTo(3);
              break;
          }
        })
      },
      tabs: <Tab>[
        new Tab(
          text: "SubClub description",
          icon: Icon(Icons.info),
        ),
        new Tab(
          text: "Posts",
          icon: Icon(Icons.question_answer),
        ),
        new Tab(
          text: "Event",
          icon: Icon(Icons.timer),
        ),
        new Tab(
          text: "Members",
          icon: Icon(Icons.group),
        )
      ],
    );
  }
}

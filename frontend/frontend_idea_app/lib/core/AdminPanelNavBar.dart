import 'package:flutter/material.dart';

class AdminPanelNavBar extends StatefulWidget {
  final TabController _tabController;

  AdminPanelNavBar(this._tabController);

  @override
  _AdminPanelNavBarState createState() =>
      _AdminPanelNavBarState(_tabController);
}

class _AdminPanelNavBarState extends State<AdminPanelNavBar> {
  TabController _tabController;

  _AdminPanelNavBarState(this._tabController);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      controller: _tabController,
      onTap: (value) => {
        setState(
          () {
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
          },
        )
      },
      tabs: <Tab>[
        new Tab(
          text: "Club\nRequests",
          icon: Icon(Icons.group_outlined),
        ),
        new Tab(
          text: "Sub Club\nRequests",
          icon: Icon(Icons.loyalty_outlined),
        ),
        new Tab(
          text: "Ban\nRequests",
          icon: Icon(Icons.do_disturb_alt_outlined),
        ),
        new Tab(
          text: "Candidates",
          icon: Icon(Icons.how_to_vote_outlined),
        )
      ],
    );
  }
}

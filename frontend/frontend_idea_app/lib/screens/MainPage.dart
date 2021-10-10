import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend_idea_app/screens/AdminPanel.dart';
import 'package:frontend_idea_app/screens/DirectMessage.dart';
import 'package:frontend_idea_app/screens/ProfilePage.dart';
import 'package:frontend_idea_app/screens/BrowseScreen.dart';
import 'package:frontend_idea_app/screens/JoinedClubScreen.dart';
import 'package:frontend_idea_app/SharedPref.dart';
import 'package:frontend_idea_app/User.dart';
import 'package:frontend_idea_app/screens/SignUp.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  PageController _pageController = new PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: SharedPref().read("user"),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            User user = User.fromJson(snapshot.data);
            return Scaffold(
              bottomNavigationBar: BottomNavyBar(
                selectedIndex: currentIndex,
                onItemSelected: (index) {
                  setState(() => currentIndex = index);
                  _pageController.jumpToPage(index);
                },
                items: <BottomNavyBarItem>[
                  BottomNavyBarItem(
                      title: user.isAdmin != 1
                          ? Text('Joined Clubs')
                          : Text("Admin Panel"),
                      icon: user.isAdmin != 1
                          ? Icon(Icons.favorite)
                          : Icon(Icons.settings_applications),
                      activeColor: Colors.pink),
                  BottomNavyBarItem(
                      title: Text('Browse'),
                      icon: Icon(Icons.home),
                      activeColor: Colors.blue),
                  BottomNavyBarItem(
                      title: Text(
                        'Direct Message',
                        style: TextStyle(fontSize: 10),
                      ),
                      icon: Icon(Icons.chat_bubble),
                      activeColor: Colors.green),
                  BottomNavyBarItem(
                      title: Text('Profile'),
                      icon: Icon(Icons.supervised_user_circle),
                      activeColor: Colors.red),
                ],
              ),
              body: PageView(
                controller: _pageController,
                children: user.isAdmin == 1
                    ? [
                        AdminPanel(),
                        BrowseScreen(),
                        DirectMessage(),
                        ProfilePage(),
                      ]
                    : [
                        JoinedClubScreen(),
                        BrowseScreen(),
                        DirectMessage(),
                        ProfilePage(),
                      ],
                onPageChanged: (index) => {
                  setState(() {
                    currentIndex = index;
                  }),
                },
              ),
            );
          } else {
            return Scaffold(
              bottomNavigationBar: BottomNavyBar(
                selectedIndex: currentIndex,
                onItemSelected: (index) {
                  setState(() => currentIndex = index);
                  _pageController.jumpToPage(index);
                },
                items: <BottomNavyBarItem>[
                  BottomNavyBarItem(
                      title: Text('Browse'),
                      icon: Icon(Icons.home),
                      activeColor: Colors.blue),
                  BottomNavyBarItem(
                      title: Text('Register'),
                      icon: Icon(Icons.login),
                      activeColor: Colors.pink),
                ],
              ),
              body: PageView(
                controller: _pageController,
                children: [
                  BrowseScreen(),
                  SignUp(),
                ],
                onPageChanged: (index) => {
                  setState(() {
                    currentIndex = index;
                  }),
                },
              ),
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:frontend_idea_app/screens/ClubDetail.dart';
import 'package:frontend_idea_app/screens/QuizPlay.dart';
import 'package:frontend_idea_app/screens/SubClubPage.dart';
import 'package:frontend_idea_app/screens/JoinedClubScreen.dart';

class BrowseItem extends StatefulWidget {
  final String clubName, subClubName, imageUrl, description;
  final bool isSubClub;
  final int vote;
  final bool otherUser;

  BrowseItem(this.clubName, this.subClubName, this.imageUrl, this.isSubClub,
      this.vote, this.otherUser, this.description);

  @override
  _BrowseItemState createState() => _BrowseItemState();
}

class _BrowseItemState extends State<BrowseItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              widget.isSubClub == false
                  ? new MaterialPageRoute(
                      builder: (context) => ClubDetail(
                        widget.clubName,
                        widget.imageUrl,
                        widget.vote,
                        widget.description,
                      ),
                    )
                  : new MaterialPageRoute(
                      builder: (context) => SubClubPage(
                        widget.clubName,
                        widget.subClubName,
                        widget.vote,
                        widget.description,
                      ),
                    ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.black,
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl),
                fit: BoxFit.cover,
                alignment: Alignment.center,
                colorFilter: new ColorFilter.mode(
                  Colors.white.withOpacity(0.7),
                  BlendMode.dstATop,
                ),
              ),
            ),
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(bottom: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Visibility(
                    visible: widget.isSubClub &&
                        !jc.contains(widget.subClubName) &&
                        !widget.otherUser,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                      ),
                      onPressed: () => {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => QuizPlay(
                              widget.clubName,
                              widget.subClubName,
                              widget.imageUrl,
                              widget.description,
                            ),
                          ),
                        ),
                      },
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 90),
                Text(
                  widget.isSubClub == false
                      ? widget.clubName
                      : widget.subClubName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

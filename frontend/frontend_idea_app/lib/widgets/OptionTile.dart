import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  final String option, text, correct, selected;
  const OptionTile(
      {Key key, this.option, this.text, this.correct, this.selected})
      : super(key: key);
  @override
  _OptionTileState createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 28,
            width: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.selected == widget.text
                        ? Colors.blue.withOpacity(0.7)
                        : Colors.grey,
                    width: 1.5),
                color: widget.selected == widget.text
                    ? Colors.blue.withOpacity(0.7)
                    : Colors.white,
                borderRadius: BorderRadius.circular(24)),
            child: Text(
              widget.option,
              style: TextStyle(
                color:
                    widget.selected == widget.text ? Colors.white : Colors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            widget.text,
            style: TextStyle(
                fontSize: 17,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

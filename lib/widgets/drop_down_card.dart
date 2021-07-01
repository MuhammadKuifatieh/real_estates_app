import 'package:flutter/material.dart';

class DropDownCard<T> extends StatefulWidget {
  final List<T> dropList;
  final String title;
  T dropDownValue;
  DropDownCard({this.dropList, this.title, this.dropDownValue});
  @override
  _DropDownCardState<T> createState() => _DropDownCardState<T>();
}

class _DropDownCardState<T> extends State<DropDownCard> {
  T value;
  @override
  void initState() {
    super.initState();
    value = widget.dropList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      alignment: Alignment.center,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 8.0,
            spreadRadius: 1,
            color: Colors.black38,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          DropdownButton<T>(
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Theme.of(context).primaryColor,
            ),
            value: value,
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 0,
              color: Theme.of(context).primaryColor,
            ),
            items: widget.dropList
                .map<DropdownMenuItem<T>>(
                  (value) => DropdownMenuItem<T>(
                    child: Text(value),
                    value: value,
                  ),
                )
                .toList(),
            onChanged: (newValue) {
              setState(() {
                widget.dropDownValue = newValue;
                value = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}

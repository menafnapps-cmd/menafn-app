import 'package:flutter/material.dart';
class SearchScreen extends StatelessWidget {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: TextField(
            controller: myController,
            decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/style.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Color color;
  CustomAppBar({@required this.title, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            icon: Icon(Icons.chevron_left, size: 40, color: color),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        Center(child: Text(title, style: TextStyle(color: color, fontSize: 18.0))),
      ]),
    );
  }
}

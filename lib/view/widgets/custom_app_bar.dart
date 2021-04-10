import 'package:flutter/material.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/utility/style.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Color color;
  CustomAppBar({@required this.title, this.color = ColorResources.COLOR_GRAY});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: Stack(children: [
        IconButton(
          icon: Icon(Icons.chevron_left, size: 25, color: color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        Center(child: Text(title, style: montserratSemiBold.copyWith(color: color))),
      ]),
    );
  }
}

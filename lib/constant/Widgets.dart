import 'package:flutter/material.dart';

class ExitButton extends StatelessWidget {
  ExitButton({this.width = 30, this.height = 30});

  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: CircleAvatar(
          child: Icon(
            Icons.close,
            color: Colors.red[900],
          ),
          backgroundColor: Colors.red[100],
        ),
      ),
    );
  }
}
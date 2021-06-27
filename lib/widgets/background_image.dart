import 'package:flutter/material.dart';

class backgroundimage extends StatelessWidget {
  const backgroundimage({
    Key key,
    @required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.6,
      child: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/arkaplan2.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

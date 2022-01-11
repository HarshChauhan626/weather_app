import 'package:flutter/material.dart';
import 'dart:math';

class CustomClock extends StatefulWidget {
  final double radius;
  final double dotRadius;

  CustomClock({this.radius = 30.0, this.dotRadius = 3.0});

  @override
  _CustomClockState createState() => _CustomClockState();
}

class _CustomClockState extends State<CustomClock>
    with SingleTickerProviderStateMixin {
  late double radius;
  late double dotRadius;

  @override
  void initState() {
    super.initState();
    radius = this.widget.radius;
    dotRadius = this.widget.dotRadius;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      height: 300.0,
      //color: Colors.black12,
      color: Colors.white,
      child: Container(
        //color: Colors.limeAccent,
        child: Transform.rotate(
          angle: 0,
          child: Stack(
            children: getSurroundingCircles(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> getSurroundingCircles() {
    List<Widget> circles = [
      Transform.translate(
        offset: Offset(0.0, 0.0),
        child: DotCentre(
          radius: radius + 50,
          color: Colors.red,
        ),
      )
    ];

    for (int i = 0; i < 12; i++) {
      circles.add(Transform.translate(
        child: Dot(
          radius: dotRadius + 10,
          color: Colors.blueAccent,
          number: i + 1,
        ),
        offset: Offset(
          (radius - 3) * cos(0.0 + (i - 2) * pi / 6),
          (radius - 3) * sin(0.0 + (i - 2) * pi / 6),
        ),
      ));
    }
    return circles;
  }
}

class Dot extends StatelessWidget {
  final double? radius;
  final Color? color;
  final int? number;

  Dot({this.radius, this.color, this.number});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
          width: radius,
          height: radius,
          child: Center(
              child: Text("${number}",
                  style: TextStyle(
                      color: Color(0xffd8dce2), fontWeight: FontWeight.bold))),
          decoration: number == 2
              ? BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 10,
                      style: BorderStyle.solid,
                      color: Color(0xfff1f3f6)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 0.0,
                        blurRadius: 3.0,
                        offset: Offset(3.0, 3.0)),
                    BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 0.0,
                        blurRadius: 3.0 / 2.0,
                        offset: Offset(3.0, 3.0)),
                    BoxShadow(
                        color: Colors.white,
                        spreadRadius: 2.0,
                        blurRadius: 3.0,
                        offset: Offset(-3.0, -3.0)),
                    BoxShadow(
                        color: Colors.white,
                        spreadRadius: 2.0,
                        blurRadius: 3.0 / 2,
                        offset: Offset(-3.0, -3.0)),
                  ],
                )
              : BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
    );
  }
}

class DotCentre extends StatelessWidget {
  final double? radius;
  final Color? color;
  const DotCentre({Key? key, this.radius, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
                width: 20, style: BorderStyle.solid, color: Color(0xfff1f3f6)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 0.0,
                  blurRadius: 3.0,
                  offset: Offset(3.0, 3.0)),
              BoxShadow(
                  color: Colors.grey.shade400,
                  spreadRadius: 0.0,
                  blurRadius: 3.0 / 2.0,
                  offset: Offset(3.0, 3.0)),
              BoxShadow(
                  color: Colors.white,
                  spreadRadius: 2.0,
                  blurRadius: 3.0,
                  offset: Offset(-3.0, -3.0)),
              BoxShadow(
                  color: Colors.white,
                  spreadRadius: 2.0,
                  blurRadius: 3.0 / 2,
                  offset: Offset(-3.0, -3.0)),
            ],
          )),
    );
  }
}

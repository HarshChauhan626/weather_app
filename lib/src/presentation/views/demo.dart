import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
        ),
        Stack(
          children: [
            Neumorphic(
              style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(), depth: -8),
              child: Container(
                height: 180,
                color: Colors.white,
                width: 180,
                child: Align(
                  alignment: Alignment.center,
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.circle(), depth: 10),
                    child:
                        Container(height: 140, color: Colors.white, width: 140),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}

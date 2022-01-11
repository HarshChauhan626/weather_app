import 'package:flutter/material.dart';
import 'package:weather_app/src/config/theme/app_theme.dart';
import 'package:weather_app/src/presentation/widgets/clock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.light,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.online_prediction, color: Colors.black),
            onPressed: () {}),
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "San Diego,",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            TextSpan(text: 'USA', style: TextStyle(color: Colors.black))
          ]),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            Row(
              children: [],
            ),
            CustomClock(
              radius: 120,
              dotRadius: 30,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [for (int i = 0; i < 4; i++) getRowWidget()])
          ],
        ),
      ),
    );
  }

  Widget getRowWidget() {
    return Container(
      height: 70,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [Icon(Icons.ac_unit), Text("15")],
      ),
    );
  }
}

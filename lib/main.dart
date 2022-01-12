import 'package:flutter/material.dart';
import 'package:weather_app/src/config/theme/app_theme.dart';
import 'package:weather_app/src/presentation/views/demo.dart';
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
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => DemoPage()));
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20.0, 5, 20, 5),
                height: 45,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Sunday, Jan 13 2022",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    Container(
                      height: 45,
                      child: Row(
                        children: [
                          Text("AM",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 20,
                          ),
                          Text("PM",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomClock(
                radius: 120,
                dotRadius: 30,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [for (int i = 0; i < 4; i++) getRowWidget()]),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(25, 20, 0, 10),
                  child: Text("Next 7 days",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24))),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color(0xffECF0f3),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
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
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Sunday',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 100),
                              Icon(Icons.search),
                              Text(
                                'Clear',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(width: 100),
                              Text('27C',
                                  style: TextStyle(fontWeight: FontWeight.bold))
                            ]),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget getRowWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 90,
      width: 70,
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

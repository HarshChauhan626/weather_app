import 'package:flutter/material.dart';
import 'package:weather_app/src/core/utils/app_colors.dart';
import 'package:weather_app/src/domain/entities/weather.dart';
import 'package:weather_icons/weather_icons.dart';

class ForecastListView extends StatelessWidget {
  const ForecastListView({Key? key, List<Weather>? forecastList})
      : super(key: key);

  static int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 180,
        color: Colors.white,
        child: ListView.builder(
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: 7,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  selectedIndex = index;
                  // setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: AnimatedAlign(
                    duration: Duration(milliseconds: 600),
                    alignment: index != selectedIndex
                        ? Alignment.center
                        : Alignment.topCenter,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 600),
                      height: 150,
                      width: 100,
                      decoration: BoxDecoration(
                        color: index != selectedIndex
                            ? Colors.white
                            : AppColors.primaryColor,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '12 AM',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            SizedBox(height: 5),
                            // SizedBox(width: 100),
                            Icon(WeatherIcons.sunrise),
                            SizedBox(height: 10),
                            Text('27C',
                                style: TextStyle(fontWeight: FontWeight.bold))
                          ]),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

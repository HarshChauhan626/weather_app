import 'package:flutter/material.dart';
import 'package:weather_app/src/core/utils/app_colors.dart';

class ForecastTabBarView extends StatelessWidget {
  const ForecastTabBarView({Key? key}) : super(key: key);

  static int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          getTabWidget(selectedTabIndex, 0, context),
          SizedBox(
            width: 25,
          ),
          getTabWidget(selectedTabIndex, 1, context),
          SizedBox(width: 60),
          TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text("Next 7 days",
                      style: Theme.of(context).textTheme.bodyText1),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.primaryColor,
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget getTabWidget(int selectedIndex, int index, BuildContext context) {
    return InkWell(
      onTap: () {
        // setState(() {
        //   selectedTabIndex = index;
        // });
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(index == 1 ? "Tommorow" : "Today",
                style: Theme.of(context).textTheme.headline6),
            AnimatedContainer(
                duration: Duration(milliseconds: 400),
                height: index == selectedIndex ? 5 : 0,
                width: index == selectedIndex ? 20 : 0,
                decoration: BoxDecoration(
                    color: index == selectedIndex
                        ? AppColors.primaryColor
                        : Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))))
          ],
        ),
      ),
    );
  }
}

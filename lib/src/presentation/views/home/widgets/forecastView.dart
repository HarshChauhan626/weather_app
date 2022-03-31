import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/core/utils/app_colors.dart';
import 'package:weather_app/src/presentation/cubits/weather_info_cubit.dart';

class ForecastTabBarView extends StatelessWidget {
  const ForecastTabBarView({Key? key,int selectedTabIndex=0}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          getTabWidget(0, context),
          SizedBox(
            width: 25,
          ),
          getTabWidget(1, context),
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

  Widget getTabWidget(int index, BuildContext context) {
    return InkWell(
      onTap: () {
        print('On tap clicked');
        BlocProvider.of<WeatherInfoCubit>(context).tabChanged(index);
      },
      child: BlocBuilder<WeatherInfoCubit,WeatherInfoState>(
        builder:(context,state){
          int selectedIndex=state.selectedIndex??0;
          print(state.selectedIndex);
          return Container(
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
          );
        }
      ),
    );
  }
}

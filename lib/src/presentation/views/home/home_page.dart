import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/config/di.dart';
import 'package:weather_app/src/core/utils/app_colors.dart';
import 'package:weather_app/src/core/utils/app_utils.dart';
import 'package:weather_app/src/data/network_info.dart';
import 'package:weather_app/src/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/src/domain/usecases/getweather_usecase.dart';
import 'package:weather_app/src/presentation/cubits/weather_info_cubit.dart';
import 'package:weather_app/src/presentation/views/home/widgets/forecastList.dart';
import 'package:weather_app/src/presentation/views/home/widgets/forecastView.dart';
import 'package:weather_app/src/presentation/views/search/cubit/search_cubit.dart';
import 'package:weather_app/src/presentation/views/search/search_page.dart';
import 'package:weather_icons/weather_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  static Route route() {
    // return PageRouteBuilder(
    //   settings: const RouteSettings(name: routeName),
    //   transitionDuration: const Duration(seconds: 0),
    //   pageBuilder: (context, _, __) => BlocProvider<WeatherInfoCubit>(
    //     create: (_) =>
    //         WeatherInfoCubit(GetWeatherUseCase(WeatherRepositoryImpl()))
    //           ..initializeData(),
    //     child: HomeScreen(),
    //   ),
    // );
    return MaterialPageRoute(
        builder: (context) => BlocProvider<WeatherInfoCubit>(
              create: (_) => instance<WeatherInfoCubit>()..initializeData(),
              child: HomeScreen(),
            ));
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int selectedIndex = 0;
  int selectedTabIndex = 0;

  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.online_prediction, color: Colors.black),
            onPressed: () {}),
        title: RichText(
          text: TextSpan(children: [
            TextSpan(
                text: "Weather App",
                style: Theme.of(context).textTheme.headline5),
          ]),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () async {
              bool isConnected =
                  await instance.get<NetworkInfoImpl>().isConnected;
              if (isConnected) {
                dynamic city = await Navigator.of(context)
                    .pushNamed(SearchScreen.routeName);
                BlocProvider.of<WeatherInfoCubit>(context).getData(city);
              } else {
                print('Not connected');
              }
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
          child: BlocConsumer<WeatherInfoCubit, WeatherInfoState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state.status!.isLoading) {
                return CircularProgressIndicator();
              } else if (state.status!.isError) {
                return AlertDialog(
                  content: Text("Oops!!!Something went wrong."),
                  title: Text("Error"),
                  actions: [Text("Ok")],
                );
              } else {
                return _buildView();
              }
            },
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("")),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("")),
      //     BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("")),
      //   ],
      // ),
    );
  }

  Widget _buildView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: double.infinity),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            alignment: Alignment.center,
            height: 200,
            child: Stack(children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(30)))),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Aligarh",
                            style:
                                TextStyle(fontSize: 30, color: Colors.white)),
                        Text("Saturday 15 Jan 2022, 5:47 PM",
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                        SizedBox(height: 50),
                        Text("30\u2103",
                            style:
                                TextStyle(fontSize: 30, color: Colors.white)),
                        Text("Sunny day",
                            style: TextStyle(fontSize: 16, color: Colors.white))
                      ]),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(WeatherIcons.day_sunny,
                            color: Colors.yellow, size: 80),
                        SizedBox(height: 30),
                      ]),
                ),
              )
            ]),
          ),
        ),
        SizedBox(height: 10),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          getRowWidget(value: "5", type: "Wind"),
          getRowWidget(value: "5", type: "Humidity"),
          getRowWidget(value: "5", type: "Pressure")
        ]),
        SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          getRowWidget(value: "5", type: "Wind"),
          getRowWidget(value: "5", type: "Humidity"),
          getRowWidget(value: "5", type: "Pressure")
        ]),
        SizedBox(height: 10),
        ForecastTabBarView(),
        ForecastListView()
      ],
    );
  }

  Widget getRowWidget({required String value, required String type}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      height: 100,
      width: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 60,
              width: 80,
              decoration: BoxDecoration(
                  color: AppUtils.boxColorMap[type],
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Icon(AppUtils.iconMap[type],
                  color: AppUtils.iconColorMap[type])),
          SizedBox(
            height: 3,
          ),
          Text("15"),
          Text(type)
        ],
      ),
    );
  }
}

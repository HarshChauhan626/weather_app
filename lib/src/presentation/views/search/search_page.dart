import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/config/di.dart';
import 'package:weather_app/src/core/utils/app_colors.dart';
import 'package:weather_app/src/presentation/views/search/cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/search';

  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      transitionDuration: const Duration(seconds: 0),
      pageBuilder: (context, _, __) => BlocProvider<SearchInfoCubit>(
        create: (_) => instance<SearchInfoCubit>()..setUpData(),
        child: SearchScreen(),
      ),
    );
  }

  final TextEditingController _textEditingController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Locations",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                  child: Icon(
                CupertinoIcons.back,
                color: Colors.black,
                size: 28,
              )),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<SearchInfoCubit, SearchInfoState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    child: Text(
                      "Find the area or city that you want to know the detailed weather info at this time",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.primaryColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.primaryColor,
                        )),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Container(
                      child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 10,
                          children: List.generate(
                            3,
                            (index) => Center(
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: index == 0
                                          ? AppColors.primaryColor
                                          : Colors.white,
                                      border: Border.all(
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "28",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(
                                                  color: index == 0
                                                      ? Colors.white
                                                      : Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Bright',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              ?.copyWith(
                                                  color: index == 0
                                                      ? Colors.white
                                                      : Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Aligarh',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                ?.copyWith(
                                                    color: index == 0
                                                        ? Colors.white
                                                        : Colors.black)),
                                      )
                                    ],
                                  )),
                            ),
                          ))),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: () {
            if (_textEditingController.text.isNotEmpty) {
              BlocProvider.of<SearchInfoCubit>(context)
                  .searchResult(_textEditingController.text);
            }
          },
          child: InkWell(
            onTap: () {
              BlocProvider.of<SearchInfoCubit>(context)
                  .searchResult(_textEditingController.text);
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                  child: Text(
                "Search",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
              )),
            ),
          ),
        ),
      ),
    );
  }
}

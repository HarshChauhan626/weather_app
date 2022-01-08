import 'package:flutter/material.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      // return _materialRoute(const HomeView());
      // break;

      case '/ArticleDetailsView':
      // return _materialRoute(const SearchView());
      // break;

      case '/SavedArticlesView':
      // return _materialRoute(const ForecastView);
      // break;
      default:
        throw UnimplementedError();
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}

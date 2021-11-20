import 'package:flutter/material.dart';
import 'package:machine_test/model/api_model.dart';
import 'package:machine_test/view/web.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeViewController extends ValueNotifier<HomeView> {
  HomeViewController() : super(HomeView());

  void changeExpandState(int index) {
    if (index == value.openedCardIndex && value.isExpanded) {
      value.isExpanded = false;
    } else {
      value.isExpanded = true;
      value.openedCardIndex = index;
    }
    notifyListeners();
  }

  void openApi(BuildContext context, Api api) {
    if (value.openBrowser) {
      launch(api.link);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => Web(api)));
    }
  }

  void changeGridView() {
    value.showGridView = !value.showGridView;
    notifyListeners();
  }

  void changeWebView() {
    value.openBrowser = !value.openBrowser;
    notifyListeners();
  }
}

class HomeView {
  int openedCardIndex = 0;
  bool isExpanded = false;
  bool openBrowser = false;
  bool showGridView = false;
}

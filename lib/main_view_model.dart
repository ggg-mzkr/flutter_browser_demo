import 'package:flutter/cupertino.dart';

class MainViewModel<T> with ChangeNotifier {

  final pages = List<T>();

  T activePage;

  bool drawerStatus = false;

  MainViewModel({this.activePage}) {
    pages.add(activePage);
  }

  void addPage(T page) {
    if (!this.pages.contains(page)) {
      this.pages.add(page);
      notifyListeners();
    }
  }

  void setActivePage(T page) {
    this.activePage = page;
    notifyListeners();
  }

  void setDrawerStatus(bool status) {
    this.drawerStatus = status;
    notifyListeners();
  }

}
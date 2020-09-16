import 'package:browser/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:provider/provider.dart';

const HOME_URL = "https://www.google.com";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MainViewModel<WebviewScaffold>(activePage: WebviewScaffold(url: HOME_URL))),
        ],
        child:  Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var vm = Provider.of<MainViewModel<WebviewScaffold>>(context);

    return Scaffold(
      appBar:  AppBar(
        title: Text('ぶらうざ〜'),
      ),
//      drawer: Drawer(
//        child: ListView(
//          children: getDrawerItems(vm.pages),
//        ),
//      ),
      body: vm.activePage,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
            title: Text("Back"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
            title: Text("forward"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            title: Text("home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restore, color: Colors.black),
            title: Text("tab"),
          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.menu, color: Colors.black),
//            title: Text("menu"),
//          ),
        ],
        onTap: onTap,
      ),
    );
  }

  void onTap(int index) {
    var flutterWebviewPlugin = FlutterWebviewPlugin();
    switch (index) {
      case 0:
        flutterWebviewPlugin
            .canGoBack()
            .then((canGoBack) => {
              if (canGoBack) flutterWebviewPlugin.goBack()
            });
        break;
      case 1:
        flutterWebviewPlugin
            .canGoForward()
            .then((canGoForward) => {
              if (canGoForward) flutterWebviewPlugin.goForward()
            });
        break;
      case 2:
        flutterWebviewPlugin.reloadUrl(HOME_URL);
        break;
      case 3:
        flutterWebviewPlugin.reload();
        break;
      case 4:
        flutterWebviewPlugin.goBack();
        break;
    }
  }

  List<Widget> getDrawerItems(List<WebviewScaffold> pages) {
    var items = <Widget>[];
    var header = DrawerHeader(
      child: Text('Drawer Header'),
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
    );

    items.add(header);
    items.addAll(pages.map((page) => ListTile(
      title: Text(page.url),
      trailing: Icon(Icons.note),
    )));

    return items;
  }
}

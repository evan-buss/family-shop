import 'package:family_list/redux/state.dart';
import 'package:family_list/util/net.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux/redux.dart';
import 'package:family_list/redux/reducers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:family_list/screens/family_screen.dart';
import 'package:family_list/screens/home_screen.dart';
import 'package:family_list/screens/personal_screen.dart';

import 'package:family_list/util/urls.dart';
import 'package:family_list/models/ListItem.dart';

void main() {
  final store = new Store<AppState>(authReducer, initialState: new AppState());
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({this.store});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Shopping List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: PageContainer(),
      ),
    );
  }
}

// PageContainer is holds all of the apps views and navigation between them
class PageContainer extends StatefulWidget {
  PageContainer({Key key}) : super(key: key);

  @override
  _PageContainerState createState() => _PageContainerState();
}

// _PageContainerState holds all the views and the navigation bar
class _PageContainerState extends State<PageContainer> {
  final List<String> titles = ["Home", "Personal List", "Family List"];
  PageController _pageController;
  static int _activePage = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  bool _fabIsVisible = false;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  // Change visible page on navigation bar selection
  void _handlePageSelection(int page) {
    _pageController.jumpToPage(page);
  }

  // Create a new item, depending on the current page it makes different API calls
  void _createItem() async {
    var item = new ListItem(
      description: "FAB",
      title: DateTime.now().toString(),
    );
    final response = await http.post(personalListURL,
        headers: {
          "Content-Type": "application/json",
          "Authorization": await getAuthToken()
        },
        body: json.encode(item.toJson()));

    print(json.encode(item.toJson()));
    print('Response status ${response.statusCode}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_activePage]),
      ),
      body: new PageView(
        onPageChanged: (int page) {
          setState(() {
            _activePage = page;
            if (_activePage == 1 || _activePage == 2) {
              _fabIsVisible = true;
            } else {
              _fabIsVisible = false;
            }
          });
        },
        children: <Widget>[HomeScreen(), PersonalScreen(), FamilyScreen()],
        controller: _pageController,
      ),
      drawer: Drawer(
        child: AppDrawer(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _activePage,
        onTap: _handlePageSelection,
        selectedItemColor: Colors.blueAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('My List'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Family List'),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: _fabIsVisible,
        child: FloatingActionButton(
          tooltip: 'New Item',
          child: Icon(Icons.add),
          onPressed: _createItem,
        ),
      ),
    );
  }
}

// App Drawer that provides quick account information
class AppDrawer extends StatelessWidget {
  AppDrawer();

// Icon
// Name
// Family
// ------------
// *family names*
// ------------
// Log out
// Settings

  Future<String> getName() async {
    final storage = FlutterSecureStorage();
    var name = await storage.read(key: "username");
    name = name.split(" ")[0];
    return "Greetings, " + name;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: FutureBuilder<String>(
              future: getName(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Text(
                    snapshot.data,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "ProductSans",
                        fontSize: 30),
                  );
                }
                return Text(
                  "Please Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "ProductSans",
                      fontSize: 30),
                );
              }),
          decoration: BoxDecoration(color: Colors.blue),
        ),
        ListTile(
          title: Text("Family"),
        ),
        ListTile(
          title: Text("Log Out"),
        ),
        ListTile(
          title: Text("Settings"),
        ),
      ],
    );
  }
}

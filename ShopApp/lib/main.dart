import 'package:family_list/redux/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:family_list/redux/reducers.dart';

import 'package:family_list/screens/family_screen.dart';
import 'package:family_list/screens/home_screen.dart';
import 'package:family_list/screens/personal_screen.dart';

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
    // duration: Duration(milliseconds: 300), curve: Curves.ease
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
          });
        },
        children: <Widget>[HomeScreen(), PersonalScreen(), FamilyScreen()],
        controller: _pageController,
      ),
      drawer: Drawer (
        child: Text ("welcome"),
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
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

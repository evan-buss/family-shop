import 'package:family_list/models/list.dart';
import 'package:family_list/screens/account/login_screen.dart';
import 'package:family_list/screens/create_item_screen.dart';
import 'package:family_list/widgets/create_list_modal.dart';
import 'package:family_list/widgets/list_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:family_list/screens/family_screen.dart';
import 'package:family_list/screens/home/home_screen.dart';
import 'package:family_list/screens/personal_list_screen.dart';

import 'package:family_list/models/app_user.dart';
import 'package:family_list/widgets/app_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (context) => ActiveList(context)),
          ChangeNotifierProvider(builder: (context) => AppUser()),
        ],
        child: MaterialApp(
          title: 'Shopping List',
          debugShowCheckedModeBanner: false,
          // TODO: Toggle switch between light and dark
          theme: ThemeData.dark(),
          home: PageContainer(),
        ));
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

  @override
  Widget build(BuildContext context) {
    // Determine which list is currently active
    var selectedListLitle =
        Provider.of<ActiveList>(context, listen: true).metaData?.title ?? "";
    // Show "Home" only on the home screen
    var pageTitle = _activePage != 0 ? selectedListLitle : "Home";

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        actions: <Widget>[
          Provider.of<AppUser>(context).state == AppState.LOGGED_IN
              ? IconButton(
                  icon: Icon(Icons.add_circle),
                  tooltip: "New List",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CreateListModal();
                      },
                    );
                  },
                )
              : Container(),
          ListDropdown()
        ],
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('My Items'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Family Items'),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: _fabIsVisible,
        child: FloatingActionButton(
          tooltip: 'New Item',
          child: Icon(Icons.add),
          onPressed: () {
            // Show the new item creation screen.
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateItemScreen()));
          },
        ),
      ),
    );
  }
}

// FIXME: Determine where to place this widget.. Not sure if keeping here
class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text("LOG IN"),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      ),
    );
  }
}

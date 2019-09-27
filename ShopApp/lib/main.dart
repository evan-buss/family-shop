import 'package:family_list/models/state/active_list.dart';
import 'package:family_list/models/state/app_settings.dart';
import 'package:family_list/models/state/app_user.dart';
import 'package:family_list/screens/account/login_screen.dart';
import 'package:family_list/screens/create_item_screen.dart';
import 'package:family_list/screens/family_screen.dart';
import 'package:family_list/screens/home/home_screen.dart';
import 'package:family_list/screens/personal_list_screen.dart';
import 'package:family_list/widgets/app_drawer.dart';
import 'package:family_list/widgets/create_list_modal.dart';
import 'package:family_list/widgets/list_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(builder: (context) => ActiveList()),
        ChangeNotifierProvider(builder: (context) => AppUser()),
        ChangeNotifierProvider(builder: (context) => AppSettings()),
      ],
      child: Consumer<AppSettings>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'Shopping List',
            debugShowCheckedModeBanner: false,
            theme: settings.isDark ? ThemeData.dark() : ThemeData.light(),
            home: PageContainer(),
          );
        },
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
    var selectedListTitle =
        Provider.of<ActiveList>(context, listen: true).metaData?.title ?? "";
    // Show "Home" only on the home screen
    var pageTitle = _activePage != 0 ? selectedListTitle : "Home";

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        actions: <Widget>[
          Provider.of<AppUser>(context).state == AppState.LOGGED_IN &&
                  _activePage != 0
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
          ListDropdown(_activePage)
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
        // Only show on the list screens and when a list is selected
        visible:
            _fabIsVisible && Provider.of<ActiveList>(context).metaData != null,
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
      child: Text(
        "LOG IN",
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      ),
    );
  }
}

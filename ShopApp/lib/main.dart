import 'dart:convert';
import 'package:family_list/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:family_list/screens/family_screen.dart';
import 'package:family_list/screens/home_screen.dart';
import 'package:family_list/screens/personal_screen.dart';

import 'package:family_list/util/urls.dart';
import 'package:family_list/util/local_storage.dart';
import 'package:family_list/models/AppUser.dart';
import 'package:family_list/models/ListItem.dart';
import 'package:family_list/models/ListMeta.dart';
import 'package:family_list/widgets/app_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => AppUser(),
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

  // Load the user's lists
  Widget _listDropDownBuilder() {
    return Consumer<AppUser>(
      builder: (context, user, _) {
        return FutureBuilder(
          future: UserLists.getLists(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ListsMetadata>> snapshot) {
            if (user.token != null) {
              return PopupMenuButton<ListsMetadata>(
                  icon: Icon(Icons.list),
                  onSelected: (selection) {
                    print("selection: " + selection.title);
                  },
                  itemBuilder: (BuildContext context) {
                    return snapshot.data.map<PopupMenuItem<ListsMetadata>>(
                        (ListsMetadata list) {
                      return PopupMenuItem(
                        value: list,
                        child: Text(list.title),
                      );
                    }).toList();
                  });
            }
            return IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Attempt to load existing user from the local storage. Otherwise they need to manually log in again...
    Provider.of<AppUser>(context).loadIfCached();

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_activePage]),
        actions: <Widget>[_listDropDownBuilder()],
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
          onPressed: _createItem,
        ),
      ),
    );
  }
}

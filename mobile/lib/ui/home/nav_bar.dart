import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prod_name/service/languages/AppTranslations.dart';
import 'package:prod_name/ui/home/account/account_screen.dart';
import 'package:prod_name/ui/home/home/home_screen.dart';
import 'package:prod_name/ui/home/map/map_screen.dart';
import 'package:prod_name/ui/home/search/search_screen.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedPage = 0;

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: <Widget>[
          HomeScreen(),
          MapScreen(),
          SearchScreen(),
          AccountScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedPage,
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: Colors.black, size: 32),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        unselectedIconTheme: IconThemeData(size: 26, color: Colors.grey.shade300),
        unselectedLabelStyle: TextStyle(color: Colors.grey.shade300),
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });

          pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 500),
            curve:
                Curves.easeInOutExpo, 
          );
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text(AppTranslations.of(context).text("navbar_home"))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.location_on,
              ),
              title: Text(AppTranslations.of(context).text("navbar_maps"))),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              title: Text(AppTranslations.of(context).text("navbar_search"))),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text(AppTranslations.of(context).text("navbar_account"))),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

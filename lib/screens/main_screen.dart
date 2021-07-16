import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../widgets/my_app_bar.dart';
import '../providers/page_index.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        title: Provider.of<PageIndex>(context).tilte,
      ),
      body: Provider.of<PageIndex>(context).page,
      bottomNavigationBar: GNav(
        rippleColor: Theme.of(context).primaryColor,
        haptic: true,
        tabBorderRadius: 15,
        tabActiveBorder: Border.all(color: Colors.black, width: 1),
        curve: Curves.easeOutExpo,
        duration: Duration(milliseconds: 400),
        gap: 8,
        activeColor: Colors.black,
        iconSize: 24,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tabMargin: EdgeInsets.symmetric(vertical: 5),
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Home',
            iconColor: Theme.of(context).primaryColor,
          ),
          GButton(
            icon: Icons.favorite,
            iconColor: Theme.of(context).primaryColor,
            text: 'Likes',
          ),
          GButton(
            icon: Icons.search,
            iconColor: Theme.of(context).primaryColor,
            text: 'Find',
          ),
          GButton(
            icon: Icons.person,
            iconColor: Theme.of(context).primaryColor,
            text: 'Profile',
          )
        ],
        selectedIndex: Provider.of<PageIndex>(context).pageIndex,
        onTabChange: (index) {
          Provider.of<PageIndex>(context, listen: false).setPageIndex(index);
        },
      ),
    );
  }
}

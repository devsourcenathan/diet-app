import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/constants.dart';
import 'package:diet_app/models/plants.dart';
import 'package:diet_app/ui/scan_page.dart';
import 'package:diet_app/ui/screens/cart_page.dart';
import 'package:diet_app/ui/screens/favorite_page.dart';
import 'package:diet_app/ui/screens/home_page.dart';
import 'package:diet_app/ui/screens/profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushNamed(context, '/auth');
    }
  }

  List<Plant> favorites = [];
  List<Plant> myCart = [];

  int _bottomNavIndex = 0;

  //List of the pages
  List<Widget> _widgetOptions() {
    return [
      const HomePage(),
      FavoritePage(
        favoritedPlants: favorites,
      ),
      CartPage(
        addedToCartPlants: myCart,
      ),
      const ProfilePage(),
    ];
  }

  //List of the pages icons
  List<IconData> iconList = [
    Icons.home,
    Icons.history,
    Icons.shopping_cart,
    Icons.person,
  ];

  //List of the pages titles
  List<String> titleList = [
    'Accueil',
    'Historique',
    'Services',
    'Profil',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleList[_bottomNavIndex],
              style: TextStyle(
                color: Constants.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            Icon(
              Icons.notifications,
              color: Constants.blackColor,
              size: 30.0,
            )
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  child: const ScanPage(),
                  type: PageTransitionType.bottomToTop));
        },
        child: Image.asset(
          'assets/images/code-scan-two.png',
          height: 30.0,
        ),
        backgroundColor: Constants.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
          splashColor: Constants.primaryColor,
          activeColor: Constants.primaryColor,
          inactiveColor: Colors.black.withOpacity(.5),
          icons: iconList,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
              final List<Plant> favoritedPlants = Plant.getFavoritedPlants();
              final List<Plant> addedToCartPlants = Plant.addedToCartPlants();

              favorites = favoritedPlants;
              myCart = addedToCartPlants.toSet().toList();
            });
          }),
    );
  }
}

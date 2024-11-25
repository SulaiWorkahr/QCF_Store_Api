import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_assets.dart';
import 'dashboard/dashboard_page.dart';
import 'order-list/orderlist_page.dart';
import 'order/orderdetails.dart';
import 'store_menu/menu_details_screen.dart';

class MainContainer extends StatefulWidget {
  MainContainer({super.key, this.childWidget});

  final Widget? childWidget;

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;
  bool navBack = false;

  final List pageId = [1, 5, 8, 12, 15];
  static List<Widget> pageOptions = <Widget>[
    DashboardPage(),
    MenuDetailsScreen(),
    OrderlistPage()
  ];

  void _onItemTapped(int index) async {
    // if (index == 2) {
    //   // Handle logout
    //   await _handleLogout();
    // } else {
    // Handle other navigation
    setState(() {
      _selectedIndex = index;
    });
    //}
  }

  @override
  initState() {
    super.initState();
  }

  @protected
  void didUpdateWidget(oldWidget) {
    print('oldWidget');
    print(oldWidget);
    super.didUpdateWidget(oldWidget);
  }

  Future<void> _onPop() async {
    // Handle back button press, you can add custom logic here.
    // For example, you could show a dialog or exit the app.
    // Exit the app or return to the home page:
    if (_selectedIndex == 0) {
      // Exit the app if already on the home page.
      return;
    } else {
      // Otherwise, navigate back to the first tab (home page).
      setState(() {
        _selectedIndex = 0;
      });
    }
  }

  Future<void> _handleLogout() async {
    // Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to Login Page
    Navigator.pushNamedAndRemoveUntil(
        context, '/login', ModalRoute.withName('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popDisposition) async {
        await _onPop();
      },
      child: Scaffold(
        // appBar: CustomAppBar(title: '', leading: SizedBox(), showSearch: true,showCart: false, backgroundColor: [0,2].contains(_selectedIndex) ? AppColors.light: null ,),
        // onPressed: widget.onThemeToggle),
        // drawer: SideMenu(),
        body: pageOptions[_selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          // onTap: onTabTapped,
          // currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                 _selectedIndex == 0
            ? AppAssets.homeIconSelected // Selected icon
            : AppAssets.home_icon,
                height: 25,
                width: 25,
              ),
              label: 'Home',

              //   backgroundColor: Color(0xFFE23744)
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                _selectedIndex == 1
            ? AppAssets.menuIconSelected
            : AppAssets.menuIcon,
                height: 25,
                width: 25,
              ),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                 _selectedIndex == 2
            ? AppAssets.orderIconSelected
            : AppAssets.orderImg,
                height: 25,
                width: 25,
              ),
              label: 'Orders',
            ),
          ],
          currentIndex: _selectedIndex,

          showUnselectedLabels: true,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFFE23744),
        ),
      ),
    );
  }
}

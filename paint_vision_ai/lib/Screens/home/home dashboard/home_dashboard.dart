import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/home%20dashboard%20provider/home_dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/Screens/home/home%20dashboard/home/home.dart';
import 'package:paint_vision_ai/Screens/profile/profile.dart';
import 'package:paint_vision_ai/Screens/search/search.dart';
import 'package:paint_vision_ai/Screens/shoping%20&%20checkouts/wishlist/carts/carts.dart';
import 'package:paint_vision_ai/Screens/shoping%20&%20checkouts/wishlist/carts/address/checkout/card%20payment/order%20success/my%20orders/my_orders.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = context.watch<HomeDashboardProvider>();

    final List<Widget> screens = [
      HomeScreen(),
      SearchScreen(),
      const CartsScreen(showBackButton: false),
      const MyOrdersScreen(showBackButton: false),
      ProfileScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: dashboardProvider.selectedIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: dashboardProvider.selectedIndex,
        onTap: (index) {
          context.read<HomeDashboardProvider>().changeTab(index);
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

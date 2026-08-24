import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/shoping%20&%20checkouts/wishlist/carts/address/checkout/card%20payment/order%20success/my%20orders/order%20details/order_details.dart';
import 'package:paint_vision_ai/widgets/transparent_primary_button.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int selectedIndex = 0;

  final List<String> tabs = [
    'All',
    'Processing',
    'Shipped',
    'Delivered',
    'Cancelled',
  ];

  final List<Map<String, dynamic>> orders = [
    {
      "id": "#PV12645",
      "date": "May 14, 2025",
      "price": "Rs. 8,660",
      "status": "Delivered",
    },
    {
      "id": "#PV12630",
      "date": "May 10, 2025",
      "price": "Rs. 6,250",
      "status": "Shipped",
    },
    {
      "id": "#PV12340",
      "date": "May 05, 2025",
      "price": "Rs. 7,150",
      "status": "Processing",
    },
    {
      "id": "#PV12220",
      "date": "Apr 28, 2025",
      "price": "Rs. 5,900",
      "status": "Delivered",
    },
    {
      "id": "#PV12100",
      "date": "Apr 20, 2025",
      "price": "Rs. 3,200",
      "status": "Cancelled",
    },
  ];

  List<Map<String, dynamic>> get filterOrders {
    if (selectedIndex == 0) return orders;
    return orders
        .where((orders) => orders['status'] == tabs[selectedIndex])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  BackButton(),
                  Text(
                    'My Orders',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),

              Column(
                children: [
                  SizedBox(
                    height: height * 0.05,
                    child: ListView.builder(
                      itemCount: tabs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        // ✅ ADDED: Tab widget return
                        return _buildTab(tabs[index], index, width, height);
                      },
                    ),
                  ),
                ],
              ),

              // ✅ ADDED: Orders List
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  itemCount: filterOrders.length,
                  itemBuilder: (context, index) {
                    return _buildOrderCard(filterOrders[index], width, height);
                  },
                ),
              ),

              // ✅ ADDED: View All Orders Button
              Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: TransparentPrimaryButtonWidget(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsScreen(),
                      ),
                    );
                  },
                  text: 'View All Orders',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ ADDED: Tab Widget
  Widget _buildTab(String title, int index, double width, double height) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: width * 0.04,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? AppColors.primary : Colors.grey[700],
              ),
            ),
            SizedBox(height: height * 0.005),
            if (isSelected)
              Container(
                height: 3,
                width: width * 0.06,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ✅ ADDED: Order Card Widget
  Widget _buildOrderCard(
    Map<String, dynamic> order,
    double width,
    double height,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.008),
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order["id"],
                style: TextStyle(
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: height * 0.005),
              Text(
                order["date"],
                style: TextStyle(
                  fontSize: width * 0.032,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),

          Text(
            order["price"],
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          _buildStatusBadge(order["status"], width, height),
        ],
      ),
    );
  }

  // ✅ ADDED: Status Badge Widget
  Widget _buildStatusBadge(String status, double width, double height) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case "Delivered":
        bgColor = Colors.green.withOpacity(0.15);
        textColor = Colors.green.shade700;
        break;
      case "Shipped":
        bgColor = Colors.green.withOpacity(0.15);
        textColor = Colors.green.shade700;
        break;
      case "Processing":
        bgColor = Colors.orange.withOpacity(0.15);
        textColor = Colors.orange.shade800;
        break;
      case "Cancelled":
        bgColor = Colors.red.withOpacity(0.15);
        textColor = Colors.red.shade700;
        break;
      default:
        bgColor = Colors.grey.withOpacity(0.15);
        textColor = Colors.grey.shade700;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.006,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(width * 0.015),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: width * 0.03,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/shoping%20&%20checkouts/wishlist/carts/address/checkout/card%20payment/order%20success/my%20orders/my_orders.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';
import 'package:paint_vision_ai/widgets/transparent_primary_button.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(
              children: [
                SizedBox(height: height * 0.1),
                Icon(
                  Icons.check_circle,
                  size: height * 0.15,
                  color: const Color.fromARGB(255, 19, 113, 22),
                ),

                SizedBox(height: height * 0.03),

                Text(
                  'Order Placed\nSuccessfully!',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                SizedBox(height: height * 0.03),

                Text(
                  'Your order #PV13545 has\n been places successfully',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                Spacer(),

                PrimaryButton(
                  text: 'Track Your Order',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyOrdersScreen()),
                    );
                  },
                ),

                SizedBox(height: height * 0.03),

                TransparentPrimaryButtonWidget(
                  onTap: () {},
                  text: 'Continue Shopping',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

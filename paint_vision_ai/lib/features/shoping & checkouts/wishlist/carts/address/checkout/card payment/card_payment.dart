import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/shoping%20&%20checkouts/wishlist/carts/address/checkout/card%20payment/order%20success/order_success.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';

class CardPaymentScreen extends StatefulWidget {
  const CardPaymentScreen({super.key});

  @override
  State<CardPaymentScreen> createState() => _CardPaymentScreenState();
}

class _CardPaymentScreenState extends State<CardPaymentScreen> {
  final cardNumber = TextEditingController();
  final cardHolderName = TextEditingController();
  final expiryDate = TextEditingController();
  final cvv = TextEditingController();

  bool _obscureCvv = true;
  bool _saveCard = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: const [
                BackButton(),
                Text(
                  'Credit / Debit Card',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: height * 0.03),

            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  children: [
                    // ✅ Card Number
                    TextField(
                      controller: cardNumber,
                      keyboardType: TextInputType.number,
                      maxLength: 19,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        _CardNumberFormatter(),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Card Number',
                        hintText: '•••• •••• •••• ••••',
                        hintStyle: const TextStyle(
                          color: Colors.black54,
                          letterSpacing: 2,
                        ),
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: width * 0.01),
                          child: SizedBox(
                            height: height * 0.02,
                            width: width * 0.06,
                            child: Image.asset(
                              'assets/images/visa.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    // ✅ Card Holder Name
                    TextField(
                      controller: cardHolderName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Card Holder',
                        hintText: 'Enter card holder name',
                        hintStyle: const TextStyle(color: Colors.black54),
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    // ✅ Expiry Date + CVV (Row)
                    Row(
                      children: [
                        // Expiry Date
                        Expanded(
                          child: TextField(
                            controller: expiryDate,
                            keyboardType: TextInputType.number,
                            maxLength: 5,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              _ExpiryDateFormatter(),
                            ],
                            decoration: InputDecoration(
                              labelText: 'Expiry Date',
                              hintText: 'MM/YY',
                              hintStyle: const TextStyle(color: Colors.black54),
                              counterText: "",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: width * 0.04),

                        // ✅ CVV - FIXED (icon added inside GestureDetector)
                        Expanded(
                          child: TextField(
                            controller: cvv,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            obscureText: _obscureCvv,
                            obscuringCharacter: '•',
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              labelText: 'CVV',
                              hintText: '•••',
                              hintStyle: const TextStyle(color: Colors.black54),
                              counterText: "",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.02),

                    // ✅ Save Card for Future Switch
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Save Card for Future",
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Switch(
                          value: _saveCard,
                          activeColor: Colors.white,
                          activeTrackColor: AppColors.primary,
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey.shade300,
                          onChanged: (value) {
                            setState(() {
                              _saveCard = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ✅ Pay Button (Bottom)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'Pay RS 8,250',
                onTap: () {
                  _processPayment();
                },
              ),
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  // Payment process function
  void _processPayment() {
    if (cardNumber.text.isEmpty ||
        cardHolderName.text.isEmpty ||
        expiryDate.text.isEmpty ||
        cvv.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please fill al fields"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    if (_saveCard) {
      print("Card saved for future use");
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderSuccessScreen()),
    );
  }
}

// Card Number Formatter
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll(' ', '');
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i + 1 != text.length) {
        buffer.write(' ');
      }
    }

    String formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

// Expiry Date Formatter
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll('/', '');
    StringBuffer buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if (i == 1 && text.length > 2) {
        buffer.write('/');
      }
    }

    String formatted = buffer.toString();

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:paint_vision_ai/Screens/onboarding/onboarding_dashboard.dart';
import 'package:paint_vision_ai/providers/AI%20preview%20provider/ai_preview_provider.dart';
import 'package:paint_vision_ai/providers/add%20card%20provider/add_card_provider.dart';
import 'package:paint_vision_ai/providers/additional%20feature/book%20consultant%20provider/book_consultant_provider.dart';
import 'package:paint_vision_ai/providers/additional%20feature/home%20visit%20provider/home_visit_provider.dart';
import 'package:paint_vision_ai/providers/address%20provider/add%20address/add_address_provider.dart';
import 'package:paint_vision_ai/providers/address%20provider/address_provider.dart';
import 'package:paint_vision_ai/providers/address%20provider/edit%20address%20provider/edit_address_provider.dart';
import 'package:paint_vision_ai/providers/cart%20provider/cart_provider.dart';
import 'package:paint_vision_ai/providers/comapre%20product%20provider/compare_provider.dart';
import 'package:paint_vision_ai/providers/create%20account%20provider/create_account_provider.dart';
import 'package:paint_vision_ai/providers/crop%20image%20provider/crop_image_provider.dart';
import 'package:paint_vision_ai/providers/home%20dashboard%20provider/AI%20color%20preview%20provider/Color%20matcher%20provider/color_matcher_provider.dart';
import 'package:paint_vision_ai/providers/home%20dashboard%20provider/home_dashboard_provider.dart';
import 'package:paint_vision_ai/providers/live%20chat%20provider/chat_provider.dart';
import 'package:paint_vision_ai/providers/login%20provider/login_provider.dart';
import 'package:paint_vision_ai/providers/my%20design%20provider/my_designs_provider.dart';
import 'package:paint_vision_ai/providers/notification%20provider/notification_provider.dart';
import 'package:paint_vision_ai/providers/onboarding%20provider/onboarding_provider.dart';
import 'package:paint_vision_ai/providers/payment%20provider/payment_provider.dart';
import 'package:paint_vision_ai/providers/save%20design%20provider/create%20design%20provider/create_design_provider.dart';
import 'package:paint_vision_ai/providers/save%20design%20provider/save_design_provider.dart';
import 'package:paint_vision_ai/providers/setting%20provider/change%20password%20provider/change_password_provider.dart';
import 'package:paint_vision_ai/providers/setting%20provider/notification%20setting%20provider/notification_setting_provider.dart';
import 'package:paint_vision_ai/providers/setting%20provider/settings_provider.dart';
import 'package:paint_vision_ai/providers/upload%20photo%20provider/upload_photo_provider.dart';
import 'package:paint_vision_ai/providers/wishlist%20provider/wishlist_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => MyDesignsProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => HomeDashboardProvider()),
        ChangeNotifierProvider(create: (_) => UploadPhotoProvider()),
        ChangeNotifierProvider(create: (_) => AiPreviewProvider()),
        ChangeNotifierProvider(create: (_) => SaveDesignProvider()),
        ChangeNotifierProvider(create: (_) => MyDesignsProvider()),
        ChangeNotifierProvider(create: (_) => CreateDesignProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => CreateAccountProvider()),
        ChangeNotifierProvider(create: (_) => CompareProvider()),
        ChangeNotifierProvider(create: (_) => CropImageProvider()),
        ChangeNotifierProvider(create: (_) => ColorMatcherProvider()),
        ChangeNotifierProvider(create: (_) => AddAddressProvider()),
        ChangeNotifierProvider(create: (_) => EditAddressProvider()),
        ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
        ChangeNotifierProvider(create: (_) => NotificationSettingsProvider()),
        ChangeNotifierProvider(create: (_) => AddCardProvider()),
        ChangeNotifierProvider(create: (_) => BookConsultantProvider()),
        ChangeNotifierProvider(create: (_) => HomeVisitProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: OnboardingDashboard(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

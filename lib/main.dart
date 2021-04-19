import 'package:euzzit/view/screens/startup_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:euzzit/provider/charity_provider.dart';
import 'package:euzzit/provider/gift_provider.dart';
import 'package:euzzit/provider/goals_provider.dart';
import 'package:euzzit/provider/organization_provider.dart';
import 'package:euzzit/provider/promo_provider.dart';
import 'package:euzzit/provider/step_provider.dart';
import 'package:euzzit/utility/colorResources.dart';
import 'package:euzzit/view/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'di_container.dart' as di;
var token;

Future<void> start() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
   token =  prefs.getString('accessToken');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await start();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<CharityProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrganizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<GiftProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<GoalsProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<StepProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<PromoProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EUZZIT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorResources.COLOR_WHITE,
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
      ),
      home: token == null ? SplashScreenWallet() : WalletStartupScreen());
  }
}

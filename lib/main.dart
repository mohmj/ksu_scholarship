import 'package:flutter/material.dart';
import 'package:ksu_scholarship/screens/auth_screen.dart';
import 'package:ksu_scholarship/screens/home_screen.dart';
import 'package:ksu_scholarship/screens/mother_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ksu_scholarship/screens/orders/food_supply_order_screen.dart';
import 'package:ksu_scholarship/screens/orders/housing_order_screen.dart';
import 'package:ksu_scholarship/screens/orders/visa_order_screen.dart';
import 'package:ksu_scholarship/screens/splash_screen.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MotherScreen(),
      initialRoute: SplashScreen.id,
      routes: {
        MotherScreen.id:(context)=>MotherScreen(),
        HomeScreen.id:(context)=>HomeScreen(),
        AuthScreen.id:(context)=>AuthScreen(),
        HousingOrderScreen.id:(context)=>HousingOrderScreen(),
        FoodSupplyOrderScreen.id:(context)=>FoodSupplyOrderScreen(),
        VisaOrderScreen.id:(context)=>VisaOrderScreen(),
        SplashScreen.id:(context)=>SplashScreen(),
      },
    );
  }
}
import 'package:attender/screens/home_screen.dart';
import 'package:attender/screens/signIn_screen.dart';
import 'package:attender/utils/storageHandler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHandler().initPreferences();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          useMaterial3: true,
          fontFamily: 'Google Sans'),
      // home: const HomeScreen(title: 'Flutter Demo Home Page'),
      home: SignInScreen(),
    );
  }
}

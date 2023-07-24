import 'package:attender/Provider/authenticationProvider.dart';
import 'package:attender/Provider/subjectProvider.dart';
import 'package:attender/screens/home_screen.dart';
import 'package:attender/screens/signIn_screen.dart';
import 'package:attender/utils/storageHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageHandler().initPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticaionProvider>(
          create: (context) => AuthenticaionProvider(),
        ),
        ChangeNotifierProvider<SubjectProvider>(
          create: (context) => SubjectProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            useMaterial3: true,
            fontFamily: 'Google Sans'),
        // home: const HomeScreen(title: 'Flutter Demo Home Page'),
        home: StorageHandler().getToken() == ""
            ? SignInScreen()
            : HomeScreen(title: 'Attender'),
      ),
    );
  }
}

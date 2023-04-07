import 'dart:convert';

import 'package:attender/Provider/authenticationProvider.dart';
import 'package:attender/screens/home_screen.dart';
import 'package:attender/screens/signUp_screen.dart';
import 'package:attender/utils/storageHandler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userName = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('A', style: TextStyle(fontSize: 40, color: Colors.purple)),
                Text('ttender', style: TextStyle(fontSize: 40)),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            TextFormField(
              controller: userName,
              decoration: InputDecoration(labelText: "Username"),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: password,
              obscureText: false,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    http.Response res =
                        await Provider.of<AuthenticaionProvider>(context,
                                listen: false)
                            .singIn(
                      userName: userName.text,
                      password: password.text,
                    );

                    if (res.statusCode == 401) {
                      print("Incorrect username or password");
                    } else {
                      var jsonResponse = await jsonDecode(res.body);
                      StorageHandler().setToken(jsonResponse["token"]);
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(
                            title: 'Attender',
                          ),
                        ),
                      );
                    }
                  },
                  child: Text("Submit"),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
                  },
                  child: Text("Sign Up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

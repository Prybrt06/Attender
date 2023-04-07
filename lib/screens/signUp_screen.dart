import 'package:attender/screens/signIn_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('A', style: TextStyle(fontSize: 40,color: Colors.purple)),
                const Text('ttender', style: TextStyle(fontSize: 40)),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Name"),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Scholar Id"),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Username"),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Submit"),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ),
                    );
                  },
                  child: Text("Sign In"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

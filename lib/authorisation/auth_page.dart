import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todoey/screens/tasks_screen.dart';
import '../screens/welcome_page.dart';




class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? newUser) {
      setState(() {
        user = newUser;
      });
    });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {

            if (kDebugMode) {
              print(
                  "Auth state snapshot: ${snapshot.connectionState}, ${snapshot.hasData}");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData) {
              if (kDebugMode) {
                print("User is logged in");
              }
              return  TasksScreen(user!.email!);
            } else {
              if (kDebugMode) {
                print("User is not logged in");
              }
              return const WelcomeScreen();
            }
          }),
    );
  }
}

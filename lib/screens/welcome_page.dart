import 'package:flutter/material.dart';
import '../authorisation/login_page.dart';
import '../authorisation/signup_page.dart';
import '../constants.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white

        ),
        child: Column(children: [
          const SizedBox(
            height: 100,
          ),
          Image.asset('assets/tablet.gif',scale: 3.5,),
          const SizedBox(
            height: 60,
          ),

          const Text(
            'TASKIFY',
            style: TextStyle(fontSize: 30, color: Colors.black87,fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Container(
              height: 53,
              width: 320,
              decoration:  BoxDecoration(
                gradient: kGradient,

                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
              ),
              child: const Center(
                child: Text(
                  'SIGN IN',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RegScreen()));
            },
            child: Container(
              height: 53,
              width: 320,
              decoration: BoxDecoration(
                gradient: kGradient,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
              ),
              child: const Center(
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const Spacer(),
          const Text(
            'Get Things Done',
            style: TextStyle(fontSize: 17, color:kAuthTextColour,fontWeight: FontWeight.bold ),
          ), //
          const SizedBox(
            height: 12,
          ),

        ],),
      ),
    );
  }
}

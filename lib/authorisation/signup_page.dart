import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoey/screens/tasks_screen.dart';
import '../constants.dart';
import 'login_page.dart';



class RegScreen extends StatefulWidget {
  const RegScreen({super.key});

  @override
  State<RegScreen> createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();


  void showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  void signUp()async{
    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },);
    try {
      if(passwordController.text == confirmPasswordController.text){
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        final FirebaseAuth _auth = FirebaseAuth.instance;
        final FirebaseFirestore _firestore = FirebaseFirestore.instance;
          User? user = _auth.currentUser;
          if (user != null) {
            String email = userCredential.user?.email ?? '';
              await _firestore.collection('users').doc(email).set({});
              if (kDebugMode) {
                print("Document created with email as ID.");
              }

      }

        if (kDebugMode) {
          print("Signed in as ${userCredential.user?.email}");
        }
      }
      else{
        showErrorDialog('OOPs an error occurred', 'Make sure the password and confirm password are same');
      }
      // Navigate to homescreen on successful signup
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const TasksScreen()));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorDialog('Error', e.code);
    }

  }
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: kGradient
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 75.0, left: 22),
                child: Text(
                  'Create Your\nAccount',
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 250.0),
              child: Container(
                padding: const EdgeInsets.only(top: 29),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 22.0, right: 22),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: nameController ,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(
                                Icons.check,
                                color: Colors.grey,
                              ),
                              label: Text(
                                'Full Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kAuthTextColour,
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          style: const TextStyle(color: Colors.black87),
                          controller: emailController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.check,
                              color: Colors.grey,
                            ),
                            label: Text(
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kAuthTextColour,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          style: const TextStyle(color: Colors.black87),
                          controller: passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText =
                                  !_obscureText; // Toggle the obscure text status
                                });
                              },
                            ),
                            label: const Text(
                              'Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kAuthTextColour),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          style: const TextStyle(color: Colors.black87),
                          controller: confirmPasswordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText =
                                  !_obscureText; // Toggle the obscure text status
                                });
                              },
                            ),
                            label: const Text(
                              'Confirm Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kAuthTextColour),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: signUp,
                          child: Container(
                            height: 55,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: kGradient
                            ),
                            child: const Center(
                              child: Text(
                                'SIGN UP',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                                },
                                child: const Text(
                                  "Sign in",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

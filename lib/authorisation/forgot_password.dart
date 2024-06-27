import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';



class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
  final _emailController=TextEditingController();
  Future forgotPassword()async{

    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showErrorDialog('YAYY', 'Password Reset link sent on the given Email.');
    } on FirebaseAuthException catch(e){
      showErrorDialog('Error', e.code);
    }


  }

  @override

  void dispose(){
    _emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: kGradient
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 75, left: 23),
            child: Text(
              "Don't Worry\nWe got you!",
              style: TextStyle(
                  fontSize: 33,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 228.0),
          child: Container(
            padding: const EdgeInsets.only(top: 18.0),
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const Text(textAlign: TextAlign.center,'Enter your Email below and we will send you a link to reset your password.',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                    const SizedBox(
                      height: 35,
                    ),
                    TextField(
                      style: const TextStyle(color: Colors.black87),
                      controller: _emailController,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.check,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kAuthTextColour),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 75,
                    ),


                    GestureDetector(
                      onTap: forgotPassword,
                      child: Container(
                        height: 50,
                        width: 230,
                        decoration: BoxDecoration(
                            gradient: kGradient,
                            borderRadius: BorderRadius.circular(40)),
                        child: const Center(
                          child: Text(
                            "RESET PASSWORD",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 140,
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

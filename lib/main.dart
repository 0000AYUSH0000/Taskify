import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/authorisation/auth_page.dart';
import 'package:todoey/services/theme_provider.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  FirebaseFirestore.instance.settings= const Settings(
    persistenceEnabled: true
  );
  runApp(ChangeNotifierProvider(
      create: (context)=>ThemeProvider(),
      child: const ToDoApp()));
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (BuildContext context, ThemeProvider value, Widget? child) {
        return MaterialApp(
          themeMode: value.themeMode,
          darkTheme: ThemeData.dark().copyWith(
            textTheme: ThemeData.dark().textTheme.apply(
              fontFamily: 'RedditMono',
            ),
          ),
          theme: ThemeData(
              fontFamily: 'RedditMono'
          ),
          debugShowCheckedModeBanner: false,
          home: const AuthScreen(),
        );
    });

  }
}


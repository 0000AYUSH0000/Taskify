import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoey/constants.dart';
import 'package:todoey/screens/welcome_page.dart';
import 'package:todoey/widgets/theme_toggle_switch.dart';
import '../widgets/completed_task_count.dart';
import '../widgets/pending_task_count.dart';
import '../widgets/tasks_list.dart';
import 'package:todoey/screens/add_task_screen.dart';
import '../widgets/total_task_count.dart';


User? user = FirebaseAuth.instance.currentUser;

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => TasksScreenState();
}

class TasksScreenState extends State<TasksScreen> {

  Widget buildBottomSheet(BuildContext context){
    return const AddTaskScreen();
  }


  @override
  Widget build(BuildContext context) {
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
    void signOut() {
      try {
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const WelcomeScreen()));
      } on FirebaseAuthException catch (e) {
        showErrorDialog('Error', e.code);
      }
    }
        return Scaffold(
          floatingActionButton: Container(
            decoration: BoxDecoration(
                gradient: kGradient,
                borderRadius: BorderRadius.circular(20)
            ),
            child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                child: const Icon(Icons.add,color: Colors.white,),
                onPressed: (){showModalBottomSheet(context: context, builder: buildBottomSheet);}),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration:   BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                    gradient: kGradient
                ),
                width: double.infinity,
                child: Padding(
                  padding:
                  const EdgeInsets.only(top: 55, left: 30, right: 30, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 25,

                        child: GestureDetector(
                            onTap: signOut,
                            child: GestureDetector(
                                onTap:signOut,
                                child: const Icon(Icons.arrow_back, size: 30, color: Colors.purpleAccent))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'TASKIFY',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 35,
                            fontFamily: 'RedditMono',color: Colors.black87),
                      ),
                      const TaskCountWidget(),
                      const PendingTaskCountWidget(),
                      const CompletedTaskCountWidget(),
                      const Row(
                        children: [
                          Text('Dark Mode',style: TextStyle(fontSize: 18,color: Colors.black87),),
                          SizedBox(width: 10,),
                          ThemeToggleSwitch(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30)
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 7 ,vertical: 10),
                  height: 497,
                  width: double.infinity,
                  child: TaskList(),
                ),
              ),
            ],
          ),
        );


  }
}



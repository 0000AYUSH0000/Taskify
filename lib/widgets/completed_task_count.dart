import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/tasks_screen.dart';

 final firestore=FirebaseFirestore.instance;

Stream<int> getCompletedTasksStream(String? userEmail) {
  return firestore
      .collection('users')
      .doc(userEmail)
      .collection('todos')
      .where('isDone', isEqualTo: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.length);
}

class CompletedTaskCountWidget extends StatelessWidget {
  const CompletedTaskCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: getCompletedTasksStream(user!.email),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('0 TASKS',style: TextStyle(fontSize: 18),);
        } else {
          return Text('${snapshot.data} Completed',style: const TextStyle(fontSize: 18,color: Colors.black87),);
        }
      },
    );
  }
}

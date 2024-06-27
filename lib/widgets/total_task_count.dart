import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



final firestore=FirebaseFirestore.instance;
Stream<int> getTotalTasksStream(String ?userEmail) {
  return firestore
      .collection('users')
      .doc(userEmail)
      .collection('todos')
      .snapshots()
      .map((snapshot) => snapshot.docs.length);
}


class TaskCountWidget extends StatelessWidget {
  const TaskCountWidget({super.key, required this.userEmail});
  final String userEmail;

@override
Widget build(BuildContext context) {
  return StreamBuilder<int>(
    stream: getTotalTasksStream(userEmail),
    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else if (!snapshot.hasData || snapshot.data == 0) {
        return const Text('0 TASKS',style: TextStyle(fontSize: 18,color: Colors.black87),);
      } else {
        return Text('${snapshot.data} TASKS',style: const TextStyle(fontSize: 18,color: Colors.black),);
      }
    },
  );
}
}
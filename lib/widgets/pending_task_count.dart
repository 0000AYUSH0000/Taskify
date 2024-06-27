import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final firestore=FirebaseFirestore.instance;
Stream<int> getPendingTasksStream(String? userEmail) {
  return firestore
      .collection('users')
      .doc(userEmail)
      .collection('todos')
      .where('isDone', isEqualTo: false)
      .snapshots()
      .map((snapshot) => snapshot.docs.length);
}

class PendingTaskCountWidget extends StatelessWidget {
  const PendingTaskCountWidget({super.key, required this.userEmail});
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: getPendingTasksStream(userEmail),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('0 TASKS',style: TextStyle(fontSize: 18),);
        } else {
          return Text('${snapshot.data} Pending',style: const TextStyle(fontSize: 18,color: Colors.black87),);
        }
      },
    );
  }
}

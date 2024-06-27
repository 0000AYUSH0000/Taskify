import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/firebase_functions.dart';
import 'task_tile.dart';


class TaskList extends StatelessWidget {
  const TaskList({super.key, required this.userEmail});
  final String userEmail;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail)
          .collection('todos')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No tasks found.',style: TextStyle(fontSize: 22),),
          );
        } else {
          final tasks = snapshot.data!.docs;
          List<Widget> taskWidgets = [];

          for (var task in tasks) {
            final taskData = task.data() as Map<String, dynamic>;
            final taskText = taskData['task'];
            final isDone = taskData['isDone'];
            final taskId = task.id;

            final taskWidget = TaskTile(
              taskID: taskId,
              isChecked: isDone,
              taskTitle: taskText,
              checkboxCallBack: () => toggleTaskCompletion(userEmail,taskId, isDone), userEmail: userEmail,
            );
            taskWidgets.add(taskWidget);
            taskWidgets.sort((a, b) {

              bool isDoneA = (a as TaskTile).isChecked;
              return isDoneA ? 1 : -1;
            });

          }

          return ListView(
            children: taskWidgets,
          );
        }
      },
    );
  }
}

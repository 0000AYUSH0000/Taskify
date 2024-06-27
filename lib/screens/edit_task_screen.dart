import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoey/services/firebase_functions.dart';



final firestore = FirebaseFirestore.instance;
void showEditTaskBottomSheet(
    BuildContext context, String taskId, String currentTask,String userEmail) {

  final TextEditingController taskController =
  TextEditingController(
    text: currentTask
  );
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
        width: double.infinity,
        child: Column(
          children: [
            const Text(
              'EDIT TASK',
              style: TextStyle(
                  fontFamily: 'RedditMono',
                  fontSize: 30,
                  fontWeight: FontWeight.w900),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: taskController,
                autofocus: true,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                String updatedTask = taskController.text;
                if (updatedTask.isNotEmpty) {
                  updateTask(updatedTask, taskId,userEmail);
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: 140,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'SAVE',
                    style: TextStyle(fontFamily: 'RedditMono', fontSize: 30),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

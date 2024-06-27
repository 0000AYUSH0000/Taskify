import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> deleteTask(String taskId) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .collection('todos')
        .doc(taskId)
        .delete();
  }
}

Future<void> toggleTaskCompletion(String taskId, bool currentStatus) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .collection('todos')
        .doc(taskId)
        .update({
      'isDone': !currentStatus,
    });
  }
}


Future<void> addTask(String task) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.email)
        .collection('todos')
        .add({
      'task': task,
      'isDone': false,
    });
  }
}



Future<void> updateTask(String updatedTask,String taskId) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    if (updatedTask.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.email)
          .collection('todos')
          .doc(taskId)
          .update({'task': updatedTask});
    }
  }
}

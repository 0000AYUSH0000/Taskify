import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteTask(String taskId,String userEmail) async {

  await FirebaseFirestore.instance
      .collection('users')
      .doc(userEmail)
      .collection('todos')
      .doc(taskId)
      .delete();
}

Future<void> toggleTaskCompletion(String userEmail,String taskId, bool currentStatus) async {

  await FirebaseFirestore.instance
      .collection('users')
      .doc(userEmail)
      .collection('todos')
      .doc(taskId)
      .update({
    'isDone': !currentStatus,
  });
}


Future<void> addTask(String task,String userEmail) async {

  await FirebaseFirestore.instance
      .collection('users')
      .doc(userEmail)
      .collection('todos')
      .add({
    'task': task,
    'isDone': false,
  });
}



Future<void> updateTask(String updatedTask,String taskId,String userEmail) async {

  if (updatedTask.isNotEmpty) {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .collection('todos')
        .doc(taskId)
        .update({'task': updatedTask});
  }
}

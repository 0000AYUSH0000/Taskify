import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoey/screens/edit_task_screen.dart';
import 'package:todoey/services/firebase_functions.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final String taskID;
  final VoidCallback checkboxCallBack;
  final String userEmail;

  const TaskTile({
    super.key,
    required this.isChecked,
    required this.taskTitle,
    required this.checkboxCallBack,
    required this.taskID, required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              deleteTask(taskID,userEmail);
            },
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          )
        ],
      ),
      child: ListTile(
        leading: Checkbox(
          value: isChecked,
          onChanged: (value) {
           checkboxCallBack();
          },
        ),
        title: GestureDetector(
          onTap: () => showEditTaskBottomSheet(context, taskID, taskTitle,userEmail),
          child: Text(
            taskTitle,
            style: TextStyle(
              decoration: isChecked ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
    );
  }
}

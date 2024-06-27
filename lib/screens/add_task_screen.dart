import 'package:flutter/material.dart';
import '../services/firebase_functions.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, required this.userEmail});
  final String userEmail;
  @override
  AddTaskScreenState createState() => AddTaskScreenState();
}

class AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String newTaskTitle = ''; // Initialize with an empty string

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
      width: double.infinity,
      child: Column(
        children: [
          const Text(
            'ADD TASK',
            style: TextStyle(fontFamily: 'RedditMono', fontSize: 30, fontWeight: FontWeight.w900),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: _textEditingController,
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                setState(() {
                  newTaskTitle = newText;
                });
              },

            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              if(newTaskTitle.trim().isNotEmpty){
                addTask(newTaskTitle.trim(),widget.userEmail);
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
                  'ADD',
                  style: TextStyle(fontFamily: 'RedditMono', fontSize: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  @override
  void dispose() {
    _taskNameController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  Future<void> _addTask() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection("Tasks").add({
        "taskname": _taskNameController.text,
        "starttime": _startTimeController.text,
        "endtime": _endTimeController.text,
      });

      Navigator.pop(context); // Return to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Task",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF414688),
      ),
      body:   // Wrap with SingleChildScrollView
      SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: 400,
                    height: 240,
                    child: Image.asset("img/chart-graph-business-finance.jpg"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _taskNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelText: "Task Name",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter task name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: _startTimeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelText: "Start Time",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter start time';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    controller: _endTimeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      labelText: "End Time",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter end time';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addTask,
                    child: const Text(
                      "Add Task",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
                    ),
          ),

      backgroundColor: const Color(0xFFFDDE5F2),
    );
  }
}

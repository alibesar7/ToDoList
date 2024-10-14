import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'creatscreen.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF414688),
        title: const Text(
          "Tasks of Day",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFFF414688),
              ),
              child: const Text(
                'Hello Sir',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Repetitive Tasks'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RepetitiveTasksScreen()),
                );
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ),
      body:
      SingleChildScrollView(
        child: SingleChildScrollView( // Scrollable body
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Tasks").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text("Error loading tasks"));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 340 ,left: 145),
                  child: const
                  Text("No Tasks found"),
                );
              }

              return ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Prevent scrolling conflicts
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  return CustomCard(
                    taskname: document["taskname"],
                    starttime: document["starttime"],
                    endtime: document["endtime"],
                    documentId: document.id,
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateTaskScreen()),
          );
        },
        child: const Icon(Icons.add, size: 50),
      ),
      backgroundColor: Color(0xFFFDDE5F2),
    );
  }
}

class CustomCard extends StatefulWidget {
  final String taskname;
  final String starttime;
  final String endtime;
  final String documentId;

  const CustomCard({
    Key? key,
    required this.taskname,
    required this.starttime,
    required this.endtime,
    required this.documentId,
  }) : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool isCompleted = false;

  void _toggleCompletion() async {
    setState(() {
      isCompleted = !isCompleted;
    });

    if (isCompleted) {
      await FirebaseFirestore.instance.collection("Tasks").doc(widget.documentId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.taskname} completed and removed!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(
          widget.taskname,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('From: ${widget.starttime}\nTo: ${widget.endtime}'),
        trailing: IconButton(
          icon: Icon(
            isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
            color: isCompleted ? Colors.green : null,
          ),
          onPressed: _toggleCompletion,
        ),
      ),
    );
  }
}

class RepetitiveTasksScreen extends StatefulWidget {
  const RepetitiveTasksScreen({super.key});

  @override
  _RepetitiveTasksScreenState createState() => _RepetitiveTasksScreenState();
}

class _RepetitiveTasksScreenState extends State<RepetitiveTasksScreen> {
  void _showAddTaskDialog() {
    final TextEditingController taskNameController = TextEditingController();
    final TextEditingController startTimeController = TextEditingController();
    final TextEditingController endTimeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Repetitive Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskNameController,
                decoration: const InputDecoration(labelText: 'Task Name'),
              ),
              TextField(
                controller: startTimeController,
                decoration: const InputDecoration(labelText: 'Start Time'),
              ),
              TextField(
                controller: endTimeController,
                decoration: const InputDecoration(labelText: 'End Time'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final String taskName = taskNameController.text;
                final String startTime = startTimeController.text;
                final String endTime = endTimeController.text;

                if (taskName.isNotEmpty && startTime.isNotEmpty && endTime.isNotEmpty) {
                  _addTask(taskName, startTime, endTime);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$taskName added to repetitive tasks!')),
                  );
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addTask(String taskName, String startTime, String endTime) async {
    await FirebaseFirestore.instance.collection("RepetitiveTasks").add({
      "taskname": taskName,
      "starttime": startTime,
      "endtime": endTime,
      "isRemoved": false,
    });
  }

  void _deleteTask(String documentId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Removal'),
        content: const Text('Are you sure you want to remove this task from repetitive tasks?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseFirestore.instance.collection("RepetitiveTasks").doc(documentId).update({"isRemoved": true});
              Navigator.of(context).pop(); // Close the dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: const Text('Task marked as removed!')),
              );
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _addToMainTasks(String documentId) async {
    final taskDoc = await FirebaseFirestore.instance.collection("RepetitiveTasks").doc(documentId).get();
    if (taskDoc.exists) {
      final data = taskDoc.data();
      if (data != null) {
        await FirebaseFirestore.instance.collection("Tasks").add({
          "taskname": data["taskname"],
          "starttime": data["starttime"],
          "endtime": data["endtime"],
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('Task added to main tasks!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repetitive Tasks', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFF414688),
      ),
      body:   // Scrollable body
         StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("RepetitiveTasks").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Error loading tasks"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("No repetitive tasks added."));
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Prevent scrolling conflicts
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final task = snapshot.data!.docs[index];
                if (task["isRemoved"] == false) {
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(task["taskname"]),
                      subtitle: Text('From: ${task["starttime"]} To: ${task["endtime"]}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteTask(task.id),
                            color: Colors.red,
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => _addToMainTasks(task.id),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container(); // Hide removed tasks
              },
            );
          },
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
      backgroundColor: Color(0xFFFDDE5F2),
    );
  }
}

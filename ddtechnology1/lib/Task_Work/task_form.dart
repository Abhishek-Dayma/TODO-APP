import 'package:ddtechnology1/Task_Work/firestoreservice/firestore_provider.dart';
import 'package:ddtechnology1/Task_Work/task_model.dart';
import 'package:ddtechnology1/notification_service.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaskFormScreen extends ConsumerStatefulWidget {
  final Task? task;
  TaskFormScreen({this.task});

  @override
  _TaskFormScreenState createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends ConsumerState<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _deadline = DateTime.now();
  Duration _expectedDuration = Duration(hours: 1);
  bool _isComplete = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
      _deadline = widget.task!.deadline;
      _expectedDuration = widget.task!.expectedDuration;
      _isComplete = widget.task!.isComplete;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              ListTile(
                title: Text('Deadline: ${_deadline.toLocal()}'.split(' ')[0]),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: _pickDate,
              ),
              ListTile(
                title: Text(
                    'Expected Duration: ${_expectedDuration.inHours} hours'),
                trailing: Icon(Icons.keyboard_arrow_down),
                onTap: _pickDuration,
              ),
              SwitchListTile(
                title: Text('Complete'),
                value: _isComplete,
                onChanged: (value) {
                  setState(() {
                    _isComplete = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newTask = Task(
                      id: widget.task?.id ?? '',
                      title: _titleController.text,
                      description: _descriptionController.text,
                      deadline: _deadline,
                      expectedDuration: _expectedDuration,
                      isComplete: _isComplete,
                    );

                    if (widget.task == null) {
                      ref.read(firestoreService).addTask(newTask);
                      scheduleTaskNotification(newTask);
                    } else {
                      ref.read(firestoreService).updateTask(newTask);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.task == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _deadline) {
      setState(() {
        _deadline = picked;
      });
    }
  }

  Future<void> _pickDuration() async {
    Duration? picked = await showDurationPicker(
      context: context,
      initialTime: _expectedDuration,
    );
    if (picked != null && picked != _expectedDuration) {
      setState(() {
        _expectedDuration = picked;
      });
    }
  }

  void scheduleTaskNotification(Task task) {
    final notificationService = NotificationService();
    notificationService.init();
    DateTime scheduledTime = task.deadline.subtract(Duration(minutes: 10));
    notificationService.scheduleNotification(
      'Task Reminder',
      'Your task "${task.title}" is due soon.',
      scheduledTime,
    );
  }
}






// import 'package:ddtechnology1/Task_Work/firestoreservice/firestore_provider.dart';
// import 'package:ddtechnology1/Task_Work/task_model.dart';
// import 'package:ddtechnology1/notification_service.dart';
// import 'package:duration_picker/duration_picker.dart'; // Add this import
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class TaskFormScreen extends ConsumerStatefulWidget {
//   final Task? task;
//   TaskFormScreen({this.task});

//   @override
//   _TaskFormScreenState createState() => _TaskFormScreenState();
// }

// class _TaskFormScreenState extends ConsumerState<TaskFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   DateTime _deadline = DateTime.now();
//   Duration _expectedDuration = Duration(hours: 1);
//   bool _isComplete = false;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.task != null) {
//       _titleController.text = widget.task!.title;
//       _descriptionController.text = widget.task!.description;
//       _deadline = widget.task!.deadline;
//       _expectedDuration = widget.task!.expectedDuration;
//       _isComplete = widget.task!.isComplete;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(), labelText: 'Title'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a title';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: const InputDecoration(
//                     border: OutlineInputBorder(), labelText: 'Description'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a description';
//                   }
//                   return null;
//                 },
//               ),
//               ListTile(
//                 title: Text('Deadline: ${_deadline.toLocal()}'.split(' ')[0]),
//                 trailing: Icon(Icons.keyboard_arrow_down),
//                 onTap: _pickDate,
//               ),
//               ListTile(
//                 title: Text(
//                     'Expected Duration: ${_expectedDuration.inHours} hours'),
//                 trailing: Icon(Icons.keyboard_arrow_down),
//                 onTap: _pickDuration,
//               ),
//               SwitchListTile(
//                 title: Text('Complete'),
//                 value: _isComplete,
//                 onChanged: (value) {
//                   setState(() {
//                     _isComplete = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     final newTask = Task(
//                       id: widget.task?.id ?? '',
//                       title: _titleController.text,
//                       description: _descriptionController.text,
//                       deadline: _deadline,
//                       expectedDuration: _expectedDuration,
//                       isComplete: _isComplete,
//                     );

//                     if (widget.task == null) {
//                       ref.read(firestoreService).addTask(newTask);
//                       scheduleTaskNotification(newTask);
//                     } else {
//                       ref.read(firestoreService).updateTask(newTask);
//                     }

//                     Navigator.pop(context);
//                   }
//                 },
//                 child: Text(widget.task == null ? 'Add' : 'Update'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _pickDate() async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _deadline,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _deadline) {
//       setState(() {
//         _deadline = picked;
//       });
//     }
//   }

//   Future<void> _pickDuration() async {
//     Duration? picked = await showDurationPicker(
//       context: context,
//       initialTime: _expectedDuration,
//     );
//     if (picked != null && picked != _expectedDuration) {
//       setState(() {
//         _expectedDuration = picked;
//       });
//     }
//   }

//   void scheduleTaskNotification(Task task) {
//     final notificationService = NotificationService();
//     notificationService.init();
//     DateTime scheduledTime = task.deadline.subtract(Duration(minutes: 10));
//     notificationService.scheduleNotification(
//       'Task Reminder',
//       'Your task "${task.title}" is due soon.',
//       scheduledTime,
//     );
//   }
// }




// import 'package:ddtechnology1/notification_service.dart';
// import 'package:ddtechnology1/providers/providers.dart';
// import 'package:ddtechnology1/task_model.dart';
// import 'package:duration_picker/duration_picker.dart'; // Add this import
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class TaskFormScreen extends StatefulWidget {
//   final Task? task;
//   TaskFormScreen({this.task});

//   @override
//   _TaskFormScreenState createState() => _TaskFormScreenState();
// }

// class _TaskFormScreenState extends State<TaskFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   DateTime _deadline = DateTime.now();
//   Duration _expectedDuration = Duration(hours: 1);
//   bool _isComplete = false;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.task != null) {
//       _titleController.text = widget.task!.title;
//       _descriptionController.text = widget.task!.description;
//       _deadline = widget.task!.deadline;
//       _expectedDuration = widget.task!.expectedDuration;
//       _isComplete = widget.task!.isComplete;
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _titleController,
//                 decoration: InputDecoration(labelText: 'Title'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a title';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a description';
//                   }
//                   return null;
//                 },
//               ),
//               ListTile(
//                 title: Text('Deadline: ${_deadline.toLocal()}'.split(' ')[0]),
//                 trailing: Icon(Icons.keyboard_arrow_down),
//                 onTap: _pickDate,
//               ),
//               ListTile(
//                 title: Text('Expected Duration: ${_expectedDuration.inHours} hours'),
//                 trailing: Icon(Icons.keyboard_arrow_down),
//                 onTap: _pickDuration,
//               ),
//               SwitchListTile(
//                 title: Text('Complete'),
//                 value: _isComplete,
//                 onChanged: (value) {
//                   setState(() {
//                     _isComplete = value;
//                   });
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     final newTask = Task(
//                       id: widget.task?.id ?? '',
//                       title: _titleController.text,
//                       description: _descriptionController.text,
//                       deadline: _deadline,
//                       expectedDuration: _expectedDuration,
//                       isComplete: _isComplete,
//                     );

//                     if (widget.task == null) {
//                       ref.read(firestoreService).addTask(newTask);
//                       scheduleTaskNotification(newTask);
//                     } else {
//                       ref.read(firestoreService).updateTask(newTask);
//                     }

//                     Navigator.pop(context);
//                   }
//                 },
//                 child: Text(widget.task == null ? 'Add' : 'Update'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _pickDate() async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _deadline,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null && picked != _deadline) {
//       setState(() {
//         _deadline = picked;
//       });
//     }
//   }

//   Future<void> _pickDuration() async {
//     Duration? picked = await showDurationPicker(
//       context: context,
//       initialTime: _expectedDuration,
//     );
//     if (picked != null && picked != _expectedDuration) {
//       setState(() {
//         _expectedDuration = picked;
//       });
//     }
//   }

//   void scheduleTaskNotification(Task task) {
//     final notificationService = NotificationService();
//     notificationService.init();
//     DateTime scheduledTime = task.deadline.subtract(Duration(minutes: 10));
//     notificationService.scheduleNotification(
//       'Task Reminder',
//       'Your task "${task.title}" is due soon.',
//       scheduledTime,
//     );
//   }
// }





// // import 'package:ddtechnology1/notification_service.dart';
// // import 'package:ddtechnology1/providers/providers.dart';
// // import 'package:ddtechnology1/task_model.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';


// // class TaskFormScreen extends StatefulWidget {
// //   final Task? task;
// //   TaskFormScreen({this.task});

// //   @override
// //   _TaskFormScreenState createState() => _TaskFormScreenState();
// // }

// // class _TaskFormScreenState extends State<TaskFormScreen> {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController _titleController = TextEditingController();
// //   final TextEditingController _descriptionController = TextEditingController();
// //   DateTime _deadline = DateTime.now();
// //   Duration _expectedDuration = Duration(hours: 1);
// //   bool _isComplete = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     if (widget.task != null) {
// //       _titleController.text = widget.task!.title;
// //       _descriptionController.text = widget.task!.description;
// //       _deadline = widget.task!.deadline;
// //       _expectedDuration = widget.task!.expectedDuration;
// //       _isComplete = widget.task!.isComplete;
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context,WidgetRef ref) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
// //       ),
// //       body: Padding(
// //         padding: EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             children: [
// //               TextFormField(
// //                 controller: _titleController,
// //                 decoration: InputDecoration(labelText: 'Title'),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter a title';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               TextFormField(
// //                 controller: _descriptionController,
// //                 decoration: InputDecoration(labelText: 'Description'),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return 'Please enter a description';
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               ListTile(
// //                 title: Text('Deadline: ${_deadline.toLocal()}'.split(' ')[0]),
// //                 trailing: Icon(Icons.keyboard_arrow_down),
// //                 onTap: _pickDate,
// //               ),
// //               ListTile(
// //                 title: Text('Expected Duration: ${_expectedDuration.inHours} hours'),
// //                 trailing: Icon(Icons.keyboard_arrow_down),
// //                 onTap: _pickDuration,
// //               ),
// //               SwitchListTile(
// //                 title: Text('Complete'),
// //                 value: _isComplete,
// //                 onChanged: (value) {
// //                   setState(() {
// //                     _isComplete = value;
// //                   });
// //                 },
// //               ),
// //               SizedBox(height: 20),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   if (_formKey.currentState!.validate()) {
// //                     final newTask = Task(
// //                       id: widget.task?.id ?? '',
// //                       title: _titleController.text,
// //                       description: _descriptionController.text,
// //                       deadline: _deadline,
// //                       expectedDuration: _expectedDuration,
// //                       isComplete: _isComplete,
// //                     );

// //                     if (widget.task == null) {
// //                       ref.read(firestoreService).addTask(newTask);
// //                       scheduleTaskNotification(newTask);
// //                     } else {
// //                       ref.read(firestoreService).updateTask(newTask);
// //                     }

// //                     Navigator.pop(context);
// //                   }
// //                 },
// //                 child: Text(widget.task == null ? 'Add' : 'Update'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _pickDate() async {
// //     DateTime? picked = await showDatePicker(
// //       context: context,
// //       initialDate: _deadline,
// //       firstDate: DateTime.now(),
// //       lastDate: DateTime(2101),
// //     );
// //     if (picked != null && picked != _deadline) {
// //       setState(() {
// //         _deadline = picked;
// //       });
// //     }
// //   }

// //   Future<void> _pickDuration() async {
// //     Duration? picked = await showDurationPicker(
// //       context: context,
// //       initialDuration: _expectedDuration,
// //     );
// //     if (picked != null && picked != _expectedDuration) {
// //       setState(() {
// //         _expectedDuration = picked;
// //       });
// //     }
// //   }

// //   void scheduleTaskNotification(Task task) {
// //     final notificationService = NotificationService();
// //     notificationService.init();
// //     DateTime scheduledTime = task.deadline.subtract(Duration(minutes: 10));
// //     notificationService.scheduleNotification(
// //       'Task Reminder',
// //       'Your task "${task.title}" is due soon.',
// //       scheduledTime,
// //     );
// //   }
// // }

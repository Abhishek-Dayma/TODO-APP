import 'package:ddtechnology1/AuthWrapper/providers/providers.dart';
import 'package:ddtechnology1/Login_or_Register_Screens/login_screen.dart';
import 'package:ddtechnology1/Task_Work/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firestoreservice/firestore_provider.dart';
import 'task_form.dart';

class TaskListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskListAsyncValue = ref.watch(tasksProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              ref.read(authProvider1).signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
          )
        ],
      ),
      body: taskListAsyncValue.when(
        data: (tasks) {
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Color.fromARGB(255, 246, 235, 248),
                  child: ListTile(
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(task.isComplete
                              ? Icons.check_box
                              : Icons.check_box_outline_blank),
                          onPressed: () async {
                            final updatedTask = Task(
                              id: task.id,
                              title: task.title,
                              description: task.description,
                              deadline: task.deadline,
                              expectedDuration: task.expectedDuration,
                              isComplete: !task.isComplete,
                            );
                            try {
                              await ref
                                  .read(firestoreService)
                                  .updateTask(updatedTask);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            try {
                              await ref
                                  .read(firestoreService)
                                  .deleteTask(task.id);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TaskFormScreen(task: task)),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            Center(child: Text('Something went wrong: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskFormScreen(task: null)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}



// import 'package:ddtechnology1/providers/providers.dart';
// import 'package:ddtechnology1/Task_Work/task_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'firestoreservice/firestore_provider.dart';
// import 'task_form.dart';

// class TaskListScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final taskListAsyncValue = ref.watch(tasksProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tasks'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               ref.read(authProvider1).signOut();
//             },
//           )
//         ],
//       ),
//       body: taskListAsyncValue.when(
//         data: (tasks) {
//           return ListView.builder(
//             itemCount: tasks.length,
//             itemBuilder: (context, index) {
//               final task = tasks[index];
//               return ListTile(
//                 title: Text(task.title),
//                 subtitle: Text(task.description),
//                 trailing: IconButton(
//                   icon: Icon(task.isComplete
//                       ? Icons.check_box
//                       : Icons.check_box_outline_blank),
//                   onPressed: () {
//                     final updatedTask = Task(
//                       id: task.id,
//                       title: task.title,
//                       description: task.description,
//                       deadline: task.deadline,
//                       expectedDuration: task.expectedDuration,
//                       isComplete: !task.isComplete,
//                     );
//                     ref.read(firestoreService).updateTask(updatedTask);
//                   },
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => TaskFormScreen(task: task)),
//                   );
//                 },
//               );
//             },
//           );
//         },
//         loading: () => CircularProgressIndicator(),
//         error: (error, stack) => Center(child: Text('Something went wrong')),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => TaskFormScreen(task: null)),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

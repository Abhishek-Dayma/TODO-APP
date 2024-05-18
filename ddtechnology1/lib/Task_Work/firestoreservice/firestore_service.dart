import 'package:cloud_firestore/cloud_firestore.dart';

import '../task_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Task>> getTasks() {
    return _db.collection('tasks').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Task.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }

  Future<void> addTask(Task task) async {
    try {
      await _db.collection('tasks').add(task.toMap());
    } catch (e) {
      throw Exception('Error adding task: $e');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _db.collection('tasks').doc(task.id).update(task.toMap());
    } catch (e) {
      throw Exception('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _db.collection('tasks').doc(taskId).delete();
    } catch (e) {
      throw Exception('Error deleting task: $e');
    }
  }
}




// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../task_model.dart';

// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   Stream<List<Task>> getTasks() {
//     return _db.collection('tasks').snapshots().map((snapshot) => snapshot.docs
//         .map((doc) => Task.fromMap(doc.data() as Map<String, dynamic>, doc.id))
//         .toList());
//   }

//   Future<void> addTask(Task task) {
//     return _db.collection('tasks').add(task.toMap());
//   }

//   Future<void> updateTask(Task task) {
//     return _db.collection('tasks').doc(task.id).update(task.toMap());
//   }

//   Future<void> deleteTask(String taskId) {
//     return _db.collection('tasks').doc(taskId).delete();
//   }
// }

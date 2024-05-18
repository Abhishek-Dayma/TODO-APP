import 'package:ddtechnology1/Task_Work/firestoreservice/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../task_model.dart';

final firestoreService =
    Provider<FirestoreService>((ref) => FirestoreService());
final tasksProvider =
    StreamProvider<List<Task>>((ref) => FirestoreService().getTasks());

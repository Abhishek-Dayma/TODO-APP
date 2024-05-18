import 'package:ddtechnology1/AuthWrapper/AuthWrapper.dart';
import 'package:ddtechnology1/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tz.initializeTimeZones();
  final NotificationService notificationService = NotificationService();
  await notificationService.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
    );
  }
}

// class AuthWrapper extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(authProvider).authStateChanges;
//     return user.when(
//       data: (user) => user != null ? TaskListScreen() : LoginScreen(),
//       loading: () => CircularProgressIndicator(),
//       error: (error, stack) => Center(child: Text('Something went wrong')),
//     );
//   }
// }

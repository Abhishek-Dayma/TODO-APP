import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Login_or_Register_Screens/login_screen.dart';
import '../Task_Work/task_list_screen.dart';
//import 'authprovider.dart';

class AuthWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = FirebaseAuth.instance; // Get FirebaseAuth instance directly

    return StreamBuilder<User?>(
      stream: auth
          .authStateChanges(), // Access authStateChanges directly from FirebaseAuth instance
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        } else {
          final user = snapshot.data;
          return user != null ? TaskListScreen() : LoginScreen();
        }
      },
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

// import '../Login_or_Register_Screens/login_screen.dart';
// import '../Task_Work/task_list_screen.dart';
// import 'authprovider.dart';

// class AuthWrapper extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final auth = ref.watch(authProvider); // Get the AuthProvider instance

//     return StreamBuilder<User?>(
//       stream: auth.authStateChanges, // Access authStateChanges from the auth instance
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Something went wrong'));
//         } else {
//           final user = snapshot.data;
//           return user != null ? TaskListScreen() : LoginScreen();
//         }
//       },
//     );
//   }
// }




// import 'package:ddtechnology1/Task_Work/task_list_screen.dart';
// import 'package:ddtechnology1/providers/providers.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../Login_or_Register_Screens/login_screen.dart';
// import 'authprovider.dart';

// class AuthWrapper extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return StreamBuilder<User?>(
//       stream: ref.watch(authProvider).authStateChanges,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Something went wrong'));
//         } else {
//           final user = snapshot.data;
//           return user != null ? TaskListScreen() : LoginScreen();
//         }
//       },
//     );
//   }
// }



// import 'package:ddtechnology1/Login_or_Register_Screens/login_screen.dart';
// import 'package:ddtechnology1/Task_Work/task_list_screen.dart';
// import 'package:ddtechnology1/providers/providers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class AuthWrapper extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authProvider).authStateChanges;

//     return authState.when(
//       data: (user) => user != null ? TaskListScreen() : LoginScreen(),
//       loading: () => CircularProgressIndicator(),
//       error: (error, stack) => Center(child: Text('Something went wrong')),
//     );
//   }
// }



// import 'package:ddtechnology1/Login_or_Register_Screens/login_screen.dart';
// import 'package:ddtechnology1/Task_Work/task_list_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'providers/providers.dart';

// class AuthWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context,WidgetRef ref) {
//     return StreamBuilder<User?>(
//       stream: ref.read(authProvider).authStateChanges,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Something went wrong'));
//         } else {
//           final user = snapshot.data;
//           return user != null ? TaskListScreen() : LoginScreen();
//         }
//       },
//     );
//   }
// }

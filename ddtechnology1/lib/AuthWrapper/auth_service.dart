import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      throw Exception('Login failed');
    }
  }

  Future<User?> register(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      throw Exception('Registration failed');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}







// import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../Login_or_Register_Screens/login_screen.dart';
// import '../../Task_Work/task_list_screen.dart';

// class AuthWrapper extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final auth = FirebaseAuth.instance; // Get FirebaseAuth instance directly

//     return StreamBuilder<User?>(
//       stream: auth.authStateChanges(), // Access authStateChanges directly from FirebaseAuth instance
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
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




// // import 'package:firebase_auth/firebase_auth.dart';

// // class AuthService {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;

// //   Stream<User?> get authStateChanges => _auth.authStateChanges();

// //   Future<User?> signIn(String email, String password) async {
// //     try {
// //       UserCredential result = await _auth.signInWithEmailAndPassword(
// //           email: email, password: password);
// //       return result.user;
// //     } catch (e) {
// //       print(e);
// //       return null;
// //     }
// //   }

// //   Future<User?> register(String email, String password) async {
// //     try {
// //       UserCredential result = await _auth.createUserWithEmailAndPassword(
// //           email: email, password: password);
// //       return result.user;
// //     } catch (e) {
// //       print(e);
// //       return null;
// //     }
// //   }

// //   Future<void> signOut() async {
// //     await _auth.signOut();
// //   }
// // }

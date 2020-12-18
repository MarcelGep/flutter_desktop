import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_desktop/pages/customer_page.dart';
import 'package:flutter_desktop/pages/login_screen.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      print("Firebase User Email: " + firebaseUser.email);
      return CustomerPage();
    }
    return LoginPage();
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData && snapshot.data != null) {
//             UserHelper.saveUser(snapshot.data);
//             return StreamBuilder<DocumentSnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection("users")
//                   .doc(snapshot.data.uid)
//                   .snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<DocumentSnapshot> snapshot) {
//                 if (snapshot.hasData && snapshot.data != null) {
//                   final userDoc = snapshot.data;
//                   final user = userDoc.data();
//                   if (user['role'] == 'admin') {
//                     return AdminPage();
//                   } else {
//                     return MainPage();
//                   }
//                 } else {
//                   return Material(
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//                 }
//               },
//             );
//           }
//           return LoginPage();
//         });
//   }
// }

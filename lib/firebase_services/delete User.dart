// ignore_for_file: camel_case_types, unused_label

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../ui/loginPage.dart';
import '../ui/postScreen.dart';


class Firebase_deleteUser {
  late final FirebaseAuth auth;
  late final User? user;

  Firebase_deleteUser() {
    auth = FirebaseAuth.instance;
    user = auth.currentUser;
  }

  Future<void> deleteUser(void Function() onDeleted) async {
    try {
      await user?.delete();
      onDeleted(); // Call the callback function after the user is deleted
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}


// class Firebase_deleteUser {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   User? user = auth.currentUser;

//   Future<void> deleteUser() async {
//     try {
//       await user?.delete();
//     } catch (e) {
//       print('Error deleting user: $e');
//     }
//   }
// }


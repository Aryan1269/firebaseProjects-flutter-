// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:try2/ui/postScreen.dart';

import '../ui/loginPage.dart';

class firebase_login {
  isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
          Duration(seconds: 2),
          (() => Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostScreen()))));
    }
    else{
      Timer(
          Duration(seconds: 2),
          (() => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()))));
    }
  }

  



}

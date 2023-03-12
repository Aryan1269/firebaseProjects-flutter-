// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:try2/firebase_services/delete%20User.dart';
import 'package:try2/ui/loginPage.dart';
import 'package:try2/ui/roundButton.dart';
import 'package:try2/ui/signUp.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;

  Firebase_deleteUser accountDelete = Firebase_deleteUser();
  //for delete user
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundButton(
                title: "Log out",
                onTap: () async {
                  await auth.signOut();
                 Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()),
                  );
                }),
            SizedBox(height: 10),
            RoundButton(
                title: "  Delete  Account ",
                onTap: () {
                  accountDelete.deleteUser(() {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => SignUp()),
                    );
                  });
                }),
          ],
        ),
      ),
    );
  }
}

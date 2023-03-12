// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:try2/ui/postScreen.dart';
import 'package:try2/ui/roundButton.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Sign Up")),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //first
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                icon: Icon(Icons.email),
                hintText: 'Enter your Email',
                labelText: 'Email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Email";
                } //check if email is vaild or not
                else if (!RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
                    .hasMatch(value)) {
                  return "Enter valid Email";
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            //second
            TextFormField(
              controller: passwordController,
              obscureText: isObscure,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
              ),
              validator: (value) {
                return value!.isEmpty ? "Enter Password" : null;
              },
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RoundButton(
                title: "Sign Up",
                loading: loading,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    try {
                      await _auth.createUserWithEmailAndPassword(
                        email: emailController.text.toString(),
                        password: passwordController.text,
                      );
                      // Handle success here
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostScreen()));
                    } catch (e) {
                      // Handle error here
                      print('Error creating user: $e');
                    }
                    setState(() {
                      loading = false;
                    });
                  }
                },
              ),
            ),

            // Flexible used to fixed overflow
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Login"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



/*
Valid:

example@email.com
user.name+tag@example.co.uk
1234_5678@example.com
user@subdomain.example.com

Invalid:

user@example (missing top-level domain)
user@example. (missing top-level domain)
user@example..com (double period in domain)
user@exam_ple.com (underscore in domain)
user@exam!ple.com (exclamation mark in domain)
user@exam$ple.com (dollar sign in domain) */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:try2/firebase_services/verify_code.dart';
import 'package:try2/ui/roundButton.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({Key? key}) : super(key: key);

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  final phoneNumberController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginwithPhone'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '88880000',
                prefix: Text('+91'),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                title: "Login With Phone",
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });

                  auth.verifyPhoneNumber(
                      phoneNumber: "+91${phoneNumberController.text}",
                      verificationCompleted: (_) {},
                      verificationFailed: (e) {
                        print(e);
                      },
                      
                      codeSent: (String verificationId,
                          [int? forceResendingToken]) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyCodeScreen(
                                      verificationId: verificationId,
                                    )));
                      },
                      codeAutoRetrievalTimeout: (e) {
                        print("this retrieval error $e");
                      });
                  setState(() {
                    loading = false;
                  });
                })
          ],
        ),
      ),
    );
  }

}

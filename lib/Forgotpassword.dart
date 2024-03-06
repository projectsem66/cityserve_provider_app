import 'package:cityserve_provider_app/utils/utils.dart';
import 'package:cityserve_provider_app/widget/text/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Forgot Password"),
        centerTitle: true,
        backgroundColor: Colors.purple.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "Email"
              ),
            ),
            SizedBox(height: 60,),
            RoundButton(title: "Forgot", onTap: () {
              auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value) {
                Utils().tostmessage("we send you  email,please check email");
              }).onError((error, stackTrace) {
                Utils().tostmessage(error.toString());
              });
            },)
          ],
        ),
      ),
    );
  }
}

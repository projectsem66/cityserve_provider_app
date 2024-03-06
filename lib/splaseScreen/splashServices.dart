import 'dart:async';
import 'package:cityserve_provider_app/login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../navigation/navigationBar.dart';

String userEmail = '';
class splashServices{
  Future<void> isLogin(BuildContext context)async{

    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if(user != null){

     // userEmail = user!.email ?? '';
      Timer( const Duration(seconds: 3),
              () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationBarr())));
    }else{
      Timer( const Duration(seconds: 3),
              () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())));
    }
  }
}
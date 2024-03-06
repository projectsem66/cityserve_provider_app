import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:cityserve_provider_app/utils/colors.dart';
import 'package:cityserve_provider_app/utils/utils.dart';
import 'package:cityserve_provider_app/widget/text/big_text.dart';
import 'package:cityserve_provider_app/widget/text/round_button.dart';
import 'package:cityserve_provider_app/widget/text/small_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_Screen.dart';
import 'navigation/navigationBar.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? pickedImage;
  String _url ="";

  showAlertBox() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pick Image From"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                leading: Icon(Icons.camera_alt),
                title: Text("Camera"),
              ),
              ListTile(
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                leading: Icon(Icons.image),
                title: Text("Gallery"),
              ),
            ],
          ),
        );
      },
    );
  }
  bool spwd = true;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  final fireStore = FirebaseFirestore.instance.collection("providerDetails");

  FirebaseAuth _auth = FirebaseAuth.instance;
  String _userId ="";

  Future signup() async {
    try {
      setState(() {
        loading = true;
      });
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString(),
      );
      if(userCredential.user !=null){
        String userId = userCredential.user!.uid;
        setState(() {
          _userId = userId;
        });
        print('User ID: $userId');
        await uploadData(userCredential.user!.uid).then((value) {
          if(value !=null){

            fireStore.doc(userCredential.user!.uid).set({
              'userId': userCredential.user!.uid,
              "firstName": firstNameController.text.toString(),
              "lastName": lastNameController.text.toString(),
              "email": emailController.text.toString(),
              "phoneNumber": phoneNumberController.text.toString(),
              "image": value,
            }).then((_) {
              // Data set successfully
              print('User data added to Firestore');
            }).catchError((error) {
              // Error handling
              Utils().tostmessage(error.toString());
            });
          }
        });
      }



      Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationBarr()));
      Utils().tostmessage("Sign up successful!");
    } catch (error) {
      Utils().tostmessage("Failed to sign up: $error");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

 Future<String?> uploadData(String id) async {
    try {
      // if (_userId.isNotEmpty) {
        UploadTask uploadTask = FirebaseStorage.instance.ref("providerProfilePics").child(id.toString()).putFile(pickedImage! ,SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': pickedImage!.path},
        ));
        TaskSnapshot taskSnapshot = await uploadTask;
        String url = await taskSnapshot.ref.getDownloadURL();
        return url;
        _url=url;
        print("Urlllll: ${_url}");
        // FirebaseFirestore.instance.collection('providerDetails').doc(_userId.toString()).set({
        //   'image': url
        // }).then((value) {
        //   Utils().toString();
        // });
      // } else {
      //   Utils().tostmessage('Error: User ID is empty');
      // }
    } catch (error) {
      Utils().tostmessage(error.toString());
    }
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //  backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height:50,
                            ),
                            Center(
                              child:  GestureDetector(
                                onTap: () {
                                  showAlertBox();
                                },
                                child: Stack(
                                  children: [
                                    pickedImage != null
                                        ? Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: FileImage(pickedImage!),
                                              fit: BoxFit.cover),
                                          shape: BoxShape.circle,
                                          color: AppColors.themColor.withOpacity(0.05)),
                                    )
                                        : Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        
                                          // image: DecorationImage(
                                          //     image: AssetImage("images/addCategoryy.png"),
                                          //     fit: BoxFit.cover),
                                          shape: BoxShape.circle,
                                          color: AppColors.themColor.withOpacity(0.05)),
                                      child: Icon(Icons.person),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 65, left: 80),
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        //   color: AppColors.Colorq
                                      ),
                                      child:
                                         Icon(
                                          size: 30,
                                          Icons.camera_enhance,
                                          color: AppColors.themColor,
                                        ),
                                      ),
                              ],
                            ),
                  )
                                    ),
                            SizedBox(
                              height:20,
                            ),
                            Center(
                              child: BigText(text: "Hello Provider!",
                              color: AppColors.themColor,
                              size: 20,),
                            ),SizedBox(
                              height:5,
                            ),
                            Center(
                              child: SmallText(text: "Create Your Account For Better Experience!",
                                color: AppColors.themColor,
                                size: 16,),
                            ),
                            SizedBox(
                              height:30,
                            ),
                            Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // first name
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.themColor.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(7)),
                              child: TextFormField(
                                cursorColor: Colors.black,
                                style: TextStyle(
                                  fontSize: 18,
                                  color:AppColors.themColor,
                                ),
                                controller:firstNameController,
                                keyboardType: TextInputType.text,

                                // obscureText: true,
                                decoration:  InputDecoration(
                                  suffixIcon: Icon(Icons.person_outline,
                                  color: AppColors.themColor,),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  labelText: "First Name",
                                  labelStyle: TextStyle(
                                      color: AppColors.themColor
                                  ),
                                  contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.themColor),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),

                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Enter FirstName';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20,),
                            // last name
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.themColor.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(7)),
                              child: TextFormField(
                                cursorColor: Colors.black,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.themColor,
                                ),
                                controller: lastNameController,
                                keyboardType: TextInputType.text,
                               // obscureText: spwd,
                                //obscureText: true,
                                decoration:  InputDecoration(
                                  suffixIcon: Icon(Icons.person_outline,
                                    color: AppColors.themColor,),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  labelText: "Last Name",
                                  labelStyle: TextStyle(
                                      color: AppColors.themColor
                                  ),
                                  contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.themColor),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Enter LastName';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20,),
                      // Email
                      Container(
                      decoration: BoxDecoration(
                      color: AppColors.themColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(7)),
                    child: TextFormField(
                      controller: emailController,
                      cursorColor: Colors.black,
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.themColor,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration:  InputDecoration(
                        suffixIcon: Icon(Icons.email_outlined,
                          color: AppColors.themColor,),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color: AppColors.themColor
                        ),
                        contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.themColor),
                          borderRadius: BorderRadius.circular(5.0),

                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      validator: (value){
                        bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if(value.isEmpty){
                          return 'Enter Email';
                        }
                        else if(!emailValid){
                          return 'Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                            // phone number
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.themColor.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(7)),
                              child: TextFormField(
                                cursorColor: Colors.black,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.themColor,
                                ),
                                controller: phoneNumberController,
                                keyboardType: TextInputType.phone,
                               // obscureText: spwd,
                                 //obscureText: true,
                                decoration:  InputDecoration(
                                  suffixIcon: Icon(Icons.call_outlined,
                                    color: AppColors.themColor,),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  labelText: "Phone Number",
                                  hintStyle: TextStyle(
                                    color: AppColors.themColor.withOpacity(0.5),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                  hintText: " Example : +91 2356897410",
                                  labelStyle: TextStyle(
                                      color: AppColors.themColor
                                  ),
                                  contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.themColor),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),

                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Enter PhoneNumber';
                                  }else if(value.length != 10){
                                     return 'Mobile Number must be of 10 digit';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20,),
                  Container(
                      decoration: BoxDecoration(
                        color
: AppColors.themColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(7)),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        style: TextStyle(
                          fontSize: 18,
                          color:AppColors.themColor,
                        ),
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: spwd,
                        // obscureText: true,
                        decoration:  InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelText: "Password",
                          labelStyle: TextStyle(
                              color: AppColors.themColor
                          ),
                          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.themColor),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                spwd = !spwd;
                              }
                              );
                            },
                            child: Icon(spwd ?  Icons.visibility_off : Icons.visibility,color: AppColors.themColor,),
                          ),
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Enter Password';
                          }
                          return null;
                        },
                      ),
                    ),
                                  SizedBox(
                                    height: 40,
                                  ),
                            RoundButton(
                              title: 'SignUp',
                              loding: loading,
                              onTap: ()async {

                                if (_formKey.currentState!.validate()) {
                                   await signup(); // Wait for signup process to complete
                                 // uploadData();


                                }
                              },
                            ),


                            const SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Already have an account?',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                                      TextButton(onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                                      }, child: BigText(text: "Login Up",color: AppColors.themColor,
                                          fontWeight: FontWeight.w400),),
                                    ],
                                  )



                                ],
                              ),
                            ),
                    ],
                      )
         ),
    )
      )
      )

    );
  }
  pickImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo == null) {
        return;
      }
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (ex) {
      log(ex.toString());
      print(ex.toString());
    }
  }
}

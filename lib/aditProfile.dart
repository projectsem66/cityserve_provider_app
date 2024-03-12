import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cityserve_provider_app/utils/colors.dart';
import 'package:cityserve_provider_app/widget/text/big_text.dart';
import 'package:cityserve_provider_app/widget/text/round_button.dart';
import 'package:cityserve_provider_app/widget/text/small_text.dart';

class AditProfile extends StatefulWidget {
  const AditProfile({Key? key}) : super(key: key);

  @override
  State<AditProfile> createState() => _AditProfileState();
}

class _AditProfileState extends State<AditProfile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? profileImageUrl;
  File? pickedImage;

  @override
  void initState() {
    super.initState();
    // Call a method to fetch user data from Firestore
    fetchUserData();
  }

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

  Future<void> updateProfileImageUrl(String imageUrl) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('User not logged in');
      }
      final String providerId = currentUser.uid;
      await FirebaseFirestore.instance
          .collection('providerDetails')
          .doc(providerId)
          .update({'image': imageUrl});
      setState(() {
        profileImageUrl = imageUrl;
      });
    } catch (error) {
      print('Error updating profile image URL: $error');
    }
  }

  Future<String?> uploadImage() async {
    try {
      if (pickedImage != null) {
        String id = FirebaseAuth.instance.currentUser!.uid;
        UploadTask uploadTask = FirebaseStorage.instance.ref("providerProfilePics").child(id.toString()).putFile(pickedImage! ,SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': pickedImage!.path},
        ));
        TaskSnapshot taskSnapshot = await uploadTask;
        String url = await taskSnapshot.ref.getDownloadURL();
        return url;
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
    return null;
  }

  // Method to fetch user data from Firestore
  void fetchUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('User not logged in');
      }
      final String providerId = currentUser.uid;
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('providerDetails')
          .doc(providerId)
          .get();
      if (userData.exists) {
        setState(() {
          firstNameController.text = userData['firstName'];
          lastNameController.text = userData['lastName'];
          emailController.text = userData['email'];
          phoneController.text = userData['phoneNumber'];
          profileImageUrl = userData['image'];
        });
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }
  Future<void> updateUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('User not logged in');
      }
      final String providerId = currentUser.uid;

      // Update user data in Firestore
      await FirebaseFirestore.instance
          .collection('providerDetails')
          .doc(providerId)
          .update({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': emailController.text,
        'phoneNumber': phoneController.text,
      });

      // Upload the picked image to Firebase Storage
      if (pickedImage != null) {
        String? imageUrl = await uploadImage();
        // Update the profile image URL in Firestore
        if (imageUrl != null) {
          await updateProfileImageUrl(imageUrl);
        }
      }
    } catch (error) {
      print('Error updating user data: $error');
      throw error;
    }
  }

  Future<void> updateUserProfile() async {
    try {
      // Update user profile data in Firestore
      await updateUserData();

      // Upload the picked image to Firebase Storage
      String? imageUrl = await uploadImage();

      // Update the profile image URL in Firestore
      if (imageUrl != null) {
        await updateProfileImageUrl(imageUrl);
      }
    } catch (error) {
      print('Error updating user profile: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Center(
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showAlertBox();
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 65, left: 80),
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_enhance,
                                size: 30,
                                color: Colors.blue, // Change color as needed
                              ),
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.2), // Change color as needed
                            ),
                            child: Center(
                              child: pickedImage != null || profileImageUrl != null
                                  ? Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                image:    pickedImage != null
                                        ? FileImage(pickedImage!)
                                        : (profileImageUrl != null
                                        ? NetworkImage(profileImageUrl!)
                                        : AssetImage('assets/image/profile.png') as ImageProvider<Object>),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                                  : Icon(
                                Icons.account_circle,
                                size: 120,
                                color: Colors.grey.withOpacity(0.5), // Change color as needed
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),
                    Center(
                      child: BigText(
                        text: "Hello Provider!",
                        color: Colors.blue, // Change color as needed
                        size: 20,
                      ),
                    ),
                    SizedBox(height: 5),
                    Center(
                      child: SmallText(
                        text: "Create Your Account For Better Experience!",
                        color: Colors.blue, // Change color as needed
                        size: 16,
                      ),
                    ),
                    SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First name text field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2), // Change color as needed
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue, // Change color as needed
                            ),
                            controller: firstNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.person_outline,
                                color: Colors.blue, // Change color as needed
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: "First Name",
                              labelStyle: TextStyle(color: Colors.blue), // Change color as needed
                              contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue), // Change color as needed
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Last name text field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2), // Change color as needed
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue, // Change color as needed
                            ),
                            controller: lastNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.person_outline,
                                color: Colors.blue, // Change color as needed
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: "Last Name",
                              labelStyle: TextStyle(color: Colors.blue), // Change color as needed
                              contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue), // Change color as needed
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Email text field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2), // Change color as needed
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextFormField(
                            cursorColor: Colors.black,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue, // Change color as needed
                            ),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.blue, // Change color as needed
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: "Email",
                              labelStyle: TextStyle(color: Colors.blue), // Change color as needed
                              contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue), // Change color as needed
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // Phone number text field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2), // Change color as needed
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextFormField(
                            controller: phoneController,
                            cursorColor: Colors.black,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue, // Change color as needed
                            ),
                            // keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.call_outlined,
                                color: Colors.blue, // Change color as needed
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              labelText: "Phone Number",
                              hintStyle: TextStyle(
                                color: Colors.blue.withOpacity(0.5), // Change color as needed
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                              hintText: " Example : +91 2356897410",
                              labelStyle: TextStyle(color: Colors.blue), // Change color as needed
                              contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue), // Change color as needed
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        RoundButton(
                          title: 'SignUp',
                          // loading: loading,
                          onTap: () async {
                            // Update user data in Firestore
                            await updateUserProfile();
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ]),
            ),
          ),
        ));
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
      // Upload the picked image to Firebase Storage
      String? imageUrl = await uploadImage();
      // Update the profile image URL in Firestore
      if (imageUrl != null) {
        await updateProfileImageUrl(imageUrl);
      }
    } catch (ex) {
      log(ex.toString());
      print(ex.toString());
    }
  }
}

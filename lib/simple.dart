import 'dart:developer';
import 'dart:io';
import 'package:cityserve_provider_app/utils/colors.dart';
import 'package:cityserve_provider_app/utils/dimension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';


class simple extends StatefulWidget {
  const simple({super.key});

  @override
  State<simple> createState() => _simpleState();
}

TextEditingController _cname = TextEditingController();
String categoryName ="";
class _simpleState extends State<simple> {
  File? pickedImage;

  addcategory(String cName) async {
    if (cName == null && pickedImage == null) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Enter Required Field"),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Ok")),
            ],
          );
        },
      );
    } else {
      uploadData();
    }
  }

  uploadData() async {
    UploadTask uploadtask = FirebaseStorage.instance
        .ref("Category img")
        .child("${_cname.text}")
        .putFile(pickedImage!,SettableMetadata(
      contentType: 'image/jpeg'
    ));
    TaskSnapshot taskSnapshot = await uploadtask;
    String url = await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection("category")
        .doc(_cname.text.toString())
        .set({"cname": _cname.text.toString(), "cimage": url}).then((value) {
      log("User Uploaded");
    });
    // await _collectionReference
    //     .doc(_cname.toString())
    //     .set({"cname": _cname.text.toString(), "cimage": url}).then(
    //   (value) {
    //     print("data Added");
    //   },
    // );
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
                  Get.back();
                },
                leading: Icon(Icons.camera_alt),
                title: Text("Camera"),
              ),
              ListTile(
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Get.back();
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

  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("category");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themColor,
        leading: IconButton(
          onPressed: () {
            //Get.to(drawer());
          },
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
            size: dimensions.icon30,
          ),
        ),
        title: Text("Add Category",
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: dimensions.font20)),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 12, right: 12, top: 15),
        child: Column(
          children: [
            GestureDetector(
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
                              image: DecorationImage(
                                  image: AssetImage("images/addCategoryy.png"),
                                  fit: BoxFit.cover),
                              shape: BoxShape.circle,
                              color: AppColors.themColor.withOpacity(0.05)),
                        ),
                  Container(
                    margin: EdgeInsets.only(top: 65, left: 80),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //   color: AppColors.Colorq
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        size: 30,
                        Icons.camera_enhance,
                        color: AppColors.themColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _cname,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.themColor.withOpacity(0.05),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Salon for Men",
                  labelText: "Category Name",
                  labelStyle: TextStyle(color: Colors.black87),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.themColor),
                      borderRadius: BorderRadius.circular(15))),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                addcategory(_cname.text.toString());
                categoryName=_cname.text.toString();
                //Get.to(sub_category());
              },
              child: Container(
                height: 60,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.themColor),
                child: Center(
                  child: Text(
                    "Next",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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















// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
//
//
// class SimpleScreen extends StatefulWidget {
// @override
// _SimpleScreenState createState() => _SimpleScreenState();
// }
//
// class _SimpleScreenState extends State<SimpleScreen> {
//   File? pickedImage;
//   TextEditingController _cnameController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Upload Example'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 _pickImage();
//               },
//               child: pickedImage != null
//                   ? Container(
//                 height: 120,
//                 width: 120,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: FileImage(pickedImage!),
//                     fit: BoxFit.cover,
//                   ),
//                   shape: BoxShape.circle,
//                 ),
//               )
//                   : Container(
//                 height: 120,
//                 width: 120,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.grey,
//                 ),
//                 child: Icon(
//                   Icons.add_a_photo,
//                   size: 60,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextFormField(
//               controller: _cnameController,
//               decoration: InputDecoration(
//                 labelText: 'Category Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _uploadData();
//               },
//               child: Text('Upload'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         pickedImage = File(pickedFile.path);
//       });
//     }
//   }
//
//   Future<void> _uploadData() async {
//     if (pickedImage == null || _cnameController.text.isEmpty) {
//       // Show an alert if the required fields are not entered
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Enter Required Fields"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text("Ok"),
//               ),
//             ],
//           );
//         },
//       );
//       return;
//     }
//
//     try {
//       // Upload image to Firebase Storage
//       String imageName = _cnameController.text;
//       Reference storageReference = FirebaseStorage.instance.ref("category_images/$imageName");
//       UploadTask uploadTask = storageReference.putFile(pickedImage!);
//       TaskSnapshot taskSnapshot = await uploadTask;
//       String imageUrl = await taskSnapshot.ref.getDownloadURL();
//
//       // Save category details to Firestore
//       await FirebaseFirestore.instance.collection("categories").doc().set({
//         "cname": _cnameController.text,
//         "cimage": imageUrl,
//       });
//
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Upload Successful"),
//             content: Text("Category uploaded successfully!"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   setState(() {
//                     pickedImage = null;
//                     _cnameController.text = '';
//                   });
//                 },
//                 child: Text("Ok"),
//               ),
//             ],
//           );
//         },
//       );
//     } catch (error) {
//       print("Error uploading data: $error");
//     }
//   }
// }
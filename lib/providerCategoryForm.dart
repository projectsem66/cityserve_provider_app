import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:cityserve_provider_app/provider_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cityserve_provider_app/simple.dart';
import 'package:cityserve_provider_app/utils/colors.dart';
import 'package:cityserve_provider_app/utils/dimension.dart';
import 'package:cityserve_provider_app/utils/utils.dart';
import 'package:cityserve_provider_app/widget/text/big_text.dart';
import 'package:cityserve_provider_app/widget/text/round_button.dart';
import 'package:cityserve_provider_app/widget/text/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({super.key});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {

  File? pickedImage;
  final fireStoreAddService = FirebaseFirestore.instance.collection("providerServiceDetails");
  final fireStoreproviderDetails = FirebaseFirestore.instance.collection("providerDetails").snapshots();

  final sNmaeController = TextEditingController();
  final sDiscriptionController = TextEditingController();
  final sPriceController = TextEditingController();
  final sDurationController = TextEditingController();
  final sRatingController = TextEditingController();
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
  Future<String?> uploadData(String id) async {
    try {
      // if (_userId.isNotEmpty) {
      UploadTask uploadTask = FirebaseStorage.instance.ref("providerServicePics").child(id.toString()).putFile(pickedImage! ,SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': pickedImage!.path},
      ));
      TaskSnapshot taskSnapshot = await uploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();
      return url;

    } catch (error) {
      Utils().tostmessage(error.toString());
    }
  }


  String aa = "";
  final fireStore = FirebaseFirestore.instance.collection("category").snapshots();
  String? SelectCategory;
  String? SelectSubCategory;
  String? SelectSubCategoryPanels;
Stream<QuerySnapshot<Map<String, dynamic>>> getCategoryDocumentName(String docName){
  print("Calledddddd");
      return FirebaseFirestore.instance.collection("category").doc(docName).collection("subcategories").snapshots();
    }
  Stream<QuerySnapshot<Map<String, dynamic>>> getPanelDocumentName(String docNamee, String selectSubCategory){
    return FirebaseFirestore.instance.collection("category").doc(docNamee).collection("subcategories").doc(selectSubCategory).collection("subCategoriesPanels").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themColor,
        title: BigText(
          text: "Add Services",
          color: Colors.white,
          size: 22,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(text: "Hello Provider!",
                      color: AppColors.themColor,
                      size: 20,),
                    SmallText(text: " Add your Services!",
                      color: AppColors.themColor,
                      size: 18,),
                  ],
                ),const SizedBox(
                  height:5,
                ),

                const SizedBox(height: 20,),

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
                const SizedBox(
                  height: 10,
                ),
                Center(child: SmallText(text: "Add The Image Of Your Service",
                  fontWeight:FontWeight.w600 ,)),

          const SizedBox(
            height: 30,
          ),
          //Service name
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.themColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(7)),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: const TextStyle(
                      fontSize: 18,
                      color:AppColors.themColor,
                    ),
                    controller:sNmaeController,
                    keyboardType: TextInputType.text,

                    // obscureText: true,
                    decoration:  InputDecoration(
                      // suffixIcon: const Icon(Icons.person_outline,
                      //   color: AppColors.themColor,),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Service Name",
                      labelStyle: const TextStyle(
                          color: AppColors.themColor
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.themColor),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
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
                const SizedBox(height: 20,),
                // Category dropdown
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection("category").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    List<DropdownMenuItem<String>> categoryItems = [
                      DropdownMenuItem<String>(
                        value: null,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 180.0,left: 10),
                          child: SmallText(text: "Select Category"),
                        ),
                      ),
                    ];

                    snapshot.data!.docs.forEach((doc) {
                      categoryItems.add(DropdownMenuItem<String>(
                        value: doc.id,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: SmallText(text:doc['cname']),
                        ),
                      ));
                    });

                    return Container(
                      height: 50,
                      width: 400,
                      decoration: BoxDecoration(
                          color: AppColors.themColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: AppColors.themColor)),
                      child: DropdownButton<String>(
                        value: SelectCategory,
                        items: categoryItems,
                        underline: Container(
                          color: Colors.blue,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            SelectCategory = value;
                            SelectSubCategory = null;
                            SelectSubCategoryPanels = null;
                          });
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                // Subcategory dropdown
                if (SelectCategory != null)
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("category").doc(SelectCategory).collection("subcategories").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      List<DropdownMenuItem<String>> subcategoryItems = [
                        DropdownMenuItem<String>(
                          value: null,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0,right: 155),
                            child: SmallText(text: "Select Subcategory"),
                          ),
                        ),
                      ];

                      snapshot.data!.docs.forEach((doc) {
                        subcategoryItems.add(DropdownMenuItem<String>(
                          value: doc.id,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: SmallText(text:doc['scname']),
                          ),
                        ));
                      });

                      return Container(
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                            color: AppColors.themColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: AppColors.themColor)),
                        child: DropdownButton<String>(
                          value: SelectSubCategory,
                          items: subcategoryItems,
                          underline: Container(
                            color: Colors.blue,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              SelectSubCategory = value;
                              SelectSubCategoryPanels = null;
                            });
                          },
                        ),
                      );
                    },
                  ),
                SizedBox(height: 20),
                // Subcategory panel dropdown
                if (SelectSubCategory != null)
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection("category").doc(SelectCategory).collection("subcategories").doc(SelectSubCategory).collection("sections").snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      List<DropdownMenuItem<String>> panelItems = [
                        DropdownMenuItem<String>(
                          value: null,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 108.0,left: 10),
                            child: SmallText(text: "Select Subcategory Panel",),
                          ),
                        ),
                      ];

                      snapshot.data!.docs.forEach((doc) {
                        panelItems.add(DropdownMenuItem<String>(
                          value: doc.id,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: SmallText(text:doc['sname']),
                          ),
                        ));
                      });

                      return Container(
                        height: 50,
                        width: 400,
                        decoration: BoxDecoration(
                            color: AppColors.themColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: AppColors.themColor)),
                        child: DropdownButton<String>(
                          value: SelectSubCategoryPanels,
                          underline: Container(
                            color: Colors.blue,
                          ),
                          items: panelItems,
                          onChanged: (String? value) {
                            setState(() {
                              SelectSubCategoryPanels = value;
                            });
                          },
                        ),
                      );
                    },
                  ),

                SizedBox(height:
                dimensions.height20,),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.themColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(7)),
                  child: TextFormField(
                    maxLines: 5,
                    cursorColor: Colors.black,
                    style: const TextStyle(
                      fontSize: 18,
                      color:AppColors.themColor,
                    ),
                    controller:sDiscriptionController,
                    keyboardType: TextInputType.text,

                    // obscureText: true,
                    decoration:  InputDecoration(

                      // suffixIcon: const Icon(Icons.person_outline,
                      //   color: AppColors.themColor,),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Service DisCription",
                      labelStyle: const TextStyle(
                          color: AppColors.themColor
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.themColor),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.0),
                      ),

                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter ServiceDisCription';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                //Service Duration
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.themColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(7)),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: const TextStyle(
                      fontSize: 18,
                      color:AppColors.themColor,
                    ),
                    controller:sDurationController,
                    keyboardType: TextInputType.text,

                    // obscureText: true,
                    decoration:  InputDecoration(
                      // suffixIcon: const Icon(Icons.person_outline,
                      //   color: AppColors.themColor,),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Add Service Duration",
                      labelStyle: const TextStyle(
                          color: AppColors.themColor
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.themColor),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.0),
                      ),

                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter ServiceDuration';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: dimensions.height20,
                ),
                //Service Rating
                // Container(
                //   decoration: BoxDecoration(
                //       color: AppColors.themColor.withOpacity(0.05),
                //       borderRadius: BorderRadius.circular(7)),
                //   child: TextFormField(
                //     cursorColor: Colors.black,
                //     style: const TextStyle(
                //       fontSize: 18,
                //       color:AppColors.themColor,
                //     ),
                //     controller:sRatingController,
                //     keyboardType: TextInputType.text,
                //
                //     // obscureText: true,
                //     decoration:  InputDecoration(
                //       // suffixIcon: const Icon(Icons.person_outline,
                //       //   color: AppColors.themColor,),
                //       floatingLabelBehavior: FloatingLabelBehavior.always,
                //       labelText: " Add Service Rating",
                //       labelStyle: const TextStyle(
                //           color: AppColors.themColor
                //       ),
                //       contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: const BorderSide(color: AppColors.themColor),
                //         borderRadius: BorderRadius.circular(5.0),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: const BorderSide(color: Colors.transparent),
                //         borderRadius: BorderRadius.circular(5.0),
                //       ),
                //
                //     ),
                //     validator: (value){
                //       if(value!.isEmpty){
                //         return 'Enter ServiceRating';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: dimensions.height20,
                // ),
           //Service Price
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.themColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(7)),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: const TextStyle(
                      fontSize: 18,
                      color:AppColors.themColor,
                    ),
                    controller:sPriceController,
                    keyboardType: TextInputType.number,

                    // obscureText: true,
                    decoration:  InputDecoration(
                      // suffixIcon: const Icon(Icons.person_outline,
                      //   color: AppColors.themColor,),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: "Service Price",
                      labelStyle: const TextStyle(
                          color: AppColors.themColor
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppColors.themColor),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5.0),
                      ),

                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter ServicePrice';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: dimensions.height20,
                ),
            // Service discription


                 SizedBox(
                  height: dimensions.height40,
                ),
        RoundButton(
          title: "Add Service",
          onTap: () {
            addService();
          },
        )




    ],
            ),
          ),
        ),
      ),
    );
  }
  void addService() async {
    if (SelectCategory == '0' || SelectSubCategory == '0') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select category and subcategory')),
      );
      return;
    }

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

          final String firstName = userData['firstName']; // Corrected variable name
          final String lastName = userData['lastName'];
          final String email = userData['email'];
          final String phone = userData['phoneNumber'];
          final String profileImageUrl = userData['image'];

          final incrementDoc = await FirebaseFirestore.instance.collection("autoIncrement").doc('increment').get();
          int currentIncrement = incrementDoc.exists ? incrementDoc['value'] as int : 0;

          final docId = (currentIncrement + 1).toString();
          await uploadData(docId).then((value) async {
            if (value != null) {
              await fireStoreAddService.doc(docId).set({
                'providerId': providerId,
                'providerImage': profileImageUrl, // Use profileImageUrl from providerDetails
                'providerName': '$firstName $lastName', // Combine first and last names
                'providerEmail': email,
                'providerPhoneNumber': phone,
                'category': SelectCategory,
                'subcategory': SelectSubCategory,
                'subcategorypanel': SelectSubCategoryPanels,
                'serviceName': sNmaeController.text,
                'serviceDescription': sDiscriptionController.text,
                'servicePrice': sPriceController.text,
                'serviceDuration': sDurationController.text,
                'serviceRating': '0',
                'images': value,
              }).then((_) {
                print('User data added to Firestore');
              }).catchError((error) {
                Utils().tostmessage(error.toString());
              });
              await FirebaseFirestore.instance.collection("autoIncrement").doc('increment').set({
                'value': currentIncrement + 1,
              });
              Get.to(() => const provider_profile_page());
              // Clear form fields after adding service
              // setState(() {
              //   SelectCategory = '0';
              //   SelectSubCategory = '0';
              //   sNmaeController.clear();
              //   sDiscriptionController.clear();
              //   sPriceController.clear();
              //   sDurationController.clear();
              //   sRatingController.clear();
              //   pickedImage = null;
              // });
            }
          });
      }
    } catch (error) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add service: $error')),
      );
    }
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

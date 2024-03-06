import 'package:cityserve_provider_app/simple.dart';
import 'package:cityserve_provider_app/utils/colors.dart';
import 'package:cityserve_provider_app/widget/text/big_text.dart';
import 'package:cityserve_provider_app/widget/text/round_button.dart';
import 'package:cityserve_provider_app/widget/text/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({super.key});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {

  final fireStoreAddService = FirebaseFirestore.instance.collection("providerServiceDetails");
  




  String aa = "";
  final fireStore = FirebaseFirestore.instance.collection("category").snapshots();
  String SelectCategory = '0';
  String SelectSubCategory = '0';
Stream<QuerySnapshot<Map<String, dynamic>>> getCategoryDocumentName(String docName){
  print("Calledddddd");
      return FirebaseFirestore.instance.collection("category").doc(docName).collection("subcategories").snapshots();
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
                  child: Container(
                    height: 150,
                    width: 250,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        //borderRadius: BorderRadius.circular(20),
                        border: Border.all(
        
                            color: AppColors.themColor,
                            width: 2
                        ),
                        color: Colors.transparent
                    ),
                    child:  const Icon(Icons.photo_camera_back_outlined,color: AppColors.themColor,
                      size: 80,
                    ),
                  ),
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
                    //controller:firstNameController,
                    keyboardType: TextInputType.text,
        
                    // obscureText: true,
                    decoration:  InputDecoration(
                      suffixIcon: const Icon(Icons.person_outline,
                        color: AppColors.themColor,),
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
                StreamBuilder<QuerySnapshot>(
                  stream: fireStore,
                  builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                    List<DropdownMenuItem> providerCategory = [];
                    if(!snapshot.hasData){
                      const CircularProgressIndicator();
                    }else{
                      final categorys = snapshot.data?.docs.reversed.toList();
                      providerCategory.add(DropdownMenuItem(
                        value: '0',
                          child: Padding(
                            padding: const EdgeInsets.only(right: 165.0),
                            child: SmallText(text: "Select Category",),
                          ),
        
                      )
                      );
                      for(var category in categorys!){
                        providerCategory.add(DropdownMenuItem(
                            value: category.id,
                          child: SmallText(text: category['cname'],color: AppColors.themColor,),
                        ));
                      }
                    }
                    return Column(
                      children: [
                        Container(
                          height: 40,
                          width: 400,
                          decoration: BoxDecoration(
                              color: AppColors.themColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: AppColors.themColor)),
                          child: DropdownButton(
                            enableFeedback: true,
                             underline: Container(
                               color: Colors.blue,
                             ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),

                            items: providerCategory,
                              onChanged: (categoryValue) {
                              print("Category : $categoryValue");
                                getCategoryDocumentName(categoryValue);
                            setState(() {

                              SelectCategory = categoryValue;
                              aa = categoryValue;
                            });
                            print(categoryValue);

                              },
                            value: SelectCategory,
                          isExpanded: false,),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
          // second dropdownmenu
                if(aa.isNotEmpty)
                StreamBuilder<QuerySnapshot>(
                  stream: getCategoryDocumentName(aa),
                  builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                    List<DropdownMenuItem> providerCategory = [];
                    if(!snapshot.hasData){
                      const CircularProgressIndicator();
                    }else{
                      final subcategorys = snapshot.data?.docs.reversed.toList();
                      print("Categotrieeees : ${snapshot.data?.docs.reversed.toList()}");
                      providerCategory.add(DropdownMenuItem(
                        value: '0',
                        child: Padding(
                          padding: const EdgeInsets.only(right: 135.0),
                          child: SmallText(text: "Select SubCategory",),
                        ),

                      )
                      );
                      for(var subcategory in subcategorys!){
                        print("Category ID : ${subcategory.id}");
                        providerCategory.add(DropdownMenuItem(
                          value: subcategory['scname'],

                          child: SmallText(text: subcategory['scname'],color: AppColors.themColor,),
                        ));
                      }
                      print("Provider Category : ${providerCategory[1].value}");
                      providerCategory = providerCategory.toSet().toList();

                    }
                    if(providerCategory.isNotEmpty) {
                      return Container(
                        height: 40,
                        width: 400,
                        decoration: BoxDecoration(
                            color: AppColors.themColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: AppColors.themColor)),
                        child: DropdownButton(
                          enableFeedback: true,
                          underline: Container(
                            color: Colors.blue,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),

                          items: providerCategory,
                          onChanged: (subCategoryValue) {
                            setState(() {
                              SelectSubCategory = subCategoryValue;
                            });
                            print(subCategoryValue);
                          },
                          value: SelectSubCategory,
                          isExpanded: false,),
                      );
                    } return const SizedBox();
                  },
                ),
                const SizedBox(height: 20,),
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
                    //controller:firstNameController,
                    keyboardType: TextInputType.text,
        
                    // obscureText: true,
                    decoration:  InputDecoration(
                      suffixIcon: const Icon(Icons.person_outline,
                        color: AppColors.themColor,),
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
        
                const SizedBox(
                  height: 40,
                ),
                RoundButton(
                    title: "Add Service",
                    onTap: () {
        
                    },)
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}

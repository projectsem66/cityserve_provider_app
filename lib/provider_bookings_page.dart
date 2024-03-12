
import 'package:cityserve_provider_app/provider_chat_page.dart';
import 'package:cityserve_provider_app/serviceDescription.dart';
import 'package:cityserve_provider_app/utils/colors.dart';
import 'package:cityserve_provider_app/utils/dimension.dart';
import 'package:cityserve_provider_app/widget/text/big_text.dart';
import 'package:cityserve_provider_app/widget/text/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'BookingDetailsPage.dart';
import 'navigation/navigationBar.dart';



class provider_bookings_page extends StatefulWidget {
  const provider_bookings_page({super.key});

  @override
  State<provider_bookings_page> createState() => _provider_bookings_pageState();
}

class _provider_bookings_pageState extends State<provider_bookings_page> {

  //final FirebaseFirestore.instance.collection("bookingg").doc(SelectCategory).collection("subcategories").snapshots(),

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Get.to(()=> NavigationBarr());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: BigText(
            text: "Provider Home",
            // color: Colors.blue,
            // color:Colors.white.withOpacity(0.9),
            size: dimensions.font22,
          ),
          backgroundColor: AppColors.themColor,
          // Color(0XFF5B2DCD),
          actions: [
            IconButton(
              icon: const Icon(Icons.message_outlined),
              color: Colors.white,
              onPressed: () {
                Get.to(() => const provider_chat_page());
              },
            ),
            SizedBox(
              width: dimensions.width20,
            ),
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              color: Colors.white,
              onPressed: () {},
            ),
            SizedBox(
              width: dimensions.width15,
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.bookingContainerBackground,
                        ),
                        child: TextFormField(
                         cursorHeight: 20,
                          cursorRadius: Radius.circular(20),
                          cursorOpacityAnimates: true,
                          cursorWidth: 2,
                          decoration: InputDecoration(

                            contentPadding:  EdgeInsets.only(top: 20,),
                            prefixIcon: Icon(Icons.search_rounded,
                            color: AppColors.textColorgrey,
                            size: 20,),
                              hintText: "Search for booking",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight:FontWeight.w400
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    width: 1,
                                    color: AppColors.themColor
                                ),
                              ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  width: 1,
                                  color: Colors.transparent
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.themColor,
                        ),
                        child: Icon(Icons.tune_rounded,
                        color: Colors.white,
                        size: 30,),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: dimensions.height20,
                  ),
                  SizedBox(
                    child:
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 1,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceDescription(serviceId: '8',)));
                            },
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Container(
                                    height: dimensions.height250,
                                    // color: Colors.black54,
                                    decoration: BoxDecoration(
                                      borderRadius:  BorderRadius.circular(15),
                                      border: Border.all(color: Colors.grey.shade400)
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: dimensions.height70,
                                            width: dimensions.width75,

                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color:  AppColors.backgroundThemeColor,
                                            ),

                                          ),
                                          SizedBox(
                                            width: dimensions.width10,
                                          ),
                                          Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        // height: 30,
                                                        // width: 70,

                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(8),
                                                          color: Colors.green.shade50,
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal:
                                                              dimensions.width8,
                                                              vertical:
                                                              dimensions.height3),
                                                          child: BigText(
                                                            size: dimensions.font12,
                                                            text: "Requested",
                                                            color: Colors.green.shade600,
                                                          ),
                                                        ),
                                                      ),
                                                      BigText(text: "#236",
                                                      color: AppColors.themColor,)
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: dimensions.height5,
                                                  ),
                                                  BigText(text: "vishal kholakiya",
                                                  color: AppColors.textColorBlack,
                                                  size: 16,),
                                                  BigText(text: "₹ 2056",
                                                    color: AppColors.themColor,
                                                  size: 18,)
                                                ],
                                              ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: dimensions.height10,
                                      ),
                                      Container(
                                        height: dimensions.height125,
                                        // width: 200,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: AppColors.bookingContainerBackground,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SmallText(text: "Address",
                                                  color: AppColors.textColorgrey,

                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  SmallText(text: "kdjflk",
                                                  color: AppColors.textColorBlack,
                                                    fontWeight: FontWeight.w600,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: dimensions.height5,
                                              ),
                                              Container(
                                                height: dimensions.height1,
                                                color: Colors.grey.shade300,
                                              ),
                                              SizedBox(
                                                height: dimensions.height5,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SmallText(text: "Address",
                                                    color: AppColors.textColorgrey,

                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  SmallText(text: "kdjflk",
                                                    color: AppColors.textColorBlack,
                                                    fontWeight: FontWeight.w600,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: dimensions.height5,
                                              ),
                                              Container(
                                                height: dimensions.height1,
                                                color: Colors.grey.shade300,
                                              ),
                                              SizedBox(
                                                height: dimensions.height5,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SmallText(text: "Address",
                                                    color: AppColors.textColorgrey,

                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  SmallText(text: "kdjflk",
                                                    color: AppColors.textColorBlack,
                                                    fontWeight: FontWeight.w600,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: dimensions.height5,
                                              ),
                                              Container(
                                                height: dimensions.height1,
                                                color: Colors.grey.shade300,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:cityserve_provider_app/serviceDescription.dart';
import 'package:cityserve_provider_app/utils/colors.dart';
import 'package:cityserve_provider_app/utils/dimension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../btm_controller.dart';
import 'BookingDetailsPage.dart';

class Bookings extends StatefulWidget {
  const Bookings({super.key});

  @override
  State<Bookings> createState() => _BookingsState();
}

String bookingId = "";
BtmController _ = Get.put(BtmController());
int _currentIndex1 = 0;
List<Map<String, dynamic>> providersList = [];

Future<List<Map<String, dynamic>>> getProvidersWithUserId() async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('providerDetails')
        .where('userId', isEqualTo: "P6kTweWzOnUTxp2O2j2ieNNtsax1")
        .get();

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> providerData = doc.data() as Map<String, dynamic>;
      providersList.add(providerData);
    });
  } catch (e) {
    print('Error getting providers: $e');
  }

  return providersList;
}

class _BookingsState extends State<Bookings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProvidersWithUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex1 = 0;
                _.currentIndex = 0;
                _.update();
                print(_currentIndex1);
              });
            },
            child: Icon(Icons.arrow_back)),
        backgroundColor: AppColors.themColor,
        centerTitle: false,
        title: Text("Bookings"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Text(data["lastName"].toString()),
              Container(
                height: screenheight() - dimensions.height100*1.5,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('bookingg')
                      .snapshots(),
                  builder:
                      (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];

                          return documentSnapshot.get("userId") == "123456"
                              ? Bounce(
                                  duration: Duration(milliseconds: 200),
                                  onPressed: () {
                                    Get.to(ServiceDescription(serviceId:  documentSnapshot.get(
                                        "productServiceDetailsId")));
                                    bookingId = documentSnapshot.id;
                                    print(bookingId);
                                    //   servicename
                                    //   date
                                    //   description
                                    //   providerDetails
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: dimensions.height7),
                                    child: Container(
                                      // height: 200,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          border: Border.all(
                                              color: AppColors.themColor,
                                              width: 1)),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/dashboard/mostBook/1u.jpg")),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .red
                                                                  .withOpacity(
                                                                      0.2),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                              border: Border.all(
                                                                  color:
                                                                      AppColors
                                                                          .red)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        5,
                                                                    vertical:
                                                                        4),
                                                            child: Text(
                                                              documentSnapshot
                                                                  .get(
                                                                      "status"),
                                                              style: GoogleFonts.poppins(
                                                                  color:
                                                                      AppColors
                                                                          .red,
                                                                  fontSize:
                                                                      dimensions
                                                                          .height14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: dimensions
                                                                  .width100 +
                                                              dimensions.width27,
                                                        ),
                                                        Text(
                                                          documentSnapshot.get(
                                                              "productServiceDetailsId"),
                                                          style: GoogleFonts.poppins(
                                                              color: AppColors
                                                                  .themColor,
                                                              fontSize:
                                                                  dimensions
                                                                      .height14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Filter Replacement",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: AppColors
                                                                  .themColor,
                                                              fontSize:
                                                                  dimensions
                                                                      .height18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColors.themColor
                                                    .withOpacity(0.05),
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Service Charge",
                                                          style: GoogleFonts.poppins(
                                                              color: AppColors
                                                                  .themColor,
                                                              fontSize:
                                                                  dimensions
                                                                      .height14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          "₹500",
                                                          style: GoogleFonts.poppins(
                                                              color: AppColors
                                                                  .themColor,
                                                              fontSize:
                                                                  dimensions
                                                                      .height14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(thickness: 1),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Date & Time",
                                                          style: GoogleFonts.poppins(
                                                              color: AppColors
                                                                  .themColor,
                                                              fontSize:
                                                                  dimensions
                                                                      .height14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Text(
                                                          "${documentSnapshot.get("date") + " " + documentSnapshot.get("time")}",
                                                          style: GoogleFonts.poppins(
                                                              color: AppColors
                                                                  .themColor,
                                                              fontSize:
                                                                  dimensions
                                                                      .height14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(thickness: 1),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Provider",
                                                          style: GoogleFonts.poppins(
                                                              color: AppColors
                                                                  .themColor,
                                                              fontSize:
                                                                  dimensions
                                                                      .height14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        // Text(
                                                        //   providersList[index]
                                                        //           ["firstName"]
                                                        //       .toString(),
                                                        //   // documentSnapshot1?.get("userId"),
                                                        //   style: GoogleFonts.poppins(
                                                        //       color: AppColors
                                                        //           .themColor,
                                                        //       fontSize:
                                                        //           dimensions
                                                        //               .height14,
                                                        //       fontWeight:
                                                        //           FontWeight
                                                        //               .w500),
                                                        // ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox();
                          // documentSnapshot.get("subcategory")
                        },
                      );
                    }
                    return SizedBox(
                      height: 100,
                    );
                    // return Center(
                    //   child: Container(
                    //       width: 200,
                    //       child: Lottie.asset(
                    //           "assets/lottie/cityServeLoading.json")),
                    // );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

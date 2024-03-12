
import 'package:cityserve_provider_app/utils/dimension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors.dart';
import 'fbRefrences.dart';

class ServiceDescription extends StatefulWidget {
  String serviceId;

  ServiceDescription({super.key, required this.serviceId});

  @override
  State<ServiceDescription> createState() => _ServiceDescriptionState();
}

String bookServiceId = "";
String ServiceProviderId = "";

class _ServiceDescriptionState extends State<ServiceDescription> {
  DocumentSnapshot? documentSnapshot;
  DocumentSnapshot? documentSnapshot1;

  @override
  void initState() {
    super.initState();
    print(widget.serviceId);

    bookServiceId = widget.serviceId;
    fetchServiceData();
  }

  // for get service details
  Future<void> fetchServiceData() async {
    try {
      DocumentSnapshot snapshot = await getDocument();
      setState(() {
        documentSnapshot = snapshot;
      });
    } catch (e) {
      print('Error retrieving document: $e');
      // Handle error appropriately
    }
  }

  Future<DocumentSnapshot> getDocument() async {
    DocumentReference documentReference = refServices.doc(widget.serviceId);
    getProviderDetails();
    return documentReference.get();
  }

  // for get provider details using provider id
  Future<void> getProviderDetails() async {
    try {
      DocumentSnapshot snapshot = await getProvider();
      setState(() {
        documentSnapshot1 = snapshot;
      });
    } catch (e) {
      print('Error retrieving document: $e');
      // Handle error appropriately
    }
  }

  Future<DocumentSnapshot> getProvider() async {
    DocumentReference documentReference =
        refProvider.doc(documentSnapshot!.get("providerId"));
    ServiceProviderId = documentSnapshot!.get("providerId");

    return documentReference.get();
  }

  bool like = false;
  final CollectionReference refUser = FirebaseFirestore.instance
      .collection('userDetails')
      .doc("234")
      .collection("favourites");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: documentSnapshot != null
          ? Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: screenwidth() + dimensions.height100 * 0.75,
                        child: Stack(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: screenwidth(),
                                  width: screenwidth(),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            documentSnapshot!.get("images")),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: dimensions.height35,
                                      left: dimensions.height10,
                                      right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Bounce(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        duration: Duration(milliseconds: 200),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: AppColors.themColor.withOpacity(
                                                0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                              child: Icon(
                                            Icons.arrow_back,
                                            color: AppColors.themColor,
                                            size: dimensions.height28,
                                          )),
                                        ),
                                      ),
                                      Bounce(
                                        onPressed: () {
                                          like = !like;
                                          like == true
                                              ? refUser
                                                  .doc(widget.serviceId)
                                                  .set({
                                                  "serviceId": widget.serviceId
                                                })
                                              : refUser
                                                  .doc(widget.serviceId)
                                                  .delete();

                                          setState(() {});
                                        },
                                        duration: Duration(milliseconds: 200),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            color: AppColors.themColor.withOpacity(
                                                0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: like == true
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: AppColors.red,
                                                    size: dimensions.height26,
                                                  )
                                                : Icon(
                                                    Icons.favorite_border,
                                                    color: AppColors.red,
                                                    size: dimensions.height26,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: dimensions.height15),
                                child: Container(
                                  height: dimensions.height100 * 1.69,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        dimensions.height7),
                                    border: Border.all(color: AppColors.themColor),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          documentSnapshot!.get("category"),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              color: Colors.black54,
                                              fontSize: dimensions.height15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: dimensions.height5,
                                        ),
                                        Text(
                                          documentSnapshot!.get("serviceName"),
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              color: AppColors.themColor,
                                              fontSize: dimensions.height18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: dimensions.height4,
                                        ),
                                        Text(
                                          "₹500",
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              color: AppColors.themColor,
                                              fontSize: dimensions.height16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: dimensions.height4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Duration",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black54,
                                                  fontSize: dimensions.height16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              "50 min",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  color: AppColors.themColor,
                                                  fontSize: dimensions.height16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Ratings",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black54,
                                                  fontSize: dimensions.height16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.star_outlined,
                                              size: dimensions.height16,
                                              color: Colors.orange,
                                            ),
                                            Text(
                                              "4.5",
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  color: AppColors.themColor,
                                                  fontSize: dimensions.height16,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: dimensions.height10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: AppColors.themColor,
                                  fontSize: dimensions.height18,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              documentSnapshot!.get("serviceDescription"),
                              style: GoogleFonts.poppins(
                                  color: Colors.black54,
                                  fontSize: dimensions.height16,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: dimensions.height15,
                            ),
                            Text(
                              "About Provider",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  color: AppColors.themColor,
                                  fontSize: dimensions.height18,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: dimensions.height10,
                            ),
                            Bounce(
                              duration: Duration(milliseconds: 200),
                              onPressed: () {
                                getProviderDetails();

                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(dimensions.height7),
                                  color: AppColors.themColor.withOpacity(0.1),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: dimensions.height70,
                                            width: dimensions.height70,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.themColor),
                                          ),
                                          SizedBox(
                                            width: dimensions.height15,
                                          ),
                                          Container(
                                            width: dimensions.height100 * 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  documentSnapshot1
                                                          ?.get("firstName") ??
                                                      "hello",
                                                  // myObject?.property ?? 'Default Value'
                                                  style: GoogleFonts.poppins(
                                                      color: AppColors.themColor,
                                                      fontSize:
                                                          dimensions.height20,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: dimensions.height100 * 1,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Bounce(

                          duration: Duration(milliseconds: 200),
                          onPressed: () {  },
                          child: Container(
                            height: dimensions.height50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: AppColors.themColor,
                                border: Border.all(color: Colors.white),
                                borderRadius:
                                    BorderRadius.circular(dimensions.height7)),
                            child: Center(
                              child: Text(
                                "Accept",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: dimensions.height18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                        Bounce(
                          duration: Duration(milliseconds: 200),
                            onPressed: () {},
                          child: Container(
                            height: dimensions.height50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: AppColors.themColor,
                                border: Border.all(color: Colors.white),
                                borderRadius:
                                BorderRadius.circular(dimensions.height7)),
                            child: Center(
                              child: Text(
                                "Decline",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: dimensions.height18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          : CircularProgressIndicator(),
    );
  }
}
// Center(
// child: documentSnapshot != null
// ? Text(documentSnapshot!.get("images"))
//     : CircularProgressIndicator(), // Show a loading indicator while fetching data
// ),

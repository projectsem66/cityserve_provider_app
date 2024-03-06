
import 'package:cityserve_provider_app/login_Screen.dart';
import 'package:cityserve_provider_app/profile_subpages/About.dart';
import 'package:cityserve_provider_app/profile_subpages/AppLanguage.dart';
import 'package:cityserve_provider_app/profile_subpages/AppTheme.dart';
import 'package:cityserve_provider_app/profile_subpages/ChangePassword.dart';
import 'package:cityserve_provider_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';


class provider_profile_page extends StatefulWidget {
  const provider_profile_page({super.key});

  @override
  State<provider_profile_page> createState() => _provider_profile_pageState();
}

class _provider_profile_pageState extends State<provider_profile_page> {
  final auth = FirebaseAuth.instance;
  List<IconData> icons = [
    Icons.toggle_on,
    Icons.toggle_off,
  ];

  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Handyman App',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 320,
                  width: 400,
                  color: Colors.indigo,
                ),
                Positioned(
                  top: 40,
                  left: 150,
                  child: ClipOval(
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.white,
                      // child: Image.asset('your_image_asset_path_here.jpg'),
                    ),
                  ),
                ),
                Positioned(
                  top: 160,
                  left: 115,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'demo@handyman.com',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Stack(children: [
                  Container(
                    margin: EdgeInsets.only(top: 260, left: 27),
                    height: 120,
                    width: 340,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              Text(
                                '71',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Services',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Delivered',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 1,
                          color: Colors.blue,
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  '71',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Services',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Delivered',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ])
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                height: 70,
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Available Status',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'You are Online',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                    ToggleButtons(
                      children: icons.map((icon) => Icon(icon)).toList(),
                      isSelected: [true, false], // Example isSelected list
                      onPressed: (index) {
                        // Handle button tap
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: 15,
            ),
            // Container(
            //     height: 70,
            //     width: 360,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       color: Colors.black12,
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.only(left: 20.0),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               Row(
            //                 children: [
            //                   Text(
            //                     'Handyman Type:',
            //                   ),
            //                   Text(
            //                     'Company',
            //                     style: TextStyle(
            //                       fontSize: 17,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Row(
            //                 children: [
            //                   Text(
            //                     'My Commission:',
            //                   ),
            //                   Text(
            //                     '20%',
            //                     style: TextStyle(
            //                       fontSize: 17,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   Text(
            //                     '(Fixed)',
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //         ToggleButtons(
            //           children: icons.map((icon) => Icon(icon)).toList(),
            //           isSelected: [true, false], // Example isSelected list
            //           onPressed: (index) {
            //             // Handle button tap
            //           },
            //         ),
            //       ],
            //     )),
            // SizedBox(
            //   height: 15,
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AppLanguage(),));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.black12,
                          border: BorderDirectional(
                              bottom: BorderSide(color: Colors.black, width: 1))),
                      child: Row(
                        children: [
                          Icon(Icons.language),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "App Language",
                          ),
                        Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 30,
                          )
                        ],
                      ),
                    ),

                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AppTheme(),));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.black12,
                          border: BorderDirectional(
                              bottom: BorderSide(color: Colors.black, width: 1))),
                      child: Row(

                        children: [

                          Icon(Icons.sunny),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "App Theme",
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                     onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePassword(),));
    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.black12,
                          border: BorderDirectional(
                              bottom: BorderSide(color: Colors.black, width: 1))),
                      child: Row(
                        children: [

                          Icon(Icons.lock_outline),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Chnage Password",
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => About(),));
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.black12,
                          border: BorderDirectional(
                              bottom: BorderSide(color: Colors.black, width: 1))),
                      child: Row(
                        children: [

                          Icon(Icons.adjust_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "About",
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_right_rounded,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      // color: Colors.black12,
                        border: BorderDirectional(
                            bottom: BorderSide(color: Colors.black, width: 1))),
                    child: Row(
                      children: [
                        Icon(Icons.cloud_download_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Optional Update Notify",
                        ),
                        Spacer(),
                        ToggleButtons(
                          children: [],
                          isSelected: [],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      // color: Colors.black12,
                        border: BorderDirectional(
                            bottom: BorderSide(color: Colors.black, width: 1))),
                    child: Row(
                      children: [
                        Text(
                          "DANGER ZONE",
                          style: TextStyle(color: Colors.red),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      // color: Colors.black12,
                        border: BorderDirectional(
                            bottom: BorderSide(color: Colors.black, width: 1))),
                    child: Row(
                      children: [
                        Icon(Icons.person_remove_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Delete Account",
                        ),
                        Spacer(),
                        ToggleButtons(
                          children: [],
                          isSelected: [],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
           TextButton(onPressed: () {
              auth.signOut().then((value){
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              }).onError((error, stackTrace){
                Utils().tostmessage(error.toString());
              });
            }, child: Text("logout"),),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),

    );
  }
}

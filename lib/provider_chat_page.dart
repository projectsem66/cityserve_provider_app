
import 'package:cityserve_provider_app/provider_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class provider_chat_page extends StatefulWidget {
  const provider_chat_page({super.key});

  @override
  State<provider_chat_page> createState() => _provider_chat_pageState();
}

class _provider_chat_pageState extends State<provider_chat_page> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar: AppBar(
        title: Text(
          "Chat",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0XFF5B2DCD),
       leading:  IconButton(
         icon: Icon(Icons.arrow_back_ios,size: 20,),
         color: Colors.white,
         onPressed: () {
           Get.to(()=> const provider_home_page());
         },
       ),
      ),
      body:  ListView.builder(
        scrollDirection: Axis.vertical,
        //physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: GestureDetector(
             // onTap: () => Get.to(()=> Chat_Screen()),
              child: Container(
                height: 65,
                width: double.maxFinite,
                color: Colors.grey.shade100,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            color: Colors.yellow, shape: BoxShape.circle),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12,left: 5),
                      child: Column(
                        children: [
                          Text(
                            "vishal",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Opacity(
                            opacity: 0.5,
                            child: Text(
                              " vishal_811",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

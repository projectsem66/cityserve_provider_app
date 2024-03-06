
import 'package:cityserve_provider_app/provider_bookings_page.dart';
import 'package:cityserve_provider_app/provider_chat_page.dart';
import 'package:cityserve_provider_app/utils/colors.dart';
import 'package:cityserve_provider_app/utils/dimension.dart';
import 'package:cityserve_provider_app/widget/text/big_text.dart';
import 'package:cityserve_provider_app/widget/text/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class provider_home_page extends StatefulWidget {
  const provider_home_page({super.key});

  @override
  State<provider_home_page> createState() => _provider_home_pageState();
}

class _provider_home_pageState extends State<provider_home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: BigText(
          text: "Provider Home",

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: dimensions.height20,
                    left: dimensions.width20,
                    right: dimensions.height20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, Felix Harris",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: dimensions.font16,
                      ),
                    ),
                    SizedBox(
                      height: dimensions.height5,
                    ),
                    SmallText(
                      text: "Welcome back!",
                      color: AppColors.textColorgrey,
                    ),
                    SizedBox(
                      height: dimensions.height15,
                    ),
                    Container(
                        height: dimensions.height60,
                        // width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade100,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: dimensions.height15,
                              vertical: dimensions.width5),
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.themColor,
                                child: IconButton(
                                    onPressed: () {
                                      Get.to(() => const provider_bookings_page());
                                    },
                                    icon: const Icon(
                                      Icons.wallet,
                                      color: Colors.white,
                                    )),
                              ),
                              SizedBox(
                                width: dimensions.width20,
                              ),
                              BigText(
                                text: "Today`s Earning",
                                size: dimensions.font14,
                                color: AppColors.textColorBlack,
                              ),
                              SizedBox(
                                width: dimensions.width80,
                              ),
                              BigText(
                                text: "₹0.00",
                                color: AppColors.themColor,
                              )
                            ],
                          ),
                        )),
                    SizedBox(
                      height: dimensions.height10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: dimensions.height90,
                          width: dimensions.width170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.themColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: dimensions.height10,
                                horizontal: dimensions.width20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                      text: "171",
                                      color: Colors.white,
                                      // size: 14
                                    ),
                                    Container(
                                      height: dimensions.height35,
                                      child: Center(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.today_outlined,
                                                size: dimensions.icon20,
                                                color: AppColors.themColor,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: dimensions.height10,
                                ),
                                SmallText(
                                  text: "Total Bookinag",
                                  color: Colors.white,
                                  // size: 12,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: dimensions.height90,
                          width: dimensions.width170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.themColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: dimensions.height10,
                                horizontal: dimensions.width20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                      text: "68",
                                      color: Colors.white,
                                      // size: 14
                                    ),
                                    Container(
                                      height: dimensions.height35,
                                      child: Center(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.book_outlined,
                                                size: 20,
                                                color: AppColors.themColor,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: dimensions.height10,
                                ),
                                SmallText(
                                  text: "Total Servies",
                                  color: Colors.white,
                                  // size: 12,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: dimensions.height15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: dimensions.height90,
                          width: dimensions.width170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.themColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: dimensions.height10,
                                horizontal: dimensions.width20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                      text: "₹0.00",
                                      color: Colors.white,
                                      // size: 14
                                    ),
                                    Container(
                                      height: dimensions.height35,
                                      child: Center(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.money,
                                                size: dimensions.icon20,
                                                color: AppColors.themColor,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: dimensions.height10,
                                ),
                                SmallText(
                                  text: "Monthly Earnings",
                                  color: Colors.white,
                                  // size: 12,
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: dimensions.height90,
                          width: dimensions.width170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.themColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: dimensions.height10,
                                horizontal: dimensions.width20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(
                                      text: "₹1,000,00",
                                      color: Colors.white,
                                      // size: 14
                                    ),
                                    Container(
                                      height: 35,
                                      child: Center(
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.wallet,
                                                size: dimensions.icon20,
                                                color: AppColors.themColor,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: dimensions.height10,
                                ),
                                SmallText(
                                  text: "Wallet",
                                  color: Colors.white,
                                  // size: 12,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: dimensions.height10,
                    ),
                    BigText(
                        text: "Recent Online Provider",
                        color: AppColors.textColorBlack),
                    SizedBox(
                      height: dimensions.height10,
                    ),
                    Container(
                      height: dimensions.height40,
                      // height: double.maxFinite,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: 4,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: Container(
                              height: dimensions.height40,
                              width: dimensions.height40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.themColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: dimensions.height20,
              ),
              Container(
                // height: 400,
                width: double.maxFinite,
                color: Colors.grey.shade100,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: dimensions.width20,
                      vertical: dimensions.height10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(
                              text: "Service Provider",
                              color: AppColors.textColorBlack,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: SmallText(
                                    text: "View More",
                                    color: Colors.black54,
                                    size: dimensions.icon10)),
                          ]),
                      SmallText(
                        text: "Shoing only 4 Service Provider",
                        color: AppColors.textColorgrey,
                        // size: 14,
                      ),
                      SizedBox(
                        height: dimensions.height10,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: dimensions.width15,
                            mainAxisSpacing: dimensions.height10,
                            childAspectRatio: 0.72),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                            // height: 300,
                            // width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  const BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 0.0,
                                    blurRadius: 0,
                                    offset: Offset(0, 0),
                                  )
                                ]),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: dimensions.height120,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        color: AppColors.backgroundThemeColor,
                                      ),
                                    ),
                                    Positioned(
                                      top: dimensions.height10,
                                      left: dimensions.width125,
                                      child: Container(
                                        height: dimensions.height35,
                                        width: dimensions.width35,
                                        decoration: BoxDecoration(
                                          color: AppColors.ContainerBackground,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.dangerous_outlined,
                                            size: dimensions.icon32,
                                            color: AppColors.themColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                    child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: dimensions.width15,
                                        vertical: dimensions.height15),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.green,
                                              minRadius: dimensions.radius5,
                                            ),
                                            SizedBox(
                                              width: dimensions.width5,
                                            ),
                                            BigText(
                                              text: "Robert Benedict",
                                              color: AppColors.textColorBlack,
                                              size: 14,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: dimensions.height20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: dimensions.width10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: dimensions.height30,
                                                width: dimensions.width30,
                                                decoration: BoxDecoration(
                                                    color:
                                                    AppColors.ContainerBackground,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.call_outlined,
                                                    size: dimensions.icon18,
                                                    color: AppColors.themColor,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: dimensions.height30,
                                                width: dimensions.width30,
                                                decoration: BoxDecoration(
                                                    color:
                                                    AppColors.ContainerBackground,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.mail_outline_rounded,
                                                    size: dimensions.icon18,
                                                    color: AppColors.themColor,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: dimensions.height30,
                                                width: dimensions.width30,
                                                decoration: BoxDecoration(
                                                    color:
                                                    AppColors.ContainerBackground,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.chat_outlined,
                                                    size: dimensions.icon18,
                                                    color: AppColors.themColor,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: dimensions.height10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: dimensions.width20),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: "Upcoming Bookings",
                      color: AppColors.textColorBlack,
                    ),
                    SizedBox(
                      height: dimensions.height20,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: ListView.builder(
                        itemCount: 2,
                        //padding: EdgeInsets.all(10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: dimensions.height10),
                            child: Container(
                              // height: 130,
                              // width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade200,
                                  width: 1,
                                  style: BorderStyle.solid,
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: dimensions.height15,
                                    horizontal: dimensions.width15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: dimensions.height80,
                                          width: dimensions.width80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors.backgroundThemeColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: dimensions.width20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  // height: 30,
                                                  // width: 70,

                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Colors.red.shade50,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                dimensions
                                                                    .width8,
                                                            vertical: dimensions
                                                                .height3),
                                                    child: BigText(
                                                      size: dimensions.font14,
                                                      text: "Pending",
                                                      color:
                                                          Colors.red.shade600,
                                                    ),
                                                  ),
                                                ),
                                                BigText(
                                                  text: "#246",
                                                  color: AppColors.themColor,
                                                )
                                              ],
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                            ),
                                            SizedBox(
                                              height: dimensions.height10,
                                            ),
                                            BigText(
                                              text: "Exfoliation and Peels",
                                              color: AppColors.textColorBlack,
                                              // size: 16,
                                            ),
                                            SizedBox(
                                              height: dimensions.height10,
                                            ),
                                            Row(
                                              children: [
                                                BigText(
                                                  text: "₹31.30",
                                                  // size: 14,
                                                  color: AppColors.themColor,
                                                ),
                                                SizedBox(
                                                  width: dimensions.width5,
                                                ),
                                                SmallText(
                                                  text: "₹26.00/hr",
                                                  color:
                                                      AppColors.textColorgrey,
                                                  size: dimensions.font12,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: dimensions.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: "Job Request List",
                          color: AppColors.textColorBlack,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: SmallText(
                            text: "View More",
                            color: AppColors.textColorgrey,
                            size: dimensions.font12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: dimensions.height10,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: ListView.builder(
                        itemCount: 6,
                        //padding: EdgeInsets.all(10),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: dimensions.height10),
                            child: Container(
                              // height: 130,
                              // width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey.shade100,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(dimensions.height10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: dimensions.height60,
                                          width: dimensions.width60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:  AppColors.backgroundThemeColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: dimensions.width10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SmallText(
                                              text: "Limpiar Aire",
                                              color: AppColors.textColorBlack,
                                              // size: 14,
                                            ),
                                            BigText(
                                              text: "₹67.00",
                                              color: AppColors.textColorBlack,
                                              size: dimensions.font14,
                                            ),
                                            SmallText(
                                              text: "10/03/2023",
                                              color: AppColors.textColorgrey,
                                              size: dimensions.font12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: dimensions.height30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: dimensions.height10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: "My Servies",
                          color: AppColors.textColorBlack,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: SmallText(
                            text: "View More",
                            color: AppColors.textColorgrey,
                            size: dimensions.font12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: dimensions.height10,
                    ),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: dimensions.width15,
                          mainAxisSpacing: dimensions.height10,
                          childAspectRatio: 0.71),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          // height: 300,
                          // width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200,
                              boxShadow: [
                                const BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 0.0,
                                  blurRadius: 0,
                                  offset: Offset(0, 0),
                                )
                              ]),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: dimensions.height160,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                      color:  AppColors.backgroundThemeColor,
                                    ),
                                  ),
                                  Positioned(
                                    top: dimensions.height10,
                                    left: dimensions.width20,
                                    child: Container(
                                      // height: 20,
                                      // width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:AppColors.ContainerBackground,
                                        // shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: dimensions.width5),
                                        child: SmallText(
                                          text: "Ac Maintainas",
                                          color: AppColors.themColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: dimensions.height140,
                                    left: dimensions.width90,
                                    child: Container(
                                      // height: 20,
                                      // width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.themColor,
                                          border: Border.all(
                                              color: Colors.white,
                                              width: dimensions.width2,
                                              style: BorderStyle.solid)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: dimensions.width8,
                                            vertical: dimensions.height4),
                                        child: BigText(
                                          text: "₹50.00",
                                          size: dimensions.font14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // height: 200,
                                    decoration: BoxDecoration(),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: dimensions.width15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: dimensions.height175),
                                            child: Row(
                                              children: [
                                                Wrap(
                                                    children: List.generate(
                                                        5,
                                                        (index) => Icon(
                                                              Icons.star,
                                                              color: Colors
                                                                  .green
                                                                  .shade400,
                                                              size: dimensions
                                                                  .icon15,
                                                            ))),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: dimensions.height5,
                                          ),
                                          BigText(
                                            text: "full Servies",
                                            color: AppColors.textColorBlack,
                                            size: dimensions.font14,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: dimensions.height50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

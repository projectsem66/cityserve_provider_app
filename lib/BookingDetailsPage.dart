import 'package:cityserve_provider_app/utils/colors.dart';
import 'package:cityserve_provider_app/widget/text/big_text.dart';
import 'package:cityserve_provider_app/widget/text/round_button.dart';
import 'package:cityserve_provider_app/widget/text/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({super.key});

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: "BookingDetailsPage",
          color:AppColors.themColor ,
        size: 20,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
              Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.themColor,

                ),
                child: Center(child: SmallText(text: "Accept",color: Colors.white,
                size: 18,)),
              ),
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.themColor,

                  ),
                  child: Center(child: SmallText(text: "Decline",color: Colors.white,
                    size: 18,)),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }
}

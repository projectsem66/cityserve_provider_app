


import 'package:cityserve_provider_app/utils/dimension.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class BigText extends StatelessWidget {
  Color?  color ;
  final String text;
  double size ;
  TextOverflow overflow;
  FontWeight fontWeight;
  
  BigText({super.key,
    required this.text,
    this.color = Colors.white,
    this.size=0,
    this.overflow=TextOverflow.ellipsis,
    this.fontWeight = FontWeight.w600
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style:GoogleFonts.poppins(
        textStyle: TextStyle(
            color: color ,
            fontSize:size == 0? dimensions.font16:size,
          fontWeight: fontWeight,
        ),
      )

    );
  }
}

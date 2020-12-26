import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

class AppTextStyles {
  static TextStyle serviceBookText = GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w300,
      color: AppColors.darkGrey,
    ),
  );
  static TextStyle bigBold = GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
      color: AppColors.darkGrey,
    ),
  );
  static TextStyle regularStyle = GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w300,
      color: AppColors.darkGrey,
    ),
  );
  static TextStyle hintStyle = GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.w300,
      color: AppColors.grayWithOpacity40,
    ),
  );
  static TextStyle actionButton = GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.w300,
      color: AppColors.white,
    ),
  );
  static TextStyle blueSmall = GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w300,
      color: AppColors.blue,
    ),
  );
  static TextStyle roomCardText = GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w500,
      color: AppColors.darkGrey,
    ),
  );
  static TextStyle floorNumber = GoogleFonts.rubik(
    textStyle: TextStyle(
      fontSize: 90,
      fontWeight: FontWeight.w300,
      color: AppColors.darkGrey,
    ),
  );
}
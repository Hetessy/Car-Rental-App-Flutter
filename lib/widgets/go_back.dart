import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildGoBack(onTap, isDarkMode, context, size) {
  return Row(
    children: [
      InkWell(
        onTap: onTap,
        child: Icon(
          Icons.arrow_back,
          color: isDarkMode ? Colors.white : Colors.black,
          size: size.height * 0.03,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.015,
        ),
        child: Text(
          'Back',
          style: GoogleFonts.poppins(
            color: isDarkMode ? Colors.white : const Color(0xff1D1617),
            fontSize: size.height * 0.018,
          ),
        ),
      ),
    ],
  );
}

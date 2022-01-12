import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildTextLogo(isDarkMode, size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Sob',
        style: GoogleFonts.poppins(
          color: isDarkMode ? Colors.white : Colors.black,
          fontSize: size.height * 0.04,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        'GOG',
        style: GoogleFonts.poppins(
          color: const Color(0xff3b22a1),
          fontSize: size.height * 0.045,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

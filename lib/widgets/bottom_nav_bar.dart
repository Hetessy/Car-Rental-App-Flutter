import 'package:car_rental/pages/home_page.dart';
import 'package:car_rental/widgets/bottom_nav_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

Widget buildBottomNavBar(int currIndex, Size size, bool isDarkMode) {
  return BottomNavigationBar(
    iconSize: size.width * 0.07,
    elevation: 0,
    selectedLabelStyle: const TextStyle(fontSize: 0),
    unselectedLabelStyle: const TextStyle(fontSize: 0),
    currentIndex: currIndex,
    backgroundColor: const Color(0x00ffffff),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: isDarkMode ? Colors.indigoAccent : Colors.black,
    unselectedItemColor: const Color(0xff3b22a1),
    onTap: (value) {
      if (value != currIndex) {
        if (value == 1) {
          Get.off(const HomePage());
        }
        if (value == 3) {
          FirebaseAuth.instance.signOut();
        }
      }
    },
    items: [
      buildBottomNavItem(
        UniconsLine.bell,
        isDarkMode,
        size,
      ),
      buildBottomNavItem(
        UniconsLine.map_marker,
        isDarkMode,
        size,
      ),
      buildBottomNavItem(
        UniconsLine.user,
        isDarkMode,
        size,
      ),
      buildBottomNavItem(
        UniconsLine.arrow_left,
        isDarkMode,
        size,
      ),
    ],
  );
}

import 'package:car_rental/widgets/homePage/car.dart';
import 'package:car_rental/widgets/homePage/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget buildMostRented(Size size, bool isDarkMode) {
  CollectionReference cars = FirebaseFirestore.instance.collection('cars');
  return Column(
    children: [
      buildCategory('Most Rented', size, isDarkMode),
      Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.015,
          left: size.width * 0.03,
          right: size.width * 0.03,
        ),
        child: FutureBuilder<QuerySnapshot>(
          future: cars.get(),
          builder: (
            BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot,
          ) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data;
              return SizedBox(
                height: size.width * 0.55,
                width: data!.size * size.width * 0.5 * 1.03,
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: data.size,
                  itemBuilder: (context, i) {
                    return buildCar(
                      i,
                      size,
                      isDarkMode,
                      data,
                    );
                  },
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    ],
  );
}


import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';

class CardSwiper extends StatefulWidget {
  const CardSwiper({super.key});

  @override
  State<StatefulWidget> createState() => _CardSwiper();
}

class _CardSwiper extends State<CardSwiper> {
  ColorPackage colors = ColorPackage();

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: 3,
      onTap: (int) {
        print("hello");
      },
      scrollDirection: Axis.vertical,
      duration: 1000,
      itemBuilder: (BuildContext context,int index){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: colors.secondary_color,
          ),
          margin: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.76,
                  width: double.infinity,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}






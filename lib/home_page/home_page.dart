
import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/home_page/card_swiper.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage>{

  ColorPackage colors = ColorPackage();

  @override
  Widget build(BuildContext context) {
    return const CardSwiper();
  }
}
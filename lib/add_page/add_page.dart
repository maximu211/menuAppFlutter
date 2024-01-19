import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menuapp/add_page/form_components/image_picker/image_picker.dart';
import 'package:menuapp/add_page/form_components/input_text_field.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<StatefulWidget> createState() => _AddPage();
}

class FiledMaxLenght {
  FiledMaxLenght(this.maxLenghtName, this.maxLenghtTime, this.maxLenghtType);

  int? maxLenghtName;
  int maxLenghtTime;
  int maxLenghtType;
}

class _AddPage extends State<AddPage> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  double _value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageView Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                Container(
                  color: Colors.blue,
                  child: const Center(
                    child: Text('Page 1'),
                  ),
                ),
                Container(
                  color: Colors.green,
                  child: const Center(
                    child: Text('Page 2'),
                  ),
                ),
                Container(
                  color: Colors.orange,
                  child: const Center(
                    child: Text('Page 3'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: ColorVariables.primaryColor,
                    dotColor: Colors.grey,
                    dotWidth: 20,
                    dotHeight: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

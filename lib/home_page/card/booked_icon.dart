import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/home_page/receipt_page/receipt_page.dart';

import '../../global_variables/icon_size_variables.dart';

class ButtonToggle extends StatefulWidget {
  ButtonToggle({Key? key, required this.bookedButtonColor, required this.isDishSaved}) : super(key: key);

  final bool isDishSaved;
  final Color bookedButtonColor;

  @override
  _ButtonToggleState createState() => _ButtonToggleState();
}

class _ButtonToggleState extends State<ButtonToggle> {
  late bool isDishSaved;

  @override
  void initState() {
    super.initState();
    isDishSaved = widget.isDishSaved;
  }

  IconSizeVariables iconSizeVariables = IconSizeVariables();
  ColorPackage colors = ColorPackage();
  FontSizeVariables fontSize = FontSizeVariables();

  void _toggleButton() {
    setState(() {
      isDishSaved = !isDishSaved;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colors.primary_color,
        duration: Duration(seconds: 1),
        content: Text(isDishSaved ? 'Receipt saved! 😍' : 'Receipt deleted 😢', style: TextStyle(color: colors.background_color),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _toggleButton,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          child: isDishSaved
              ? Icon(
            Icons.bookmark,
            key: ValueKey<int>(1),
            color: widget.bookedButtonColor,
            size: iconSizeVariables.bigSize,
          )
              : Icon(
            Icons.bookmark_border,
            key: ValueKey<int>(0),
            color: widget.bookedButtonColor,
            size: iconSizeVariables.bigSize,
          ),
        ),
      ),
    );
  }
}

class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    required this.colors,
  });

  final ColorPackage colors;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(_createRoute());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.background_color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      ),
      child: Text(
        "Go to receipt!",
        style: TextStyle(color: colors.primary_color),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ReceiptPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';

class ButtonToggle extends StatefulWidget {
  ButtonToggle({
    Key? key,
    required this.bookedButtonColor,
    required this.onTap,
    required this.isDishSaved
  }) : super(key: key);

  final Color bookedButtonColor;
  final bool isDishSaved;
  final Function(bool) onTap;

  @override
  _ButtonToggleState createState() => _ButtonToggleState();
}

class _ButtonToggleState extends State<ButtonToggle> {
  late bool isDishSaved;

  final ColorPackage colors = ColorPackage();
  final FontSizeVariables fontSize = FontSizeVariables();
  final IconSizeVariables iconSize = IconSizeVariables();

  @override
  void initState() {
    super.initState();
    isDishSaved = widget.isDishSaved;
  }

  void _toggleButton() {
    bool newState = !isDishSaved;
    setState(() {
      isDishSaved = newState;
    });
    widget.onTap(newState);

      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          backgroundColor: colors.primary_color,
          duration: const Duration(seconds: 1),
          content: Text(
            newState ? 'Receipt saved! 😍' : "Receipt deleted! 😢",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _toggleButton,
        child: Icon(
          isDishSaved ? Icons.bookmark : Icons.bookmark_border,
          color: widget.bookedButtonColor,
          size: iconSize.bigSize,
          shadows: [const BoxShadow(color: Colors.black, blurRadius: 3)],
        ),
      ),
    );
  }
}

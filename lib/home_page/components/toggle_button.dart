import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:fluttericon/typicons_icons.dart';

class ToggleButton extends StatefulWidget {
  ToggleButton(
      {Key? key,
      required this.onTap,
      required this.isButtonToggled,
      required this.emptyIcon,
      required this.filledIcon,
      required this.buttonToggledText,
      required this.buttonUntoggledText})
      : super(key: key);

  final bool isButtonToggled;
  final IconData emptyIcon;
  final IconData filledIcon;
  final String buttonToggledText;
  final String buttonUntoggledText;

  final Function(bool) onTap;

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  late bool isDishSaved;

  final ColorPackage colors = ColorPackage();
  final FontSizeVariables fontSize = FontSizeVariables();
  final IconSizeVariables iconSize = IconSizeVariables();

  @override
  void initState() {
    super.initState();
    isDishSaved = widget.isButtonToggled;
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
          newState ? widget.buttonToggledText : widget.buttonUntoggledText,
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
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 150),
          crossFadeState: isDishSaved
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Icon(
            widget.filledIcon,
            color: colors.pure_white,
            size: iconSize.bigSize,
            shadows: const [BoxShadow(color: Colors.black, blurRadius: 3)],
          ),
          secondChild: Icon(
            widget.emptyIcon,
            color: colors.pure_white,
            size: iconSize.bigSize,
            shadows: const [BoxShadow(color: Colors.black, blurRadius: 3)],
          ),
        ),
      ),
    );
  }
}

class LikeButton extends ToggleButton {
  LikeButton({
    Key? key,
    required Function(bool) onTap,
    required bool isButtonToggled,
    required String buttonToggledText,
    required String buttonUntoggledText,
  }) : super(
          buttonToggledText: buttonToggledText,
          buttonUntoggledText: buttonUntoggledText,
          key: key,
          onTap: onTap,
          isButtonToggled: isButtonToggled,
          emptyIcon: Icons.favorite_border,
          filledIcon: Icons.favorite,
        );
}

class SaveButton extends ToggleButton {
  SaveButton({
    Key? key,
    required Function(bool) onTap,
    required bool isButtonToggled,
    required String buttonToggledText,
    required String buttonUntoggledText,
  }) : super(
          buttonToggledText: buttonToggledText,
          buttonUntoggledText: buttonUntoggledText,
          key: key,
          onTap: onTap,
          isButtonToggled: isButtonToggled,
          emptyIcon: Icons.bookmark_border,
          filledIcon: Icons.bookmark,
        );
}

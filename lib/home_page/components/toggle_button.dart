import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton(
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
  ToggleButtonState createState() => ToggleButtonState();
}

class ToggleButtonState extends State<ToggleButton> {
  late bool isDishSaved;
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
        backgroundColor: ColorVariables.primaryColor,
        duration: const Duration(seconds: 1),
        content: Text(
          newState ? widget.buttonToggledText : widget.buttonUntoggledText,
          style: TextStyle(color: ColorVariables.backgroundColor),
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
            color: ColorVariables.backgroundColor,
            size: IconSizeVariables.bigSize,
            shadows: const [BoxShadow(color: Colors.black, blurRadius: 3)],
          ),
          secondChild: Icon(
            widget.emptyIcon,
            color: ColorVariables.backgroundColor,
            size: IconSizeVariables.bigSize,
            shadows: const [BoxShadow(color: Colors.black, blurRadius: 3)],
          ),
        ),
      ),
    );
  }
}

class LikeButton extends ToggleButton {
  const LikeButton({
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
  const SaveButton({
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

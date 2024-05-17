import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({
    Key? key,
    required this.onTap,
    required this.isButtonToggled,
    required this.emptyIcon,
    required this.filledIcon,
    required this.buttonToggledText,
    required this.buttonUntoggledText,
    this.isIcon = true,
  }) : super(key: key);

  final bool isButtonToggled;
  final IconData emptyIcon;
  final IconData filledIcon;
  final String buttonToggledText;
  final String buttonUntoggledText;
  final bool isIcon;

  final Function(bool) onTap;

  @override
  State<StatefulWidget> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  late bool isToggled;
  @override
  void initState() {
    super.initState();
    isToggled = widget.isButtonToggled;
  }

  void _toggleButton() {
    bool newState = !isToggled;
    setState(() {
      isToggled = newState;
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
        child: widget.isIcon
            ? AnimatedCrossFade(
                duration: const Duration(milliseconds: 150),
                crossFadeState: isToggled
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: Icon(
                  widget.filledIcon,
                  color: ColorVariables.backgroundColor,
                  size: IconSizeVariables.bigSize,
                  shadows: const [
                    BoxShadow(color: Colors.black, blurRadius: 3)
                  ],
                ),
                secondChild: Icon(
                  widget.emptyIcon,
                  color: ColorVariables.backgroundColor,
                  size: IconSizeVariables.bigSize,
                  shadows: const [
                    BoxShadow(color: Colors.black, blurRadius: 3)
                  ],
                ),
              )
            : ElevatedButton(
                onPressed: _toggleButton,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isToggled
                      ? ColorVariables.primaryColor
                      : ColorVariables.backgroundColor,
                ),
                child: Text(
                  isToggled
                      ? widget.buttonToggledText
                      : widget.buttonUntoggledText,
                  style: TextStyle(
                      color: isToggled
                          ? ColorVariables.backgroundColor
                          : ColorVariables.primaryColor),
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

class ElevatedToggleButton extends ToggleButton {
  const ElevatedToggleButton({
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
          emptyIcon: Icons.check_box_outline_blank,
          filledIcon: Icons.check_box,
          isIcon: false,
        );
}

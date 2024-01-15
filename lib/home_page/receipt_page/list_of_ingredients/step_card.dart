import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/models/models.dart';

class StepCard extends StatelessWidget {
  const StepCard({
    super.key,
    required this.step,
    required this.stepIndex,
  });

  final ReceiptDescriptionElement step;
  final int stepIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: ColorVariables.primaryColor,
            boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 2)],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              step.receiptDescriptionPhoto != null
                  ? ClipPath(
                      clipper: TopRoundedCornersClipper(),
                      child: SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          step.receiptDescriptionPhoto!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 7),
              Text(
                'Step $stepIndex',
                style: TextStyle(
                  fontSize: FontSizeVariables.h2Size,
                  fontWeight: FontWeight.bold,
                  color: ColorVariables.backgroundColor,
                ),
              ),
              const SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 15, right: 15),
                child: Text(
                  step.receiptDescriptionElementText,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: FontSizeVariables.regularSize,
                    color: ColorVariables.backgroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class TopRoundedCornersClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const radius = 20.0;

    path.moveTo(0, size.height);
    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

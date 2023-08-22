import 'package:flutter/material.dart';
import 'package:test_pp_project/utils/utils.dart';

class BottomButton extends StatelessWidget {
  const BottomButton(
    this.str, [
    this.customWidth = 170,
    this.customButtonColor = AppColors.greenWhite,
    this.customTextStyle = const TextStyle(
      color: AppColors.black,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontSize: 24,
    )
  ]);
  final String str;
  final double customWidth;
  final Color customButtonColor;
  final TextStyle customTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1,
          color: AppColors.black,
        ),
        color: customButtonColor,
      ),
      width: customWidth,
      height: 45,
      child: Center(
        child: FittedBox(
          child: Text(
            str,
            style: customTextStyle,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:test_pp_project/utils/fonts.dart';

class HeadText extends StatelessWidget {
  const HeadText(this.str);
  final String str;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        //bottom: 334,
        top: 33,
        bottom: 16,
      ),
      child: Text(
        str,
        style: AppTypography.font20B,
      ),
    );
  }
}
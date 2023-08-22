import 'package:flutter/material.dart';
import 'package:test_pp_project/utils/utils.dart';


class TextUnderInputField extends StatelessWidget {
  const TextUnderInputField(this.str);
  final String str;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 1, bottom: 1),
      child: Text(
        str,
        style: AppTypography.font16S,
      ),
    );
  }
}
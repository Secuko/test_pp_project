import 'package:flutter/material.dart';
import 'package:test_pp_project/utils/utils.dart';

class AppTypography {
  const AppTypography._();

  static const String _roboslab = 'Roboslab';

  static const _color = AppColors.black;

  static const font50 = TextStyle(
    color: AppColors.white,
    fontFamily: _roboslab,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 50,
  );

  static const font26 = TextStyle(
    color: AppColors.white,
    fontFamily: _roboslab,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 26,
  );

  static const font22w = TextStyle(
    color: AppColors.white,
    fontFamily: _roboslab,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 22,
  );

  static const font20 = TextStyle(
    color: AppColors.black,
    fontFamily: _roboslab,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  static const font20B = TextStyle(
    color: AppColors.black,
    fontFamily: _roboslab,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static const font16B = TextStyle(
    color: AppColors.black,
    fontFamily: _roboslab,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  static const font16 = TextStyle(
    color: AppColors.black,
    fontFamily: _roboslab,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static const font16S = TextStyle(
    color: AppColors.black,
    fontFamily: _roboslab,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  static const font16w = TextStyle(
    color: AppColors.white,
    fontFamily: _roboslab,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static const font14B = TextStyle(
    color: AppColors.blue2,
    fontFamily: _roboslab,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w900,
    fontSize: 14,
  );

  static const font12 = TextStyle(
    color: AppColors.white,
    fontFamily: _roboslab,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 12,
  );

  static const errorfont16B = TextStyle(
    color: AppColors.errorRed,
    fontFamily: _roboslab,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w900,
    fontSize: 12,
  );

   static const font9 = TextStyle(
    color: _color,
    fontFamily: _roboslab,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
    fontSize: 26,
  );
}

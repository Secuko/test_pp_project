import 'package:flutter/material.dart';
import 'package:test_pp_project/utils/utils.dart';

class InputElem extends StatelessWidget {
  const InputElem(this.labelText, this.textController)
      : isPassword = labelText != 'E-mail';
  final bool isPassword;
  final String labelText;
  final TextEditingController textController;

  TextInputType _getKeyboardType() {
    return labelText == 'E-mail'
        ? TextInputType.emailAddress
        : TextInputType.name;
  }

  Icon _getIcon() {
    return labelText == 'E-mail'
        ? const Icon(Icons.mail)
        : const Icon(Icons.lock_outlined);
  }


  int _getLength() {
    return labelText == 'E-mail' ? 32 : 40;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      //style: AppTypography.inputFieldFont20,
      obscureText: isPassword,
      obscuringCharacter: '*',
      maxLength: _getLength(),
      textInputAction: TextInputAction.done,
      keyboardType: _getKeyboardType(),
      decoration: InputDecoration(
        counterText: '',
        prefixIcon: _getIcon(),
        prefixIconColor: MaterialStateColor.resolveWith((Set<MaterialState> states){
          if (states.contains(MaterialState.focused)) {
            return AppColors.black;
          }
          return AppColors.grey;
        }),
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        isCollapsed: true,
        hintText: labelText,
        //labelStyle: AppTypography.bla,
        floatingLabelStyle: const TextStyle(
          color: AppColors.black,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.black,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
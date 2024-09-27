import 'package:flutter/material.dart';

class DecorationUtils {
  static InputDecoration textFieldDecor({
    required String hintText,
    required String title,
    Color borderColor = Colors.black,
    double mBRadius = 11,
  }) =>
      InputDecoration(
        hintText: hintText,
          label: Text(title),
          enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(mBRadius),
        borderSide: BorderSide(
          color: borderColor
        )
      ), focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(mBRadius),
          borderSide: BorderSide(
              color: borderColor
          )
      ));

  static Widget mSpacer({
    double mWidth = 11,
    double mHeight = 11,
}) => SizedBox(
    width: mWidth,
    height: mHeight,
  );
}

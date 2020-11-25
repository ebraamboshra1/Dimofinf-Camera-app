import 'package:flutter/material.dart';

extension TextWidget on Widget {
  Widget addStyleOnly(MediaQueryData mediaQuery) {
    return Container(
      height: mediaQuery.size.height * 0.08,
      margin: EdgeInsets.symmetric(
        vertical: mediaQuery.size.height * 0.015,
        horizontal: mediaQuery.size.width * 0.05,
      ),
      padding: EdgeInsets.symmetric(
        vertical: mediaQuery.size.height * 0.01,
        horizontal: mediaQuery.size.width * 0.05,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(50)),
      child: this,
    );
  }
}

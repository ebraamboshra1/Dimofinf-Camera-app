import 'package:flutter/material.dart';

extension SocialWidget on Widget {
  Widget addSocialStyleOnly(
      MediaQueryData mediaQuery, Function f) {
    return GestureDetector(
      onTap: f,
      child: Container(
        height: mediaQuery.size.height * 0.07,
        margin: EdgeInsets.symmetric(
          vertical: mediaQuery.size.height * 0.015,
          horizontal: mediaQuery.size.width * 0.05,
        ),
        padding: EdgeInsets.symmetric(
          vertical: mediaQuery.size.height * 0.01,
          horizontal: mediaQuery.size.width * 0.05,
        ),
        decoration: BoxDecoration(
            color: Colors.white10, borderRadius: BorderRadius.circular(50)),
        child: Row(
          children: [
            Spacer(
              flex: 1,
            ),
            this,
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

const TextStyle kHeading5 = TextStyle(
  fontSize: 23,
  fontWeight: FontWeight.w400,
);
const TextStyle kHeading6 = TextStyle(
  fontSize: 19,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.15,
);
const TextStyle kSubtitle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.15,
);
const TextStyle kBodyText = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.25,
);

const kTextTheme = TextTheme(
  headlineSmall: kHeading5,
  titleLarge: kHeading6,
  titleMedium: kSubtitle,
  bodyMedium: kBodyText,
);

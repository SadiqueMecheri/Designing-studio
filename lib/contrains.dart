import 'package:flutter/material.dart';

Color primaycolor = Color(0xfffffb01);

Color backgroundColor = Colors.white;
double getNormalFontSize(BuildContext context) {
  return 13 / MediaQuery.textScaleFactorOf(context);
}

double getbigFontSize(BuildContext context) {
  return 14 / MediaQuery.textScaleFactorOf(context);
}

double getetrabigFontSize(BuildContext context) {
  return 20 / MediaQuery.textScaleFactorOf(context);
}

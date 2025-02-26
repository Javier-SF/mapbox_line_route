import 'package:flutter/material.dart';

class ColorsP {
  static Color primaryColor = const Color(0XFF0f2b2d);
  static Color secundaryColor = const Color(0XFF1d484a);
}

class LineGradinaP {
  static LinearGradient primaryGradiant = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ColorsP.primaryColor, ColorsP.secundaryColor],
  );
}

import 'package:flutter/material.dart';

class Utils {
  static double calcPI() {
    const iters = 1000000000;

    double s = 1.0;
    double den = 3.0;
    double neg = -1.0;

    for (int i = 0; i < iters; i++) {
      s += (neg * (1 / den));
      den += 2.0;
      neg *= -1.0;

      if (i / iters == 0.25 ||
          i / iters == 0.5 ||
          i / iters == 0.75 ||
          i / iters == 1) {
        debugPrint('Complete ${i / iters * 100}');
      }
    }

    double pi = 4 * s;

    return pi;
  }
}

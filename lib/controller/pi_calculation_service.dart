import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/calc_pi.dart';

class PiCalculationService extends InheritedWidget {
  const PiCalculationService({super.key, required super.child});

  static PiCalculationService? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PiCalculationService>();
  }

  @override
  bool updateShouldNotify(PiCalculationService oldWidget) {
    return true;
  }

  // Sync
  double calcSync() => Utils.calcPI();

  // compute
  Future<double> calcUsingCompute() => compute((_) => Utils.calcPI(), null);

  // Isolate
  Future<double> calcUsingIsolate() async {
    final receivePort = ReceivePort();
    final calculationIsolate =
        await Isolate.spawn(calcInIsolate, receivePort.sendPort);
    final pi = await receivePort.first;

    calculationIsolate.kill();

    return pi;
  }

  static calcInIsolate(SendPort port) {
    final pi = Utils.calcPI();
    port.send(pi);
  }

  // Future<double> calcUsingIsolate() => compute((_) => Utils.calcPI(), null);
}

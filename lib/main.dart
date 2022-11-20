import 'package:flutter/material.dart';

import 'controller/pi_calculation_service.dart';
import 'pages/basic_isolate_example_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PiCalculationService(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const BasicIsolateExamplePage(),
      ),
    );
  }
}

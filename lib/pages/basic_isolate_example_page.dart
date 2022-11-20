import 'package:flutter/material.dart';

import '../controller/pi_calculation_service.dart';
import '../widgets/processing_widget.dart';

class BasicIsolateExamplePage extends StatefulWidget {
  const BasicIsolateExamplePage({super.key});

  @override
  State<BasicIsolateExamplePage> createState() =>
      _BasicIsolateExamplePageState();
}

class _BasicIsolateExamplePageState extends State<BasicIsolateExamplePage> {
  late final PiCalculationService _calculationService;

  bool isProcessing = false;
  double? pi;

  @override
  void initState() {
    Future.microtask(
        () => _calculationService = PiCalculationService.of(context)!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isProcessing
          ? const ProcessingWidget()
          : SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(),
                  _ResultWidget(result: pi),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _onReset,
                        child: const Text('Reset'),
                      ),
                      ElevatedButton(
                        onPressed: _calcSync,
                        child: const Text('Calc(Sync)'),
                      ),
                      ElevatedButton(
                        onPressed: _calcUsingCompute,
                        child: const Text('Calc(compute)'),
                      ),
                      ElevatedButton(
                        onPressed: _calcUsingIsolate,
                        child: const Text('Calc(Isolate)'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  void _onReset() {
    setState(() {
      pi = null;
    });
  }

  void _calcSync() {
    setState(() {
      isProcessing = true;
    });

    pi = _calculationService.calcSync();

    setState(() {
      isProcessing = false;
    });
  }

  Future<void> _calcUsingCompute() async {
    setState(() {
      isProcessing = true;
    });

    pi = await _calculationService.calcUsingCompute();

    setState(() {
      isProcessing = false;
    });
  }

  Future<void> _calcUsingIsolate() async {
    setState(() {
      isProcessing = true;
    });

    pi = await _calculationService.calcUsingIsolate();

    setState(() {
      isProcessing = false;
    });
  }
}

class _ResultWidget extends StatelessWidget {
  const _ResultWidget({
    Key? key,
    required double? result,
  })  : _result = result,
        super(key: key);

  final double? _result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _result == null ? 'Click the calculate button' : 'PI == $_result',
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:alchemist/alchemist.dart';
import 'package:ds/ds.dart';
import 'package:flutter/widgets.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

class GoldenTestApp extends StatelessWidget {
  const GoldenTestApp({
    super.key,
    this.device = Device.iphone11,
    required this.builder,
  });

  final Device device;
  final ValueGetter<Widget> builder;

  @override
  Widget build(BuildContext context) {
    return DefaultAssetBundle(
      bundle: TestAssetBundle(),
      child: GoldenTestScenario(
        name: device.name,
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            size: device.size,
            padding: device.safeArea,
            platformBrightness: device.brightness,
            devicePixelRatio: device.devicePixelRatio,
            textScaleFactor: device.textScale,
          ),
          child: SizedBox(
            height: device.size.height,
            width: device.size.width,
            child: App(
              home: builder(),
              debugShowCheckedModeBanner: false,
            ),
          ),
        ),
      ),
    );
  }
}

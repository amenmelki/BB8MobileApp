import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../../data/repositories/mqtt_provider.dart';
import '../../../generated/assets.dart';

import 'package:intl/intl.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  double _currentSliderValue = .25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        forceMaterialTransparency: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Transform.scale(
              scale: 1.25,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  Assets.imagesImgBb8,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
              child: Container(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Motor Speed",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Sora",
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Icon(
                          Icons.speed_outlined,
                          color: Colors.black54,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 128,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${(_currentSliderValue * 100).round().toInt()}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 72,
                            letterSpacing: 32,
                            fontWeight: FontWeight.w500,
                            fontFamily: "RobotoMono",
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const Text(
                          "%",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Sora",
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 128,
                  ),
                  SfSliderTheme(
                    data: const SfSliderThemeData(
                        tooltipBackgroundColor: Colors.deepOrangeAccent,
                        activeTrackHeight: 8,
                        inactiveTrackHeight: 6),
                    child: SfSlider(
                      min: 0,
                      max: 1,
                      value: _currentSliderValue,
                      interval: 0.25,
                      activeColor: Colors.deepOrange,
                      inactiveColor: Colors.deepOrange.withOpacity(0.25),
                      showDividers: true,
                      showTicks: true,
                      showLabels: true,
                      numberFormat: NumberFormat("#%"),
                      enableTooltip: true,
                      tooltipShape: const SfPaddleTooltipShape(),
                      thumbIcon: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepOrangeAccent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                        ),
                      ),
                      onChanged: (dynamic newValue) {
                        setState(() {
                          _currentSliderValue = newValue;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 128,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 56,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    MqttStatefulWidgetState.publishMessage(
                      'bb8/vitesse',
                      (_currentSliderValue * 100 * 4095 / 100).toStringAsFixed(2),
                    );
                    if (kDebugMode) {
                      print((_currentSliderValue * 100 * 4095 / 100).toStringAsFixed(2));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black38,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontFamily: "Sora",
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

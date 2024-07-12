import 'package:bb8/ui/views/welcome_view/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/repositories/mqtt_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MqttService(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WelcomeView(),
      ),
    );
  }
}

import 'dart:ui';

import 'package:bb8/ui/views/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../generated/assets.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 64),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const Text(
                    "Welcome !",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Sora",
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  Transform.scale(
                    scale: 1.25,
                    child: Image.asset(
                      Assets.imagesImgBb8,
                    ),
                  ),
                  const SizedBox(
                    height: 128,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeView()
                            )
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white38,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontFamily: "Sora",
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}

import 'dart:ui';

import 'package:bb8/ui/views/Settings_view/setting_view.dart';
import 'package:bb8/ui/views/live_view/live_view.dart';
import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 32,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
      ),
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
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const LiveView())),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white38,
                      foregroundColor: Colors.white,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.live_tv_rounded,
                          color: Colors.black54,
                          size: 32,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Live",
                          style: TextStyle(
                            fontFamily: "Sora",
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const SettingView())),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white38,
                      foregroundColor: Colors.white,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.black54,
                          size: 32,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Settings",
                          style: TextStyle(
                            fontFamily: "Sora",
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import '../../../data/repositories/mqtt_provider.dart'; // Import your MQTT provider

class LiveView extends StatefulWidget {
  const LiveView({super.key});

  @override
  State<LiveView> createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8',
      ),
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  void walk(double degrees, double distance) {
    // Normalize values to range from -1 to 1
    double normalizedX = distance;
    double normalizedY = -degrees; // Invert Y to match your requirements

    // Publish the walk command
    MqttStatefulWidgetState.publishMessage(
      'bb8/body/walk',
      'degrees: $normalizedY, distance: $normalizedX',
    );

    print("Walk: degrees = $normalizedY, distance = $normalizedX");
  }

  void turn(double degrees, double distance) {
    // Normalize values to range from -1 to 1
    double normalizedX = distance;
    double normalizedY = -degrees; // Invert Y to match your requirements

    // Publish the turn command
    MqttStatefulWidgetState.publishMessage(
      'bb8/head/turn',
      'degrees: $normalizedY, distance: $normalizedX',
    );

    print("Turn: degrees = $normalizedY, distance = $normalizedX");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: VideoPlayer(_controller),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            left: 50,
            bottom: 50,
            child: Column(
              children: [
                const Text(
                  "Body Control",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Joystick(
                  listener: (details) {
                    walk(details.y, details.x);
                  },
                  mode: JoystickMode.all,
                ),
              ],
            ),
          ),
          Positioned(
            right: 50,
            bottom: 50,
            child: Column(
              children: [
                const Text(
                  "Head Control",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                Joystick(
                  listener: (details) {
                    turn(details.y, details.x);
                  },
                  mode: JoystickMode.all,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}

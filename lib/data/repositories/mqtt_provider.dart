import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:provider/provider.dart';

class MqttService extends StatelessWidget {
  final Widget child;

  const MqttService({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MqttStatefulWidget(child: child);
  }
}

class MqttStatefulWidget extends StatefulWidget {
  final Widget child;

  const MqttStatefulWidget({Key? key, required this.child}) : super(key: key);

  @override
  MqttStatefulWidgetState createState() => MqttStatefulWidgetState();
}

class MqttStatefulWidgetState extends State<MqttStatefulWidget> {
  final String broker = ' 127.0.0.1';
  final String clientId = 'mqtt-explorer-89af1de7';
  static late MqttServerClient client;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    connect();
  }

  Future<void> connect() async {
    client = MqttServerClient(broker, clientId);
    client.logging(on: true);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .keepAliveFor(60)
        .startClean()
        .withWillQos(MqttQos.atMostOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect();
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      disconnect();
    }
  }

  void disconnect() {
    client.disconnect();
    if (kDebugMode) {
      print('Disconnected');
    }
    setState(() {
      isConnected = false;
    });
  }

  void onConnected() {
    if (kDebugMode) {
      print('Connected');
    }
    setState(() {
      isConnected = true;
    });
  }

  void onDisconnected() {
    if (kDebugMode) {
      print('Disconnected');
    }
    setState(() {
      isConnected = false;
    });
  }

  static void publishMessage(String topic, String message) {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    } else {
      if (kDebugMode) {
        print('Cannot publish message. Client is not connected.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: this,
      child: widget.child,
    );
  }
}

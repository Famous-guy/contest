import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebSocketExample(),
    );
  }
}

class WebSocketExample extends StatefulWidget {
  @override
  _WebSocketExampleState createState() => _WebSocketExampleState();
}

class _WebSocketExampleState extends State<WebSocketExample> {
  late IOWebSocketChannel channel;
  String? cValue;

  @override
  void initState() {
    super.initState();
    connectToWebSocket();
  }

  void connectToWebSocket() {
    // Establish WebSocket connection
    channel = IOWebSocketChannel.connect(
      'ws://jfxrates.com/websocket/tickers/',
      headers: {'pair': 'pay_usdt'},
    );

    // Listen for messages from the WebSocket server
    channel.stream.listen(
      (message) {
        print('Received message: $message');
        // Parse the JSON message
        Map<String, dynamic> data = json.decode(message);
        // Access the value of "c"
        setState(() {
          cValue = data['data']['data']['c'];
        });
      },
      onError: (error) {
        print('Error occurred: $error');
        // Handle errors here
      },
      onDone: () {
        print('WebSocket connection closed');
        // Handle WebSocket connection closed
      },
    );
  }

  @override
  void dispose() {
    // Close WebSocket connection when the widget is disposed
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('WebSocket connection established.'),
            SizedBox(height: 20),
            Text(
              'Pay current price: ${cValue ?? "Waiting for data..."}',
              style: TextStyle(fontSize: 18),
            ),
            Text('Equivalent in USDT'),
            Text('\$Pay 500 * $cValue = ${500 * double.parse(cValue!)}'),
          ],
        ),
      ),
    );
  }
}

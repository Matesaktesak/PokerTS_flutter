import 'package:flutter/material.dart';
import 'dart:io' show WebSocket;
import 'dart:convert' show json;

class SocketTest extends StatefulWidget{
  String output = "";
  late WebSocket ws;

  SocketTest({Key? key}) : super(key: key);

  @override
  State<SocketTest> createState() => _SocketTestState();
}

class _SocketTestState extends State<SocketTest> {
  TextEditingController controller = TextEditingController();

  _SocketTestState(){
    setupWS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: TextField(controller: controller,)),
          Text(widget.output),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        widget.ws.add(json.encode({
          "gameId": "ahoj",
          "action": "bet",
          "args":{
              "ammount": 50
          }
        }));
      }, child: const Icon(Icons.send),
      ),
    );
  }

  void setupWS() {
    WebSocket.connect("ws://localhost:8080/protocol").then((WebSocket ws) {
      if (ws.readyState == WebSocket.open) {
        // As soon as websocket is connected and ready for use, we can start talking to other end

        ws.add(json.encode({
          "gameId": "ahoj",
          "action": "join",
          "args": {
            "name": "SocketTester"
            }
          }
        )); // this is the JSON data format to be transmitted

        ws.listen(
          (data) {
            // gives a StreamSubscription
            print('${Map<String, String>.from(json.decode(data))}'); // listen for incoming data and show when it arrives
            setState(() {
              widget.output = '${Map<String, String>.from(json.decode(data))}';
              widget.ws = ws;
            });

            /* if (ws.readyState == WebSocket.open) {  // The connectioén must sill be open to be able to write to it
            ws.add(json.encode({
              'data': 'from client at ${DateTime.now().toString()}',
            }));
          } */
          },
          onDone: () => print('WS Done :)'),
          onError: (err) => print('Error -- ${err.toString()}'),
          cancelOnError: true,
        );
      } else {
        print('Connection Denied');
      }
      // in case, if serer is not running now
    }, onError: (err) => print('Error -- ${err.toString()}'));
  }

}


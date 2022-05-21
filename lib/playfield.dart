import 'package:flutter/material.dart';
import 'package:pokerts_app/playcard.dart';
import 'package:pokerts_app/colors.dart';
import 'dart:io' show WebSocket;
import 'dart:convert' show json;


class PlayField extends StatefulWidget{
  List<PlayCard> cards = [];
  List<PlayCard> community = [];
    /* PlayCard(10, "Clubs"),
    PlayCard(5, "Hearts"),
    PlayCard(12, "Spades"),
    PlayCard(1, "Diamonds"),
    PlayCard(9, "Hearts"),
  ]; */

  String gameId = "ahoj";
  late WebSocket ws;
  String output = "";

  PlayField(this.gameId, {Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _PlayFieldState();

}

class _PlayFieldState extends State<PlayField>{
  final betFieldController = TextEditingController();

  _PlayFieldState(){
    setupWS();
  }

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context){
    return Material(
      child: Container(
        color: pokerSurfaceGreen,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AspectRatio(
                aspectRatio: 3*5/4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.community,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: AspectRatio(
                aspectRatio: 3 * 5 / 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.cards,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(child: TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: "Bet ammount",
                        suffixText: "\$",
                      ),
                      controller: betFieldController,
                    )),
                    SizedBox(width: 12,),
                    ElevatedButton(
                      onPressed: (() {
                        debugPrint("User bet: ${betFieldController.text}");
                        betFieldController.text = "";
                      }),
                      child: const Text("Bet")
                    ),
                  ],),
              ),
            ),
            Center(child: Text(widget.output)),
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    betFieldController.dispose();
    super.dispose();
  }

  void setupWS() {
    WebSocket.connect("ws://localhost:8080/protocol").then((WebSocket ws) {
      if (ws.readyState == WebSocket.open) {
        // As soon as websocket is connected and ready for use, we can start talking to other end

        ws.add(json.encode({
          "gameId": "ahoj",
          "action": "join",
          "args": {"name": "SocketTester"}
        })); // this is the JSON data format to be transmitted

        ws.listen(
          (data) {
            Map<String, dynamic> message = json.decode(data);
            // gives a StreamSubscription
            print('$message'); // listen for incoming data and show when it arrives
            
            if(message["action"] == "update"){
              if(message["cards"] != null){
                print("Cards: ${message["cards"]}");

                List<dynamic> cards = message["cards"];
                widget.cards.clear();
                cards.forEach((c) { 
                  setState(() {
                    widget.cards.add(PlayCard(c["value"], c["suit"]));
                  });
                });
              }

              if (message["community"] != null) {
                print("Cards: ${message["community"]}");

                List<dynamic> cards = message["community"];
                widget.community.clear();
                cards.forEach((c) {
                  setState(() {
                    widget.community.add(PlayCard(c["value"], c["suit"]));
                  });
                });
              }
            }

            setState(() {
              widget.output = '${Map<String, dynamic>.from(json.decode(data))}';
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
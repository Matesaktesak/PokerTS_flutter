import 'package:flutter/material.dart';
//import './playcard.dart';

class PlayField extends StatefulWidget{
  //List<PlayCard> cards = [];
  //List<PlayCard> community = [];
  String gameId = "";

  PlayField(this.gameId, {Key? key}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => _PlayFieldState();

}

class _PlayFieldState extends State<PlayField>{
  @override
  Widget build(BuildContext context){
    return Material(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Playfield"),
           /*  Row(children: widget.community),
            Expanded(
              child: Row(
                children: widget.cards,
              ),
            ),
            Row(children: const [
              TextField(),
              ElevatedButton(onPressed: null, child: Text("Bet")),
            ],), */
          ],
        ),
      ),
    );
  }

}
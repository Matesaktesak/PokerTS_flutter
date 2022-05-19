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
  final betFieldController = TextEditingController();

  @override
  void initState(){
    super.initState();

  } 

  @override
  Widget build(BuildContext context){
    return Material(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          verticalDirection: VerticalDirection.down,
          children: [
            const Expanded(child: Text("Playfield")
            ),
            SizedBox(
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
}
import 'package:flutter/material.dart';
import 'dart:math' as math;

class PlayCard  extends StatelessWidget{
  late int value;
  late String suit;
  late String shortname;
  late String valName;

  PlayCard(this.value, this.suit, {Key? key}) : super(key: key){
    valName = getNameByValue();
    shortname = valName.substring(0, valName == "10" ? 2 : 1);
  }

  @override
  Widget build(BuildContext context) {
    Column text = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          shortname,
          style: Theme.of(context).primaryTextTheme.displaySmall?.copyWith(color: Color(0xFF000000)),
          
        ),
        SizedBox(height: 5,),
        Image(fit: BoxFit.contain, image: AssetImage("assets/$suit.png")),
      ]
    );

    return AspectRatio(
      aspectRatio: 3/4,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: text,
                ),
              ),
              Flexible(
                flex: 3,
                child: Container(),
              ),
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Transform.rotate(angle: math.pi, child: text),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }


  String getNameByValue() {
    // Resolve the integer card value to a non-žulíky-player human readable format /*(as a static method for general use) - legacy*/
    String out = "";
    int val = value;

    if (val >= 2 && val <= 10) out = val.toString();
    if (val == 1 || val == 14) out = "Ace";
    if (val == 11) out = "Jack";
    if (val == 12) out = "Queen";
    if (val == 13) out = "King";

    return out;
  }
}
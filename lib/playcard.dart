import 'package:flutter/material.dart';

class PlayCard  extends StatelessWidget{
  final int value;
  final String suit;

  const PlayCard(this.value, this.suit, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Text(value.toString()),
      ),
    );
  }

}
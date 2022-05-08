import 'package:flutter/material.dart';
import 'dart:io';

void main() => runApp(PokerApp());

class PokerApp extends StatelessWidget{
  var socket = await WebSocket.connect("ws://localhost:8080/protocol");

  Widget build(BuildContext context){
    return MaterialApp(
      title: "Poker Frontend v1",
      home: Scaffold(
        appBar: AppBar(title: const Text("PokerApp v1")),
        body: const Center(
          child: const Text("Test2"),
        ),
      ),
    );
  }
}
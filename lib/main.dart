import 'package:flutter/material.dart';
import 'package:pokerts_app/colors.dart';
//import './playfield.dart';
//import './login.dart';

//String gameId = "ahoj";

final ThemeData _theme = _buildTheme();

ThemeData _buildTheme(){
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: pokerPrimary,
      secondary: pokerSecondary,
      error: pokerHighlight,
    )
  );
}
void main(){
  runApp(MaterialApp(
    title: "PokerApp v1",
    //initialRoute: "/login",
    home: Text("Test"),// LoginPage(),
    /* routes: {
      "/login": (context) => const LoginPage(),
      "/playfield": (context) => PlayField(gameId),
    }, */
    theme: _theme,
  ));
}


/* Future<WebSocket> setupConnection() async{
  WebSocket ws = await WebSocket.connect("ws://localhost:8080/protocol");
  ws.add('{"action":"join", "gameId":"$gameId", "name":"$name"}');
  return ws;
} */
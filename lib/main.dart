import 'package:flutter/material.dart';
import 'package:pokerts_app/colors.dart';
import 'package:pokerts_app/playfield.dart';
import 'package:pokerts_app/login.dart';
import 'package:pokerts_app/socket_test.dart';

const String gameId = "ahoj";

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
    initialRoute: "/login",
    //home: LoginPage(),
    routes: {
      "/login": (context) => LoginPage(),
      "/playfield": (context) => PlayField(gameId),
      "/sockettest": (context) => SocketTest(),
    }, 
    theme: _theme,
  ));
}
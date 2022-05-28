import 'package:flutter/material.dart';
import 'package:pokerts_app/colors.dart';
import 'package:pokerts_app/main_menu.dart';
import 'package:pokerts_app/playfield.dart';
import 'package:pokerts_app/login.dart';
import 'package:pokerts_app/socket_test.dart';

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

String gameServerUrl = "localhost:8080";

void main(){
  runApp(MaterialApp(
    title: "PokerApp v1",
    initialRoute: "/login",
    //home: LoginPage(),
    routes: {
      "/login": (context) => const LoginPage(),
      "/main":(context) => MainMenu(),
      "/playfield": (context) => PlayField("ahoj"),
      "/sockettest": (context) => SocketTest(),
    }, 
    theme: _theme,
  ));
}
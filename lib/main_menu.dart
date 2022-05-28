import 'package:flutter/material.dart';
import 'package:pokerts_app/colors.dart';
import 'package:pokerts_app/main.dart';
import 'package:pokerts_app/playfield.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class MainMenu extends StatefulWidget{
  MainMenu({Key? key}) : super(key: key);

  late List<GameItem> publicGames = List<GameItem>.empty(growable: true);

  @override
  State<MainMenu> createState() => _MainMenuState();

  Future<List<GameItem>> queryPublicGames(BuildContext context) async {
    print("Sending request for public games");

    List<GameItem> gamesLoaded = List<GameItem>.empty(growable: true);
    
    try{
      final response = await http.get(Uri.parse("http://$gameServerUrl/listgames"));

      if(response.statusCode == 200){
          jsonDecode(response.body).forEach((o) {
          //print(o);
          gamesLoaded.add(GameItem(o["gameId"], o["currentPlayers"], o["maxPlayers"]));
        });
      } else {
        throw Exception("Faild to get a server response... Code: " + response.statusCode.toString());
      }

      return gamesLoaded;
    }catch(err){
      showDialog(context: context, builder: (_) => AlertDialog(
        title: const Text("Error"),
        content: const Text("Failed to load active games from the server..."),
        actions: [
          TextButton(onPressed: (){Navigator.of(context).pop();}, child: const Text("Dismiss")),
        ],
      ), barrierDismissible: 
      true);
      return List<GameItem>.empty(growable: true);
    }
  }

  static void joinGame(BuildContext context, String gameId){
    //print("Trying to join game with id: " + gameId);

    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PlayField(gameId)));

    // TODO: Add a back or escape game button
  }
}

class _MainMenuState extends State<MainMenu> {
  final TextEditingController _gameIdController = TextEditingController();
  
  @override
  void initState(){
    super.initState();
    widget.queryPublicGames(context).then((value) => {
        setState(() => {
          widget.publicGames = value
        })
    });
  }
    

  @override
  Widget build(BuildContext context){
    return Scaffold(
      //backgroundColor: surfaceWhite,
      appBar: AppBar(
        title: const Text("Active Games"),
        //backgroundColor: primary,
        actions: [
          IconButton(onPressed: () => {

          }, icon: const Icon(Icons.add)),
          IconButton(onPressed: () => {
            widget.queryPublicGames(context).then((value) => {
              setState(() => {
                widget.publicGames = value
              })
            })
          }, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: () => {

          }, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text("Available Games:"),
                Flexible(
                  flex: 1,
                  child: widget.publicGames.isEmpty ? const CircularProgressIndicator() : ListView(
                    scrollDirection: Axis.vertical,
                    children: widget.publicGames,
                    padding: const EdgeInsets.only(right: 15),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _gameIdController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          labelText: "Game Code"
                        ),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    ElevatedButton(
                      onPressed: (){
                        MainMenu.joinGame(context, _gameIdController.text);
                      },
                      child: const Text("Join Game")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GameItem extends StatelessWidget{
  final String gameId;
  final int maxPlayers;
  final int currentPlayers;

  const GameItem(this.gameId, this.currentPlayers, this.maxPlayers, {Key? key}) : super(key: key);

  factory GameItem.fromJSON(Map<String, dynamic> json){
    return GameItem(json["gameId"], json["currentPlayers"], json["maxPlayers"]);
  }

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: pokerSecondary, width: 3),
        borderRadius: const BorderRadiusDirectional.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(5),
      child: TextButton(
        onPressed: (){MainMenu.joinGame(context, gameId);},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(gameId),
            Text(currentPlayers.toString() + "/" + maxPlayers.toString()),
          ]
        ),
      ),
    );
  }
}
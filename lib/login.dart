import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  LoginPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      //backgroundColor: surfaceWhite,
      appBar: AppBar(
        title: const Text("Login"),
        //backgroundColor: primary,
        actions: [IconButton(onPressed: () => {

        }, icon: const Icon(Icons.info))],
      ),
      body: Center(
        child: Container(
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Poker!"),
              const TextField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Email"
                ),
              ),
              const SizedBox(height: 15,),
              //Text("Password:"),
              const TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
              ),
              const SizedBox(height: 15,),
              ElevatedButton(
                onPressed: (){
                  loginPressed(context);
                },
                child: Text("Login")),
              const SizedBox(
                height: 150,
              ),
              TextButton(
                onPressed: registerPressed,
                child: Text("Don't have an account? Register",
                  textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void Function()? registerPressed(){

  }

  void loginPressed(BuildContext context){
    Navigator.pushReplacementNamed(context, "/main");
  }
}
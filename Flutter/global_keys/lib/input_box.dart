import 'package:flutter/material.dart';
import 'package:global_keys/main.dart';

class InputBox extends StatefulWidget {
  const InputBox({Key key}) : super(key: key);

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {

  bool loggedin=false;
  String _email;
  String _username;
  String _password;

  final formKey=GlobalKey<FormState>();
  final mainKey=GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainKey,
      appBar: AppBar(
        title: Text("Form Example"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child:loggedin==false ?Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Email"
                ),
                validator:(str)=>
                !str.contains('@')? "Not a Valid Email! ":null,
                onSaved:(str)=>_email=str,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Username"
                ),
                validator: (str)=>str.length<=5? "Not a Valid Username!": null,
                onSaved: (str)=>_username=str,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                validator: (str)=>
                    str.length<=7 ? "Not a Valid Password!" : null,
                onSaved: (str)=>_password=str,
                obscureText: true,
              ),
              ElevatedButton(
                  onPressed: onPressed,
                  child: Text("Submit")),

            ],
          ),
        ) :Center(
          child: Column(
            children: [
              Text("Welcome $_username"),
              ElevatedButton(
                  onPressed: (){
                    setState(() {
                      loggedin=false;
                    });
                  },
                  child: Text("Log out")),
            ],
          ),
        ),
      ),
    );
  }


  void onPressed(){
    var form=formKey.currentState;

    if(form.validate()){
      form.save();
      setState(() {
        loggedin=true;
      });

      var snackBar=SnackBar(
          content: Text(
            'Username: $_username, Email: $_email, Password: $_password'
          ),
        duration: Duration(microseconds: 5000),
      );

      mainKey.currentState.showSnackBar(snackBar);
    }

  }
}

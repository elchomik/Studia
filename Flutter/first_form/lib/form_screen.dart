import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  String name;
  String email;
  String password;
  String url;
  String phoneNumber;
  String calories;

  final GlobalKey<FormState> formKey=GlobalKey<FormState>();

  Widget buildName(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Name",
      ),
      validator: (value) {
        if (value.isEmpty) return "Name is required";
        return null;
      },

      onSaved: (value){
        name=value;
      },
    );
  }

  Widget buildEmail(){
    return TextFormField(
      decoration: InputDecoration(labelText:"Email"),
      validator: (value){
        if(value.isEmpty) return "Email is required";

        if(!RegExp("[a-z0-9!#%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
        .hasMatch(value)){
          return"Please Enter a valid email";
        }
        return null;

      },

      onSaved: (value){
        email=value;
      },
    );
  }

  Widget buildPassword(){
    return TextFormField(
      decoration: InputDecoration(labelText: "Password"),
      keyboardType: TextInputType.visiblePassword,
      maxLength: 12,
      // ignore: missing_return
      validator: (value){
        // ignore: missing_return
        if(value.isEmpty) return "Password is required";

        return null;
        },
      onSaved: (value){
        password=value;
      },
    );
  }

  Widget buildUrl(){
  return TextFormField(
    decoration: InputDecoration(
      labelText: "Url",
    ),
    validator: (value){
      if(value.isEmpty) return "Url is required";

      return null;
    },
    onSaved: (value){
      url=value;
  },
  );

  }

  Widget buildPhoneNumber(){
    return TextFormField(
      decoration: InputDecoration(labelText: "Phone Number"),
      keyboardType: TextInputType.phone,
      validator: (value){
        if(value.isEmpty) return "Phone Number is required";
        return null;
      },
      onSaved: (value){
        phoneNumber=value;
      },
    );
  }

  Widget buildCalories(){
    return TextFormField(
      decoration: InputDecoration(labelText: "Calories"),
      keyboardType: TextInputType.number,
      validator: (value){
        int calories=int.tryParse(value);

        if(calories==null || calories<=0) return " Calories must be greater than 0";
        return null;
      },
      onSaved: (value){
        calories=value;
      },

    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Demo"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10,0,0,0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             buildName(),
              buildEmail(),
              buildPassword(),
              buildUrl(),
              buildPhoneNumber(),
              buildCalories(),
              SizedBox(height: 12,),
              ElevatedButton(
                  onPressed: (){
                    if(!formKey.currentState.validate()){
                      return;
                    }
                    formKey.currentState.save();

                    print(name);
                    print(email);
                    print(phoneNumber);
                    print(url);
                    print(password);
                    print(calories);
                    Navigator.pop(context,'/');
                  },
                  child: Text(
                    "Submit",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                  ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}



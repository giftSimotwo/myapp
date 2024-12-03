import 'package:flutter/material.dart';
import 'package:myapp/services/authentication.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController emailtextcontroller = TextEditingController();
  TextEditingController passwordtextcontroller = TextEditingController();

  final Authentication authentication = Authentication();

  void createAccount() {
    authentication.signUp(emailtextcontroller.text, passwordtextcontroller.text);
    emailtextcontroller.clear();
    passwordtextcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 50.0,),
              Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),),
              SizedBox(height: 10.0,),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  hintStyle: TextStyle(color: Colors.grey)
                ),
                controller: emailtextcontroller,
              ),
              SizedBox(height: 10.0,),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  hintStyle: TextStyle(color: Colors.grey)
                ),
                controller: passwordtextcontroller,
              ),
              SizedBox(height: 30.0,),
              ElevatedButton(
                onPressed: createAccount,
                child: Text("SignUp"),
              ),
              SizedBox(height: 30.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  SizedBox(width: 10.0,),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: Text("Login"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
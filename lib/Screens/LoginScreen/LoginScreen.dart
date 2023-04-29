import 'dart:convert';
import 'package:campus_mart/Network/AuthClass/AuthClass.dart';
import 'package:campus_mart/Provider/UserProvider.dart';
import 'package:campus_mart/Screens/HomeScreen/HomeScreen.dart';
import 'package:campus_mart/Screens/SignUpScreen/SignUpScreen.dart';
import 'package:campus_mart/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:campus_mart/Utils/Snackbar.dart';
import 'package:campus_mart/Model/ErrorModel.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Auth auth = Auth();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width*.1),
        child: SingleChildScrollView(child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: kToolbarHeight*2,),

            const Text("Login", style: TextStyle(fontSize:23,fontWeight:FontWeight.bold)),
            Container(height: 10,),
            const Text("Please sign in to continue", style: TextStyle(fontSize:16)),

            Container(height: 30,),

            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "Email Addresss"
              ),
            ),

            Container(height: 20,),

            TextFormField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                  hintText: "Password"
              ),
            ),

            !isLoading ? GestureDetector(
              onTap: (){
                loginUser();
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 30),
                padding: const EdgeInsets.all(20),
                width: size.width,
                decoration:  BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.topLeft,
                      colors: [
                        primary,
                        secondary,
                      ],
                    ),
                  color: primary,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const Text("Login", textAlign: TextAlign.center, style: TextStyle(color:Colors.white, fontSize:17))
              ),
            ):   Container(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: const Center(
              child: CircularProgressIndicator(),
            )),

            const Text("Forgot password, Click here", style: TextStyle(fontSize:15,fontWeight:FontWeight.normal)),

            Container(height: size.height*.2,),

            Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: ()=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const SignUpScreen())),
                    child: const Text("Sign Up", style: TextStyle(color: primary),)
                  )
                ],
              ),
            )

          ],
        )),
      ),
    );
  }

  void loginUser() async{
    setState(() {
      isLoading = true;
    });
    await auth.loginUser({"email":email.text.toString(), "password":password.text.toString()})
        .then((value){
          setState(()=> isLoading = false);
          context.read<UserProvider>().setUserDetails(value);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> const HomeScreen()));
    }).catchError((onError){
      setState(()=> isLoading = false);
      ErrorModel error = ErrorModel.fromJson(jsonDecode(onError));
      showMessage(error.message, context);
    });
  }

}

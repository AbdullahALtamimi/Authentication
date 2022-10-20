import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_screen/screens/registerationScreen.dart';
import 'package:login_screen/screens/welcomeScreen.dart';

import '../AuthController.dart';
import '../components.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double width,height;
  bool secure = true;
  late var errors;
  var phoneNumber,password;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                height: height*.5,
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(

                      borderRadius: BorderRadius.circular(130),
                      elevation: 7,

                      child: CircleAvatar(
                        radius: 110,
                        backgroundImage:AssetImage('assets/logo/direct-logo.png'),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    Field(
                      text: 'اسم المستخدم',
                      myIcon: Icon(Icons.person),
                      secondIcon: IconButton(icon: Icon(null), onPressed: () {  },),
                      pass: false,
                      myFunction: (value){
                        phoneNumber = value;
                      },
                      validator: (value){
                        if(value!.isEmpty || !RegExp(r'^[a-z A-Z]').hasMatch(value)){
                          return 'Enter your name correctly';
                        }else return null;
                      },
                    ),
                    Field(
                      text: 'كلمة المرور',
                      myIcon: Icon(Icons.lock),
                      secondIcon: IconButton(icon:Icon(Icons.remove_red_eye), onPressed: () {
                        setState(() {
                          if(secure){
                            secure = false;
                          }else secure =true;
                        });
                      }, ),
                      pass: secure,
                      myFunction: (value){
                        password= value;
                      },
                      validator: (value){
                        if(value!.isEmpty || !RegExp(r'^[a-z A-Z]').hasMatch(value)){
                          return 'Enter your password correctly';
                        }else return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () async{
                          if(formKey.currentState!.validate()){
                            AuthController myController = AuthController();
                           var myData = await myController.loginUser(phoneNumber, password);
                           if(myData!=null){
                             Navigator.push(context, MaterialPageRoute(builder: (context){
                               return WelcomeScreen(myData);
                             }));
                           }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0XFFe84e3f),
                          minimumSize: const Size(310, 50),
                          maximumSize: const Size(310, 50),//background color
                        ),
                        child: Text('تسجيل الدخول'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return RegesterScreen();
                              }));
                            },
                            child: Container(
                              height: 25,
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(

                                    color: Color(0XFFe84e3f),
                                    width: 1.0, // This would be the width of the underline
                                  ))),
                                child: Text('انشاء حساب الان',style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.w500,color:Color(0XFFe84e3f), ),))),
                        Text('ليس لديك حساب؟',style: TextStyle(fontSize: 15 ,fontWeight: FontWeight.w500,color: Colors.black),),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

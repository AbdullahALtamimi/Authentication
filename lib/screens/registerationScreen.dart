import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_screen/AuthController.dart';
import 'package:provider/provider.dart';
import '../components.dart';
import '../notifier.dart';

class RegesterScreen extends StatefulWidget {
  const RegesterScreen({Key? key}) : super(key: key);

  @override
  State<RegesterScreen> createState() => _RegesterScreenState();
}

class _RegesterScreenState extends State<RegesterScreen> {
  bool secure = true;
  String dropdownValue = 'بغداد';
  Future getProvidinceId() async{
    http.Response respose = await http.get(Uri.parse('http://136.244.90.233:5057/api/Province'));
    var data = await jsonDecode(respose.body);
    Provider.of<Notifier>(context,listen: false).addProvidince(data);
    for(var i=0 ; i<18;i++){
      if(Provider.of<Notifier>(context,listen: false).providince[0]['result'][i]['name'] == dropdownValue){
        prividinceId = Provider.of<Notifier>(context,listen: false).providince[0]['result'][i]['id'];
      }
    }
  }
  var prividinceId;

  late String fullName,shopName,shopLocation,phoneNumber,password,userName;
  List <String> iraq = ['أربيل','الأنبار','بابل','بغداد','	البصرة','دهوك','القادسية','ديالى','ذي قار','	السليمانيه','	صلاح الدين','كركوك','كربلاء','المثنى','ميسان','	النجف','	نينوى','واسط'];
  List<DropdownMenuItem> getDropDownMenuItem(){
    List <DropdownMenuItem> items = [];
    for(var i=0 ; i < iraq.length;i++){
      String place = iraq[i];
      var newitem = DropdownMenuItem(
        child: Padding(
          padding: const EdgeInsets.only(left:250 ),
          child: Text(place,),
        ),
        value: place,
      );
      items.add(newitem);
    }
    return items;
  }
 Map signUpErrors ={};
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
          title: Center(child: Text('انشاء حساب'),
          ),
        backgroundColor: Color(0XFFe84e3f),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height * .9,
                child: Column(
                  children: [
                    Field(
                      text: 'الاسم بالكامل',
                      myIcon: Icon(Icons.person),
                      secondIcon: IconButton(icon: Icon(null), onPressed: () {  },),
                      pass: false,
                      myFunction: (value){
                        fullName = value;
                      },

                      validator: (value){
                        if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                          return 'Enter your name correctly';
                        }else return null;
                      },
                    ),
                    Field(
                      text: 'اسم المستخدم',
                      myIcon: Icon(Icons.person),
                      secondIcon: IconButton(icon: Icon(null), onPressed: () {  },),
                      pass: false,
                      myFunction: (value){
                        userName = value;
                      },

                      validator: (value){
                        if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                          return 'Enter your name correctly';
                        }else return null;
                      },
                    ),Field(
                      text: 'اسم المحل',
                      myIcon: Icon(Icons.home_filled),
                      secondIcon: IconButton(icon: Icon(null), onPressed: () {  },),
                      pass: false,
                      myFunction: (value){
                        shopName = value;
                      },
                      validator: (value){
                        if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                          return 'Enter your shop name correctly';
                        }else return null;
                      },
                    ),Field(
                      text: 'عنوان المحل',
                      myIcon: Icon(Icons.location_on_sharp),
                      secondIcon: IconButton(icon: Icon(null), onPressed: () {  },),
                      pass: false,
                      myFunction: (value){
                        shopLocation = value;
                      },
                      validator: (value){
                        if(value!.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                          return 'Enter your shop location correctly';
                        }else return null;
                      },
                    ),Field(
                      text: 'رقم الهاتف',
                      myIcon: Icon(Icons.phone),
                      secondIcon: IconButton(icon: Icon(null), onPressed: () {  },),
                      pass: false,
                      myFunction: (value){
                        phoneNumber = value;
                      },
                      validator: (value){
                        if(value!.isEmpty || !RegExp(r'^(?:[+0]9)?[0-9]{11}$').hasMatch(value)){
                          return 'Enter your phone number correctly';
                        }else return null;
                      },
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            width: 400,
                            decoration: BoxDecoration(
                              color: Color(0XFFF0F0F0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(

                                isExpanded: true,
                                value: dropdownValue,
                                items:getDropDownMenuItem(),
                                onChanged: (value) {
                                  setState(() {
                                    dropdownValue = value;
                                    getProvidinceId();

                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
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
                        password = value;
                      },
                      validator: (value){
                        if(value!.isEmpty || !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(value)){
                          return 'Enter a valid password';
                        }else return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: ()async{
                          if(formKey.currentState!.validate()){
                            AuthController myController = AuthController();
                            myController.signUpUser(fullName, shopName, shopLocation, phoneNumber, prividinceId, password,userName);
                            // print(fullName);
                            // print(shopName);
                            // print(shopLocation);
                            // print(phoneNumber);
                            // print(password);
                            // print(userName);
                            // print(prividinceId);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          backgroundColor: Color(0XFFe84e3f),
                          minimumSize: const Size(340, 50),
                          maximumSize: const Size(340, 50),//background color
                        ),
                        child: Text('تسجيل الدخول'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

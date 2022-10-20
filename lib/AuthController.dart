import 'dart:convert';

import 'package:http/http.dart' as http;
Map signUpErrors= {};
class AuthController{
  Future signUpUser(String fullname , String shopName , String location,String phoneNumber,String providince,String password,String userName) async{
    final url = 'http://136.244.90.233:5057/api/User';

    try{
      http.Response response = await http.post(Uri.parse(url), body: jsonEncode(
        {
          "fullName": fullname,
          "userName": userName,
          "password": password,
          "phoneNumber": phoneNumber,
          "roleName": "admin",
          "shop['name']":shopName,
          "shop['address']":location,
          "shop['provinceId']":providince,
        },
      ),headers: {
        "content-type" : "application/json",
        "accept" : "application/json",
      },

      );
      if(response.statusCode==200){
        var loggedIn = await jsonDecode(response.body);
        print(loggedIn);
      }else{
        print(response.body);
      }    }catch(e){
      print(e);
    }

  }
  Future loginUser(String username ,String password) async{
    final url = 'http://136.244.90.233:5057/api/Auth/login';

    http.Response response = await http.post(Uri.parse(url), body:jsonEncode({
      "userName": username,
      "password": password,
    }),headers: {
      "content-type" : "application/json",
      "accept" : "application/json",
    },
    );
    if(response.statusCode==200){
      var loggedIn = await jsonDecode(response.body);
      return loggedIn['result'];
    }else{
      print(response.statusCode);
    }
  }
}
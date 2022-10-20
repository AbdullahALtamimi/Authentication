import 'package:flutter/cupertino.dart';

class Notifier extends ChangeNotifier{
  List providince =[];
  Map signUpErrors ={};
  void addProvidince(var data){
    providince.add(data);
    notifyListeners();
  }
  void addErrors(var errors){
    signUpErrors = errors;
    notifyListeners();
    print(signUpErrors);
  }
}
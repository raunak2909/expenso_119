import 'package:flutter/material.dart';

class BottomNavPageProvider extends ChangeNotifier{

  int _selectedPageIndex = 0;
  num _balance = 0.0;

  setBalance(num bal){
    _balance = bal;
    notifyListeners();
  }

  num getBalance(){
    return _balance;
  }

  updateBottomNavPage(int index){
    _selectedPageIndex = index;
    notifyListeners();
  }

  int getBottomPageIndex() => _selectedPageIndex;


}
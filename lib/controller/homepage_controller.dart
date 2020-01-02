import 'package:flutter/material.dart';
import 'package:onthegofridge/controller/myfirebase.dart';
import 'package:onthegofridge/model/food.dart';
import 'package:onthegofridge/view/fridgeitempage.dart';
import 'package:onthegofridge/view/homepage.dart';
import 'package:onthegofridge/view/imagepage.dart';
import 'package:onthegofridge/view/passwordpage.dart';
import 'package:onthegofridge/view/recipespage.dart';
import 'package:onthegofridge/view/sharedfoodpage.dart';


class HomePageController{
  HomePageState state;

  HomePageController(this.state);

  void signOut(){
    MyFirebase.signOut();
    Navigator.pop(state.context);
    Navigator.pop(state.context);
  }

  void addImage(){
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => ImagePage(state.user),
    ));
  }
  void findRecipe(){
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => RecipePage(state.user, state.recipe, state.nutrition, state.diet),
    ));
  }
  void resetPass(){
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => PasswordPage(state.user),
    ));
  }
    void addButton() async { 
     Food f = await Navigator.push(state.context, MaterialPageRoute (
      builder: (context) => FridgeitemPage(state.user, null),
      ));
      if(f != null){
        state.itemList.add(f);
      }else {

      }
  }

  void onTap(int index) async { 
    if(state.deleteIndices == null){
    Food f = await Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => FridgeitemPage(state.user, state.itemList[index])
     ));

     if(f !=null){
       state.itemList[index] = f;
     }
    } else {
      if(state.deleteIndices.contains(index)){
        state.deleteIndices.remove(index);
        if(state.deleteIndices.length == 0){
          state.deleteIndices = null;
        }
      } else {
        state.deleteIndices.add(index);
      }
      state.stateChanged((){});
    }
  }

  void longPress(int index) async {
      if(state.deleteIndices == null){
        state.stateChanged(() {
        state.deleteIndices = <int>[index];
        });
      }
  }

  void deleteButton() async{
    state.deleteIndices.sort((n1, n2) {
      if(n1 < n2) return 1;
      else if (n1 == n2) return 0;
      else return -1;
    });
    for (var index in state.deleteIndices) {
      try{
      await MyFirebase.deleteFridgeItem(state.itemList[index]);
      state.itemList.removeAt(index);
      } catch (e) {
        print('Item Delete Error: ' + e.toString());
      }
    }
    state.stateChanged(() {
      state.deleteIndices = null;
    });
    
  }
  
  void sharedWithMeMenu() async{
    List<Food> fridgeitem = await MyFirebase.getFridgeItemsSharedWithMe(state.user.email);
    for (var food in fridgeitem){
       print (food.name);
       }
       await Navigator.push(state.context, MaterialPageRoute(
        builder: (context) => SharedFoodPage(state.user, fridgeitem),
        ));
      Navigator.pop(state.context);  
  }
}
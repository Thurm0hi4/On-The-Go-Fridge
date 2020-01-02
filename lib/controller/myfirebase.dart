import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onthegofridge/model/user.dart';
import 'package:onthegofridge/model/food.dart';

class MyFirebase {
  static Future<String> createAccount({String email, String password}) async {
    AuthResult auth =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return auth.user.uid;
  }

  static void createProfile(User user) async {
    await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(user.uid)
        .setData(user.serialize());
  }

  static Future<String> login({String email, String password}) async {
    AuthResult auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return auth.user.uid;
  }

  static Future<User> readProfile(String uid) async {
    DocumentSnapshot doc = await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(uid)
        .get();
    return User.deserialize(doc.data);
  }

  static void signOut() {
    FirebaseAuth.instance.signOut();
  }

  static Future<void> updateAccount(User user) async {
    await Firestore.instance
        .collection(User.PROFILE_COLLECTION)
        .document(user.uid)
        .setData(user.serialize());

  }

  static Future<void> resetPassword(User user) async{

    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: user.email,
    );
  }

  static Future<String> addFridgeItem(Food food) async {
    DocumentReference ref = await Firestore.instance
        .collection(Food.FRIDGEITEM_COLLECTION)
        .add(food.serialize());
    return ref.documentID;
  }

  static Future<List<Food>> getFridgeItems(String email) async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection(Food.FRIDGEITEM_COLLECTION)
        .where(Food.CREATEDBY, isEqualTo: email)
        .getDocuments();
    var itemList = <Food>[];
    if (querySnapshot == null || querySnapshot.documents.length == 0) {
      return itemList;
    }
    for (DocumentSnapshot doc in querySnapshot.documents) {
      itemList.add(Food.deserialize(doc.data, doc.documentID));
    }
    return itemList;
  }

  static Future<void> updateFridgeItem(Food food) async {
    await Firestore.instance
        .collection(Food.FRIDGEITEM_COLLECTION)
        .document(food.documentID)
        .setData(food.serialize());
  }

  static Future<void> deleteFridgeItem(Food food) async {
    await Firestore.instance
        .collection(Food.FRIDGEITEM_COLLECTION)
        .document(food.documentID)
        .delete();
  }
  
  static Future<List<Food>> getFridgeItemsSharedWithMe(String email) async {
    try {
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection(Food.FRIDGEITEM_COLLECTION)
          .where(Food.SHAREDWITH, arrayContains: email)
          .orderBy(Food.CREATEDBY)
          .orderBy(Food.LASTUPDATEDAT)
          .getDocuments();
      var items = <Food>[];
      if (querySnapshot == null || querySnapshot.documents.length == 0) {
        return items;
      }
      for (DocumentSnapshot doc in querySnapshot.documents) {
        items.add(Food.deserialize(doc.data, doc.documentID));
      }
      return items;
    } catch (e) {
      throw e;
    }
  }
}

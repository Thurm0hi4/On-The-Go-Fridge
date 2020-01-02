import '../controller/fridgeitempage_controller.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/food.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FridgeitemPage extends StatefulWidget {
  final User user;
  final Food food;
  FridgeitemPage(this.user, this.food);
  @override
  State<StatefulWidget> createState() {
    return FridgeitemPageState(user, food);
  }
}

class FridgeitemPageState extends State<FridgeitemPage> {
  User user;
  Food food;
  Food foodCopy;
  var formKey = GlobalKey<FormState>();

  FridgeitemPageController controller;

  FridgeitemPageState(this.user, this.food) {
    controller = FridgeitemPageController(this);
    if (food == null) {
      foodCopy = Food.empty();
    } else {
      foodCopy = Food.clone(food);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: foodCopy.image,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error_outline, size: 250),
                height: 250,
                width: 250,
              ),
              TextFormField(
                
                initialValue: foodCopy.image,
                decoration: InputDecoration(
                  labelText: 'Image URL',
                ),
                autocorrect: false,
                validator: controller.validateImgUrl,
                onSaved: controller.saveImgUrl,
              ),
              TextFormField(
                initialValue: foodCopy.name,
                decoration: InputDecoration(
                  labelText: 'Item Name',
                ),
                autocorrect: false,
                validator: controller.validateName,
                onSaved: controller.saveName,
              ),
              TextFormField(
                maxLines: 5,
                initialValue: foodCopy.description,
                decoration: InputDecoration(
                  labelText: 'Item Description',
                ),
                autocorrect: false,
                validator: controller.validateDescription,
                onSaved: controller.saveDescription,
              ),
              TextFormField(
                initialValue: foodCopy.amount.toString(),
                decoration: InputDecoration(
                  labelText: 'Amount of Item',
                ),
                autocorrect: false,
                validator: controller.validateAmount,
                onSaved: controller.saveAmount,
              ),
              TextFormField(
                initialValue: foodCopy.barcode.toString(),
                decoration: InputDecoration(
                  labelText: 'Item Barcode',
                ),
                autocorrect: false,
                validator: controller.validateBarcode,
                onSaved: controller.saveBarcode,
              ),
              TextFormField(
                initialValue: foodCopy.sharedWith.join(',').toString(),
                decoration: InputDecoration(
                  labelText: 'Shared With (comma seperated email list)',
                ),
                autocorrect: false,
                validator: controller.validateSharedWith,
                onSaved: controller.saveSharedWith,
              ),
              Text('Created By: ' + foodCopy.createdBy,
                  style: TextStyle(fontStyle: FontStyle.italic)),
              Text('Last Updated at ' + foodCopy.lastUpdatedAt.toString(),
                  style: TextStyle(fontStyle: FontStyle.italic)),
              Text('DocumentId ' + foodCopy.documentID.toString(),
                  style: TextStyle(fontStyle: FontStyle.italic)),
              RaisedButton(
                child: Text('Save'),
                onPressed: controller.save,
              )
            ],
          )),
    );
  }
}

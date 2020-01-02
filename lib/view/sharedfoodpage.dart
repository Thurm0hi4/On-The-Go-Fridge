import 'package:cached_network_image/cached_network_image.dart';

import '../model/user.dart';
import '../model/food.dart';
import 'package:flutter/material.dart';

class SharedFoodPage extends StatelessWidget {
  final User user;
  final List<Food> food;

  SharedFoodPage(this.user, this.food);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Shared Items'),
        ),
        body: ListView.builder(
          itemCount: food.length,
          itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(5.0),
              color: Colors.lightBlue[100],
              child: Card(
                  color: Colors.blueGrey[150],
                  elevation: 10.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: food[index].image,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error_outline),
                      ),
                      Text('${food[index].name}',
                          style: TextStyle(fontSize: 20, color: Colors.teal)),
                      Text('Description: ${food[index].description}'),
                          
                      Text('Amount: ${food[index].amount}'),
                      Text('Barcode: ${food[index].barcode}'),
                      Text('Created By: ${food[index].createdBy}'),
                      Text('Last Updated At: ${food[index].lastUpdatedAt}'),
                      Text('Shared With: ${food[index].sharedWith}'),
                    ],
                  ))),
        ));
  }
}

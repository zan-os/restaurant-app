import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/common/navigation.dart';

customDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('coming soon!'),
          content: Text('This feature will be coming soon!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigation.back();
              },
              child: Text('Ok'),
            ),
          ],
        );
      });
}

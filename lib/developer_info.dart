import 'package:flutter/material.dart';

class DeveloperInfo {
  final String name;
  final String github;
  final String avatarImage; // Path to the avatar image asset

  DeveloperInfo({required this.name, required this.github, required this.avatarImage});
}

class DeveloperInfoDialog extends StatelessWidget {
  final DeveloperInfo developer;

  DeveloperInfoDialog({required this.developer});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Developer Info'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(developer.avatarImage),
                radius: 30,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Name: ${developer.name}'),
                  SizedBox(height: 5),
                  Text('Github: ${developer.github}'),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bevorstehende Events'),
        ),
        body: Center(
          child: Text('Hier stehen bald die nächsten Events'),
        ),
    );
  }
}
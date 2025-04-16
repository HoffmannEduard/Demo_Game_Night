import 'package:flutter/material.dart';

class PastEventsScreen extends StatelessWidget {
  const PastEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bewerte Events'),
        ),
        body: Center(
          child: Text('Bewerte vergangene Events'),
        ),
    );
  }
}
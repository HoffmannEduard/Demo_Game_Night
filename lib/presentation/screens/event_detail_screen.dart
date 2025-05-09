import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:demo_game_night/presentation/widgets/host_details.dart';
import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  final GameNightEvent event;
  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
      ),
        body: Column(
          children: [
// Details zum Event (Name, Datum und Adresse)
            Center(
              child: HostDetails(event: event)
              ),
            SizedBox(height: 8.0,),
// Überschrift und Farbcontainer
            Container(
              color: Colors.amberAccent,
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('Spielevorschläge',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.black,),
                    ),
              ),
            ),
            SizedBox(height: 24.0,),
// TODO Usern ermöglichen Spiele vorzuschlagen
            Text('Hier stehen die Vorschläge')
          ],
          
        ),
        
    );
  }
}


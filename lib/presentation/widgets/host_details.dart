import 'package:demo_game_night/domain/entities/game_night_event.dart';
import 'package:flutter/widgets.dart';

class HostDetails extends StatelessWidget {
  const HostDetails({
    super.key,
    required this.event,
  });

  final GameNightEvent event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Gastgeber:',
                style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 16),),
                Text('${event.host.firstName} ${event.host.lastName}',
                style: TextStyle(fontSize: 16,),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Datum:',
                style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 16),),
                Text('${event.date.day}.${event.date.month}.${event.date.year} um ${event.date.hour.toString().padLeft(2, '0')}:${event.date.minute.toString().padLeft(2, '0')} Uhr',
                style: TextStyle(fontSize: 16,),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Adresse:',
                style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 16),),
                Column(
                  children: [
                    Text('${event.host.adress.plz} ${event.host.adress.location}',
                    style: TextStyle(fontSize: 16,),),
                    Text('${event.host.adress.street} ${event.host.adress.number}',
                    style: TextStyle(fontSize: 16,),)
                  ],
                ),
                
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
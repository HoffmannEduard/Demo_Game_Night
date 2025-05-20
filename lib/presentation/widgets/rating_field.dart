import 'package:demo_game_night/domain/cubits/rating_cubit/rating_cubit.dart';
import 'package:demo_game_night/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingField extends StatelessWidget {
  final User currentUser;
  const RatingField({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RatingCubit, RatingState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = context.read<RatingCubit>();
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Bewertung',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'Gesamt',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Gastgeber:'),
                RatingBar(
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.star, color: Colors.yellow),
                    half: Icon(Icons.star_outline),
                    empty: Icon(Icons.star_outline),
                  ),
                  onRatingUpdate: (rating) {
                    cubit.updateHostRating(rating);
                    print('Gastgeber hat $rating Sterne');
                  },
                  itemSize: 35,
                ),
                Text('4.5'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Essen:'),
                RatingBar(
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.star, color: Colors.yellow),
                    half: Icon(Icons.star_outline),
                    empty: Icon(Icons.star_outline),
                  ),
                  onRatingUpdate: (rating) {
                    cubit.updateFoodRating(rating);
                    print('Essen hat: $rating Sterne');
                  },
                  itemSize: 35,
                ),
                Text('4.5'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Abend:'),
                RatingBar(
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.star, color: Colors.yellow),
                    half: Icon(Icons.star_outline),
                    empty: Icon(Icons.star_outline),
                  ),
                  onRatingUpdate: (rating) {
                    cubit.updateEventRating(rating);
                    print('Abend hat: $rating Sterne');
                  },
                  itemSize: 35,
                ),
                Text('4.5'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    cubit.addRating();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent,
                    foregroundColor: Colors.black,
                  ),
                  child: Text('Bewerten'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

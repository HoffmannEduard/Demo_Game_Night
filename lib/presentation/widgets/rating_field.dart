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
        final hasRated = state.userRatedForEvent;
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
                  initialRating: hasRated ? (state.hostRating ?? 0.0) : 0.0,
                  ignoreGestures: hasRated,
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.star, color: Colors.yellow),
                    half: Icon(Icons.star_outline),
                    empty: Icon(Icons.star_outline),
                  ),
                  onRatingUpdate: (rating) {
                    if (!hasRated) cubit.updateHostRating(rating);
                  },
                  itemSize: 35,
                ),
                Text(state.avgHost?.toStringAsFixed(1) ?? "-"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Essen:'),
                RatingBar(
                  initialRating: hasRated ? (state.foodRating ?? 0.0) : 0.0,
                  ignoreGestures: hasRated,
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.star, color: Colors.yellow),
                    half: Icon(Icons.star_outline),
                    empty: Icon(Icons.star_outline),
                  ),
                  onRatingUpdate: (rating) {
                    if (!hasRated) cubit.updateFoodRating(rating);
                  },
                  itemSize: 35,
                ),
                Text(state.avgFood?.toStringAsFixed(1) ?? "-"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Abend:'),
                RatingBar(
                  initialRating: hasRated ? (state.eventRating ?? 0.0) : 0.0,
                  ignoreGestures: hasRated,
                  ratingWidget: RatingWidget(
                    full: Icon(Icons.star, color: Colors.yellow),
                    half: Icon(Icons.star_outline),
                    empty: Icon(Icons.star_outline),
                  ),
                  onRatingUpdate: (rating) {
                    if (!hasRated) cubit.updateEventRating(rating);
                  },
                  itemSize: 35,
                ),
                Text(state.avgEvent?.toStringAsFixed(1) ?? "-"),
              ],
            ),
            const SizedBox(height: 12),
            if (!hasRated)
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

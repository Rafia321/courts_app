import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:courts_app/models/court.dart';
import 'package:courts_app/providers/favourites.dart';
import 'package:courts_app/screens/court_detail_screen.dart';
import 'package:courts_app/widgets/court_card.dart';

void main() {
  final court = Court(id: 2, name: 'Centre Court', pricePerHour: 40, isIndoor: true);

  test('Court.fromJson maps the API fields', () {
    final parsed = Court.fromJson({'id': 3, 'title': 'Court three'});

    expect(parsed.id, 3);
    expect(parsed.name, 'Court three');
    expect(parsed.pricePerHour, 60);
    expect(parsed.isIndoor, false);
  });

  test('Favourites toggles a court on and off', () {
    final favourites = Favourites();

    favourites.toggle(2);
    expect(favourites.isFavourite(2), true);

    favourites.toggle(2);
    expect(favourites.isFavourite(2), false);
  });

  testWidgets('Tapping the heart on a card saves it', (tester) async {
    final favourites = Favourites();

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: favourites,
        child: MaterialApp(
          home: Scaffold(body: CourtCard(court: court)),
        ),
      ),
    );

    expect(find.text('Centre Court'), findsOneWidget);
    expect(find.text('AED 40 / hour'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(favourites.isFavourite(2), true);
  });

  testWidgets('Adding an hour updates the total', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => Favourites(),
        child: MaterialApp(
          home: CourtDetailScreen(court: court),
        ),
      ),
    );

    expect(find.text('AED 40'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add_circle_outline));
    await tester.pump();

    expect(find.text('2 hours'), findsOneWidget);
    expect(find.text('AED 80'), findsOneWidget);
  });
}

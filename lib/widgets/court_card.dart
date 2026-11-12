import 'package:courts_app/providers/favourites.dart';
import 'package:flutter/material.dart';
import 'package:courts_app/models/court.dart';
import 'package:courts_app/screens/court_detail_screen.dart';
import 'package:provider/provider.dart';

class CourtCard extends StatelessWidget {
  final Court court;

  const CourtCard({super.key, required this.court});

  @override
  Widget build(BuildContext context) {
    final isFavourite = context.watch<Favourites>().isFavourite(court.id);
    final colors = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourtDetailScreen(court: court),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  court.isIndoor ? Icons.home_rounded : Icons.wb_sunny_rounded,
                  color: colors.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      court.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      court.isIndoor ? 'Indoor' : 'Outdoor',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 6),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'AED ${court.pricePerHour}',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: colors.primary,
                            ),
                          ),
                          TextSpan(
                            text: ' / hour',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: isFavourite ? Colors.red.shade400 : Colors.grey.shade400,
                ),
                onPressed: () => context.read<Favourites>().toggle(court.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

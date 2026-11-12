import 'package:courts_app/providers/favourites.dart';
import 'package:courts_app/screens/booking_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:courts_app/models/court.dart';
import 'package:provider/provider.dart';

class CourtDetailScreen extends StatefulWidget {
  final Court court;

  const CourtDetailScreen({super.key, required this.court});

  @override
  State<CourtDetailScreen> createState() => _CourtDetailScreenState();
}

class _CourtDetailScreenState extends State<CourtDetailScreen> {
  int hours = 1;

  @override
  Widget build(BuildContext context) {
    final favourites = context.watch<Favourites>();
    final isFavourite = favourites.isFavourite(widget.court.id);
    final court = widget.court;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              isFavourite ? Icons.favorite : Icons.favorite_border,
              color: isFavourite ? Colors.red.shade400 : null,
            ),
            onPressed: () => context.read<Favourites>().toggle(court.id),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                court.isIndoor ? Icons.home_rounded : Icons.wb_sunny_rounded,
                size: 72,
                color: colors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              court.name,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _InfoPill(
                  icon: court.isIndoor ? Icons.home_outlined : Icons.wb_sunny_outlined,
                  label: court.isIndoor ? 'Indoor' : 'Outdoor',
                ),
                const SizedBox(width: 8),
                _InfoPill(
                  icon: Icons.payments_outlined,
                  label: 'AED ${court.pricePerHour} / hour',
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Duration',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Text(
                    hours == 1 ? '1 hour' : '$hours hours',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: hours > 1 ? () => setState(() => hours--) : null,
                  ),
                  Text(
                    '$hours',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    color: colors.primary,
                    onPressed: () => setState(() => hours++),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  Text(
                    'AED ${court.pricePerHour * hours}',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingFormScreen(court: court),
                      ),
                    );
                  },
                  child: const Text('Book this court'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: Colors.grey.shade800)),
        ],
      ),
    );
  }
}

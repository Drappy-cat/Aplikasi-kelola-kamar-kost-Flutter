import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tes/app/app_routes.dart';
import 'package:tes/features/home/bloc/user_home_bloc.dart';
import 'package:tes/shared/models/room.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomCard extends StatelessWidget {
  final Room room;

  const RoomCard({super.key, required this.room});

  String _formatCurrency(num amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final price = _formatCurrency(room.totalPrice);
    final bool isAvailable = room.status == 'Kosong';

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          await context.push(AppRoutes.roomDetail, extra: room);
          if (context.mounted) {
            context.read<UserHomeBloc>().add(const UserHomeEvent.loadData());
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'room-image-${room.code}',
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.asset(
                    room.imageUrls.isNotEmpty ? room.imageUrls.first : 'assets/logo/logo.png',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 180,
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image),
                    ),
                  ),
                  if (room.status.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: Colors.transparent,
                        child: Chip(
                          label: Text(room.status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          backgroundColor: isAvailable ? Colors.green.withOpacity(0.8) : Colors.black.withOpacity(0.5),
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kamar ${room.code}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 4),
                  Text(price, style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text('Ukuran: ${room.dimensions}', style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

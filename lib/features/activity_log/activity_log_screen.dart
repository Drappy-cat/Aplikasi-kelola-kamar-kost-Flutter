import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tes/features/activity_log/bloc/activity_log_bloc.dart';

// Halaman wrapper yang menyediakan BLoC
class ActivityLogScreen extends StatelessWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityLogBloc()..add(const ActivityLogEvent.load()),
      child: const ActivityLogView(),
    );
  }
}

// Widget yang membangun UI
class ActivityLogView extends StatelessWidget {
  const ActivityLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar tidak diperlukan karena halaman ini akan menjadi bagian dari AdminPanel
      body: BlocBuilder<ActivityLogBloc, ActivityLogState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text(state.error!));
          }
          if (state.logs.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada aktivitas yang tercatat.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<ActivityLogBloc>().add(const ActivityLogEvent.load());
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: state.logs.length,
              itemBuilder: (context, index) {
                final log = state.logs[index];
                final isBerangkat = log.action == 'Berangkat';

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: (isBerangkat ? Colors.orange : Colors.green).withOpacity(0.1),
                      child: Icon(
                        isBerangkat ? Icons.arrow_upward : Icons.arrow_downward,
                        color: isBerangkat ? Colors.orange : Colors.green,
                      ),
                    ),
                    title: Text('${log.userName} - ${log.action}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(DateFormat('d MMM yyyy, HH:mm').format(log.timestamp)),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

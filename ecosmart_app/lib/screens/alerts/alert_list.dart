import 'package:ecosmart_app/models/alert_model.dart';
import 'package:flutter/material.dart';
import 'package:ecosmart_app/services/alert_service.dart';

class AlertListScreen extends StatelessWidget {
  const AlertListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alertas')),
      body: FutureBuilder<List<Alert>>(
        future: AlertService.getAlerts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final alert = snapshot.data![index];
                return ListTile(
                  title: Text('Contenedor ${alert.containerId}'),
                  subtitle: Text('Nivel crítico: ${alert.threshold}%'),
                  trailing: IconButton(
                    icon: const Icon(Icons.check_circle, color: Colors.green),
                    onPressed: () => AlertService.markAsResolved(alert.id),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
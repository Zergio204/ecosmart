import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/alerta.dart';

class AlertasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Alertas')),
      body: FutureBuilder<List<Alerta>>(
        future: ApiService().getAlertas(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final alerta = snapshot.data![index];
                return ListTile(
                  title: Text('Contenedor ${alerta.idContenedor}'),
                  subtitle: Text('Nivel crítico: ${alerta.umbral}%'),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      await ApiService().resolverAlerta(alerta.id);
                      // Refrescar lista
                    },
                    child: Text('Resolver'),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
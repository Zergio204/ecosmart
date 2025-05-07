import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:ecosmart_app/models/container_model.dart';
import 'package:ecosmart_app/models/time_series_sales.dart';

class ContainerDetailScreen extends StatelessWidget {
  final ContainerModel container;

  const ContainerDetailScreen({super.key, required this.container});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(container.ubicacion)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: container.nivelLlenado / 100,
              backgroundColor: Colors.grey[200],
              color: container.nivelLlenado > 80 ? Colors.red : Colors.green,
            ),
            const SizedBox(height: 20),
            Text('${container.nivelLlenado}%', style: const TextStyle(fontSize: 24)),
            if (container.prediccion != null)
              Expanded(
                child: charts.TimeSeriesChart(
                  [
                    charts.Series<TimeSeriesSales, DateTime>(
                      id: 'Predicción',
                      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                      domainFn: (TimeSeriesSales sales, _) => sales.time,
                      measureFn: (TimeSeriesSales sales, _) => sales.sales,
                      data: container.prediccion!
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
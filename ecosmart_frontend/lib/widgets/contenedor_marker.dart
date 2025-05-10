import 'package:flutter/material.dart';
import '../models/contenedor.dart';

class ContenedorMarker extends StatelessWidget {
  final Contenedor contenedor;

  ContenedorMarker({required this.contenedor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/contenedor-detail',
        arguments: contenedor.id,
      ),
      child: Column(
        children: [
          Icon(
            Icons.delete,
            color: contenedor.nivelLlenado > 80 ? Colors.red : Colors.green,
            size: 40,
          ),
          Text(
            '${contenedor.nivelLlenado}%',
            style: TextStyle(
              color: contenedor.nivelLlenado > 80 ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
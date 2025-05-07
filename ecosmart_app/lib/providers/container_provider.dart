import 'package:flutter/material.dart';
import 'package:ecosmart_app/models/container_model.dart';
import 'package:ecosmart_app/services/container_service.dart';

class ContainerProvider with ChangeNotifier {
  List<ContainerModel> _containers = [];
  
  List<ContainerModel> get containers => _containers;

  Future<void> loadContainers() async {
    _containers = await ContainerService.getContainers();
    notifyListeners();
  }
}
import 'package:flutter/material.dart';
import '../models/device_model.dart';
import 'device_card.dart';

class DeviceGrid extends StatelessWidget {
  final List<DeviceModel> devices;
  final Function(int index) onCardTap;
  final Function(int index, bool val) onToggle;

  const DeviceGrid({
    super.key,
    required this.devices,
    required this.onCardTap,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: devices.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) {
        return DeviceCard(
          device: devices[index],
          onTap: () => onCardTap(index),
          onToggle: (val) => onToggle(index, val),
        );
      },
    );
  }
}

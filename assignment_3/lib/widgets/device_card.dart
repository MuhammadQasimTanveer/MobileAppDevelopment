import 'package:flutter/material.dart';
import '../models/device_model.dart';

class DeviceCard extends StatelessWidget {
  final DeviceModel device;
  final VoidCallback onTap;
  final ValueChanged<bool>? onToggle;

  const DeviceCard({
    super.key,
    required this.device,
    required this.onTap,
    this.onToggle,
  });

  IconData getDeviceIcon() {
    switch (device.type) {
      case "Light":
        return Icons.lightbulb;
      case "Fan":
        return Icons.air;
      case "AC":
        return Icons.ac_unit;
      case "Camera":
        return Icons.videocam;
      default:
        return Icons.device_unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.indigo.withOpacity(0.2),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: device.isOn ? Colors.indigo.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Colors.black12,
            )
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(getDeviceIcon(), size: 40, color: Colors.indigo),
            const SizedBox(height: 12),
            Text(device.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Switch(
              value: device.isOn,
              onChanged: onToggle,
            ),
            Text(
              device.isOn ? "Status: ON" : "Status: OFF",
              style: TextStyle(
                  color: device.isOn ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

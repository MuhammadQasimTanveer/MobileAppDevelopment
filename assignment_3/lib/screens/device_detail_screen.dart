import 'package:flutter/material.dart';
import '../models/device_model.dart';

class DeviceDetailScreen extends StatefulWidget {
  final DeviceModel device;

  const DeviceDetailScreen({super.key, required this.device});

  @override
  State<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.device.name)),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.devices, size: 120, color: Colors.indigo),
            const SizedBox(height: 20),

            Text(
              "Status: ${widget.device.isOn ? "ON" : "OFF"}",
              style: TextStyle(
                fontSize: 20,
                color: widget.device.isOn ? Colors.green : Colors.red,
              ),
            ),

            const SizedBox(height: 30),

            Slider(
              value: widget.device.value,
              min: 0,
              max: 100,
              onChanged: widget.device.isOn
                  ? (val) {
                setState(() {
                  widget.device.value = val;
                });
              }
                  : null,
            ),

            Text("Value: ${widget.device.value.toInt()}"),
          ],
        ),
      ),
    );
  }
}

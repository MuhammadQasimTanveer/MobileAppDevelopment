import 'package:flutter/material.dart';
import '../models/device_model.dart';
import '../data/device_data.dart';

class AddDeviceScreen extends StatefulWidget {
  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {
  final nameCtrl = TextEditingController();
  final roomCtrl = TextEditingController();

  String type = "Light";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Device")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: InputDecoration(labelText: "Device Name"),
            ),
            TextField(
              controller: roomCtrl,
              decoration: InputDecoration(labelText: "Room Name"),
            ),

            DropdownButton<String>(
              value: type,
              onChanged: (val) {
                setState(() => type = val!);
              },
              items: ["Light", "Fan", "AC", "Camera"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                devices.add(DeviceModel(
                  name: nameCtrl.text,
                  room: roomCtrl.text,
                  type: type,
                ));

                Navigator.pop(context);
              },
              child: const Text("Add Device"),
            )
          ],
        ),
      ),
    );
  }
}

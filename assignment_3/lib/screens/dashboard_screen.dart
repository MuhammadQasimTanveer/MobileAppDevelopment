import 'package:flutter/material.dart';
import '../data/device_data.dart';
import '../widgets/device_grid.dart';
import 'device_detail_screen.dart';
import 'add_device_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Home Dashboard"),
        leading: const Icon(Icons.menu),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/profile.jpg"),
            ),
          )
        ],
      ),

      body: DeviceGrid(
        devices: devices,
        onCardTap: (index) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DeviceDetailScreen(device: devices[index]),
            ),
          ).then((_) {
            setState(() {});
          });
        },
        onToggle: (index, val) {
          setState(() {
            devices[index].isOn = val;
          });
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddDeviceScreen()),
          );
          setState(() {});
        },
      ),
    );
  }
}

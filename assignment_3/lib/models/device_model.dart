class DeviceModel {
  String name;
  String type;
  String room;
  bool isOn;
  double value; // brightness or speed

  DeviceModel({
    required this.name,
    required this.type,
    required this.room,
    this.isOn = false,
    this.value = 50,
  });
}

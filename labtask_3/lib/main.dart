import 'package:flutter/material.dart';

void main() => runApp(const DemoApp());

class DemoApp extends StatelessWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Class Topics Demo",
      home: const DemoScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  int counter = 0;
  Color boxColor = Colors.blue;

  List<String> items = ["One", "Two", "Three"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Class Widgets Demo")),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              // ------------------------- ROW / COLUMN -------------------------
              const Text("Row / Column Demo",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(Icons.star, color: Colors.amber, size: 40),
                  Icon(Icons.star_border, color: Colors.grey, size: 40),
                  Icon(Icons.star_half, color: Colors.orange, size: 40),
                ],
              ),

              const Divider(height: 30),

              const Text("Stack & Positioned Demo",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              SizedBox(
                width: 200,
                height: 150,
                child: Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 150,
                      color: Colors.lightBlue.shade100,
                    ),
                    const Positioned(
                      right: 10,
                      bottom: 10,
                      child: Icon(Icons.favorite, color: Colors.red, size: 40),
                    )
                  ],
                ),
              ),

              const Divider(height: 30),


              const Text("Gesture Detector (Tap to Change Color)",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: () {
                  setState(() {
                    boxColor =
                    boxColor == Colors.blue ? Colors.orange : Colors.blue;
                  });
                },
                child: AnimatedContainer(
                  width: 120,
                  height: 120,
                  duration: const Duration(milliseconds: 300),
                  color: boxColor,
                  alignment: Alignment.center,
                  child: const Text("Tap Me",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),

              const Divider(height: 30),

              
              const Text("InkWell Ripple Demo",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Card tapped!")),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Ink(
                  width: 180,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Tap InkWell",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),

              const Divider(height: 30),


              const Text("Buttons Demo",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  setState(() => counter++);
                },
                child: const Text("Increment Counter"),
              ),

              const SizedBox(height: 10),

              Text("Count: $counter",
                  style: const TextStyle(fontSize: 24)),

              const Divider(height: 30),

              const Text("Expanded / Flexible Demo",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(height: 50, color: Colors.red),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(height: 50, color: Colors.green),
                  ),
                ],
              ),

              const Divider(height: 30),


              const Text("Dismissible Demo",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),

              Column(
                children: List.generate(items.length, (index) {
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child:
                      const Icon(Icons.delete, color: Colors.white, size: 30),
                    ),
                    onDismissed: (dir) {
                      setState(() => items.removeAt(index));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(items[index], style: const TextStyle(fontSize: 16)),
                    ),
                  );
                }),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
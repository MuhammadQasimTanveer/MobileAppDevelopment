import 'package:flutter/material.dart';

class Aboutpage extends StatelessWidget {
  const Aboutpage({super.key});

  final List<Map<String, String>> landmarks = const [
    {
      "image": "https://images.unsplash.com/photo-1505761671935-60b3a7427bad",
      "name": "Eiffel Tower"
    },
    {
      "image": "https://images.unsplash.com/photo-1511739001486-6bfe10ce785f",
      "name": "Great Wall of China"
    },
    {
      "image": "https://media.istockphoto.com/id/2050015614/photo/historic-landmark-badshahi-mosque-in-lahore-pakistan.webp?a=1&b=1&s=612x612&w=0&k=20&c=w3MbABDUzlR6Fyr2CEotDMDmjJy7L_Fb7EXcgZFUvpI=",
      "name": "Badshahi Mosque"
    },
    {
      "image": "https://images.unsplash.com/photo-1611068661807-c850d6a24f62?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8TWF6YXItZS1RdWFpZHxlbnwwfHwwfHx8MA%3D%3D",
      "name": "Mazar-e-Quaid"
    },
    {
      "image": "https://images.unsplash.com/photo-1608020932658-d0e19a69580b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8ZmFpc2FsJTIwbW9zcXVlfGVufDB8fDB8fHww",
      "name": "Faisal Mosque"
    },
    {
      "image": "https://images.unsplash.com/photo-1750132517532-5b99db8a8f79?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8U3lkbmV5JTIwSGFyYm91ciUyMEJyaWRnfGVufDB8fDB8fHww",
      "name": "Sydney Harbour Bridge"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: landmarks.length,
      itemBuilder: (context, index) {
        final place = landmarks[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 4,  //create a shadow
          child: Column(
            //Make children expand horizontally
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                //cuts its child widget’s corners according to the given border radius.
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network( place["image"]!, fit: BoxFit.cover,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(place["name"]!, textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
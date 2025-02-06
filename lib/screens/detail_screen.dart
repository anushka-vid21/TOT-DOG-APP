import 'package:flutter/material.dart';
import '../models/dog.dart';
import '../services/db_service.dart';

class DetailScreen extends StatelessWidget {
  final Dog dog;
  final DBService dbService = DBService();

  DetailScreen({super.key, required this.dog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dog.name)),
      body: Column(
        children: [
          Image.network(dog.image),
          Text(dog.breed, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(dog.description ?? 'No description available'),
          ElevatedButton(
            onPressed: () async {
              print("Saving dog: ${dog.name}");
              await DBService.insertDog(dog);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dog saved!')),
              );
            },
            child: const Text('Save'),
          )
        ],
      ),
    );
  }
}

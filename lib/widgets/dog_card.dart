import 'package:flutter/material.dart';
import '../models/dog.dart';

class DogCard extends StatelessWidget {
  final Dog dog;

  DogCard({required this.dog, required Null Function() onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Image.network(dog.image, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(dog.name),
        subtitle: Text(dog.breed),
      ),
    );
  }
}

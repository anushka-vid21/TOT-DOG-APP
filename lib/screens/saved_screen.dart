import 'package:flutter/material.dart';
import '../services/db_service.dart';
import '../models/dog.dart';
import '../widgets/dog_card.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<Dog> savedDogs = [];

  @override
  void initState() {
    super.initState();
    fetchSavedDogs();
  }

  // ✅ Fetch saved dogs from database
  void fetchSavedDogs() async {
    print("Fetching saved dogs...");
    final dogs = await DBService.getSavedDogs();
    setState(() {
      savedDogs = dogs;
    });
  }

  // ✅ Remove dog and refresh list
  void removeDog(Dog dog) async {
    print("Removing dog: ${dog.name}");
    await DBService.deleteDog(dog.id!);
    fetchSavedDogs(); // Refresh list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Saved Dogs")),
      body: savedDogs.isEmpty
          ? Center(child: Text("No saved dogs yet!"))
          : ListView.builder(
        itemCount: savedDogs.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(savedDogs[index].id.toString()),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              removeDog(savedDogs[index]);
            },
            child: DogCard(
              dog: savedDogs[index],
              onTap: () {
                print("Tapped on saved dog: ${savedDogs[index].name}");
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/dog.dart';
import '../widgets/dog_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService apiService = ApiService();
  List<Dog> allDogs = [];
  List<Dog> filteredDogs = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchDogs();
  }

  // Fetch the list of dogs from the API with error handling
  void fetchDogs() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final dogs = await apiService.fetchDogs();
      setState(() {
        allDogs = dogs;
        filteredDogs = dogs; // Initially show all dogs
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Failed to load dogs. Please try again.";
      });
    }
  }

  // Filter dogs based on query
  void filterDogs(String query) {
    setState(() {
      filteredDogs = allDogs
          .where((dog) =>
      dog.name!.toLowerCase().contains(query.toLowerCase()) ||
          dog.breed!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Dogs"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to HomeScreen
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Search by name or breed",
                border: OutlineInputBorder(),
              ),
              onChanged: filterDogs,
            ),
          ),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ),
          if (isLoading && filteredDogs.isEmpty)
            Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (filteredDogs.isEmpty)
            Expanded(
              child: Center(child: Text('No dogs found')),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: filteredDogs.length,
                itemBuilder: (context, index) {
                  return DogCard(
                    dog: filteredDogs[index],
                    onTap: () {},
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for Timer
import '../services/api_service.dart';
import '../models/dog.dart';
import '../widgets/dog_card.dart';
import 'dart:async'; // Import for Timer
import 'detail_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  List<Dog> dogs = [];
  int _selectedIndex = 0;  // Track the selected index of the bottom navigation bar
  bool isLoading = true;  // Track loading state

  @override
  void initState() {
    super.initState();
    fetchDogs();
  }

  // Fetch the list of dogs from the API with error handling
  void fetchDogs() async {
    try {
      final fetchedDogs = await apiService.fetchDogs();
      setState(() {
        dogs = fetchedDogs;
        isLoading = false; // Set loading to false once data is fetched
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Stop loading if there's an error
      });
      // Optionally, show an error message here (e.g., using a SnackBar or an alert dialog)
    }
  }

  // Function to handle bottom navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.pushNamed(context, '/search').then((_) {
        // Reset to home when coming back from search screen
        setState(() {
          _selectedIndex = 0; // Reset to home tab
        });
      });
    } else if (index == 2) {
      Navigator.pushNamed(context, '/saved').then((_) {
        // Reset to home when coming back from saved screen
        setState(() {
          _selectedIndex = 0; // Reset to home tab
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(
          child: Text("TOT APP"),
      ),
        backgroundColor: Color(0xFF875F98),// Set your desired color here),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loader while fetching data
          : ListView.builder(
        itemCount: dogs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DetailScreen(dog: dogs[index]);
                  },
                ),
              );
            },
            child: DogCard(dog: dogs[index], onTap: () {}),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,  // Background color of BottomNavigationBar
        //selectedItemColor: Colors.p,  // Color of the selected item
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Saved'),
        ],
        currentIndex: _selectedIndex, // The current index that will be shown
        onTap: _onItemTapped, // Handle item tap
      ),
    );
  }
}

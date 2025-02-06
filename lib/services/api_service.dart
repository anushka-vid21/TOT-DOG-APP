import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dog.dart';

class ApiService {
  static const String baseUrl = "https://dog.ceo/api";

  Future<List<Dog>> fetchDogs() async {
    try {
      print("Fetching dog breeds from API...");
      final response = await http.get(Uri.parse("$baseUrl/breeds/list/all"));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<String> breeds = (data['message'] as Map<String, dynamic>).keys.toList();

        List<Dog> dogs = [];

        // Fetch an image for each breed
        for (String breed in breeds) {
          String imageUrl = await fetchDogImage(breed);
          dogs.add(Dog(name: breed, breed: breed, image: imageUrl, description: ''));
        }

        print("Successfully fetched ${dogs.length} dogs from API.");
        return dogs;
      } else {
        print("Failed to load breeds. Status Code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error fetching dogs: $e");
      return [];
    }
  }

  Future<String> fetchDogImage(String breed) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/breed/$breed/images/random"));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        return data['message'] ?? "";
      } else {
        return "";
      }
    } catch (e) {
      print("Error fetching image for breed $breed: $e");
      return "";
    }
  }
}

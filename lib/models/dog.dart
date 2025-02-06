class Dog {
  final int? id;
  final String name;
  final String breed;
  final String image;
  final String? description;

  Dog({
    this.id,
    required this.name,
    required this.breed,
    required this.image,
    this.description,
  });

  // Convert a Dog object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'breed': breed,
      'image': image,
      'description': description,
    };
  }

  // Convert a Map into a Dog object
  factory Dog.fromMap(Map<String, dynamic> map) {
    return Dog(
      id: map['id'],
      name: map['name'],
      breed: map['breed'],
      image: map['image'],
      description: map['description'],
    );
  }
}

import 'package:equatable/equatable.dart';

class ListDoctors extends Equatable {
  final String name;
  final String specialty;
  final String hospital;
  final double rating;
  final String imageUrl;

  const ListDoctors({
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.rating,
    required this.imageUrl,
  });

  ListDoctors copyWith({
    String? name,
    String? specialty,
    String? hospital,
    double? rating,
    String? imageUrl,
  }) {
    return ListDoctors(
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      hospital: hospital ?? this.hospital,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory ListDoctors.fromMap(Map<String, dynamic> json) => ListDoctors(
    name: json['name'] as String,
    specialty: json['specialty'] as String,
    hospital: json['hospital'] as String,
    rating: (json['rating'] as num).toDouble(),
    imageUrl: json['imageUrl'] as String,
  );

  Map<String, dynamic> toMap() => {
    'name': name,
    'specialty': specialty,
    'hospital': hospital,
    'rating': rating,
    'imageUrl': imageUrl,
  };

  @override
  List<Object> get props => [name, specialty, hospital, rating, imageUrl];
}




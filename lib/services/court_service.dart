import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:courts_app/models/court.dart';

Future<List<Court>> fetchCourts() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=10'),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Court.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load courts');
  }
}
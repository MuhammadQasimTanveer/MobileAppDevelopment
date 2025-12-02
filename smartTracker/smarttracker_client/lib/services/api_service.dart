import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/activity_model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api';

  // Get all activities
  Future<List<Activity>> getAllActivities() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/activities'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Activity> activities = (data['data'] as List)
            .map((json) => Activity.fromJson(json))
            .toList();
        return activities;
      } else {
        throw Exception('Failed to load activities');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Create activity with image
  Future<Activity> createActivity({
    required String title,
    required String description,
    required double latitude,
    required double longitude,
    File? imageFile,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/activities'),
      );

      // Add fields
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['latitude'] = latitude.toString();
      request.fields['longitude'] = longitude.toString();

      // Add image if exists
      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path),
        );
      }

      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        final data = json.decode(responseData);
        return Activity.fromJson(data['data']);
      } else {
        throw Exception('Failed to create activity');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Delete activity
  Future<void> deleteActivity(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/activities/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete activity');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Search activities
  Future<List<Activity>> searchActivities(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/activities/search/$query'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Activity> activities = (data['data'] as List)
            .map((json) => Activity.fromJson(json))
            .toList();
        return activities;
      } else {
        throw Exception('Failed to search activities');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
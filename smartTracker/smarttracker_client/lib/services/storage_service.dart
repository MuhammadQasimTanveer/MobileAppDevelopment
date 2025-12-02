import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/activity_model.dart';

class StorageService {
  static const String _recentActivitiesKey = 'recent_activities';

  // Save recent 5 activities
  Future<void> saveRecentActivities(List<Activity> activities) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Take only first 5 activities
      final recentActivities = activities.take(5).toList();

      // Convert to JSON string
      final jsonList = recentActivities.map((a) => a.toJson()).toList();
      final jsonString = json.encode(jsonList);

      await prefs.setString(_recentActivitiesKey, jsonString);
    } catch (e) {
      throw Exception('Failed to save activities: $e');
    }
  }

  // Get recent activities
  Future<List<Activity>> getRecentActivities() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_recentActivitiesKey);

      if (jsonString == null) {
        return [];
      }

      final jsonList = json.decode(jsonString) as List;
      return jsonList.map((json) => Activity.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  // Clear all stored data
  Future<void> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_recentActivitiesKey);
    } catch (e) {
      throw Exception('Failed to clear data: $e');
    }
  }

  // Check if offline data exists
  Future<bool> hasOfflineData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_recentActivitiesKey);
    } catch (e) {
      return false;
    }
  }
}
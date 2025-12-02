import 'dart:io';
import '../models/activity_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../services/location_service.dart';
import '../services/camera_service.dart';

class ActivityRepository {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();
  final LocationService _locationService = LocationService();
  final CameraService _cameraService = CameraService();

  // Get all activities (with offline fallback)
  Future<List<Activity>> getAllActivities() async {
    try {
      // Try to fetch from API
      final activities = await _apiService.getAllActivities();

      // Save to local storage (recent 5)
      await _storageService.saveRecentActivities(activities);

      return activities;
    } catch (e) {
      // If API fails, return offline data
      return await _storageService.getRecentActivities();
    }
  }

  // Create new activity
  Future<Activity> createActivity({
    required String title,
    required String description,
    required double latitude,
    required double longitude,
    File? imageFile,
  }) async {
    try {
      final activity = await _apiService.createActivity(
        title: title,
        description: description,
        latitude: latitude,
        longitude: longitude,
        imageFile: imageFile,
      );

      // Update local storage
      final activities = await getAllActivities();
      await _storageService.saveRecentActivities(activities);

      return activity;
    } catch (e) {
      throw Exception('Failed to create activity: $e');
    }
  }

  // Delete activity
  Future<void> deleteActivity(String id) async {
    try {
      await _apiService.deleteActivity(id);

      // Update local storage
      final activities = await getAllActivities();
      await _storageService.saveRecentActivities(activities);
    } catch (e) {
      throw Exception('Failed to delete activity: $e');
    }
  }

  // Search activities
  Future<List<Activity>> searchActivities(String query) async {
    try {
      return await _apiService.searchActivities(query);
    } catch (e) {
      // If API fails, search in offline data
      final offlineData = await _storageService.getRecentActivities();
      return offlineData.where((activity) {
        return activity.title.toLowerCase().contains(query.toLowerCase()) ||
            activity.description.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  // Get current location
  Future<Map<String, double>> getCurrentLocation() async {
    try {
      final position = await _locationService.getCurrentLocation();
      return {
        'latitude': position.latitude,
        'longitude': position.longitude,
      };
    } catch (e) {
      throw Exception('Failed to get location: $e');
    }
  }

  // Capture image
  Future<File?> captureImage(bool fromCamera) async {
    try {
      return await _cameraService.pickImage(fromCamera: fromCamera);
    } catch (e) {
      throw Exception('Failed to capture image: $e');
    }
  }

  // Get offline activities
  Future<List<Activity>> getOfflineActivities() async {
    return await _storageService.getRecentActivities();
  }

  // Check offline data availability
  Future<bool> hasOfflineData() async {
    return await _storageService.hasOfflineData();
  }

  // Clear all local data
  Future<void> clearLocalData() async {
    await _storageService.clearAll();
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import '../models/activity_model.dart';
import '../repositories/activity_repository.dart';

class ActivityProvider with ChangeNotifier {
  final ActivityRepository _repository = ActivityRepository();

  List<Activity> _activities = [];
  bool _isLoading = false;
  String? _error;

  Map<String, double>? _currentLocation;
  File? _selectedImage;

  // Getters
  List<Activity> get activities => _activities;
  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, double>? get currentLocation => _currentLocation;
  File? get selectedImage => _selectedImage;

  // Load all activities
  Future<void> loadActivities() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _activities = await _repository.getAllActivities();
      _error = null;
    } catch (e) {
      _error = e.toString();
      // Try to load offline data
      _activities = await _repository.getOfflineActivities();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create new activity
  Future<bool> createActivity({
    required String title,
    required String description,
  }) async {
    if (_currentLocation == null) {
      _error = 'Location not available';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.createActivity(
        title: title,
        description: description,
        latitude: _currentLocation!['latitude']!,
        longitude: _currentLocation!['longitude']!,
        imageFile: _selectedImage,
      );

      // Reload activities
      await loadActivities();

      // Clear image
      _selectedImage = null;

      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete activity
  Future<bool> deleteActivity(String id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _repository.deleteActivity(id);
      await loadActivities();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Search activities
  Future<void> searchActivities(String query) async {
    if (query.isEmpty) {
      await loadActivities();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _activities = await _repository.searchActivities(query);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get current location
  Future<void> fetchCurrentLocation() async {
    try {
      _currentLocation = await _repository.getCurrentLocation();
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Pick image from camera
  Future<void> pickImageFromCamera() async {
    try {
      _selectedImage = await _repository.captureImage(true);
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    try {
      _selectedImage = await _repository.captureImage(false);
      _error = null;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // Clear selected image
  void clearImage() {
    _selectedImage = null;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Check offline data
  Future<bool> hasOfflineData() async {
    return await _repository.hasOfflineData();
  }
}
import { v4 as uuidv4 } from 'uuid';
import { readData, writeData, deleteImage } from '../utils/fileHandler.js';

// Get all activities
export const getAllActivities = (req, res) => {
  try {
    const data = readData();
    res.json({ status: 'success', count: data.activities.length, data: data.activities });
  } 
  catch (error) {
    res.status(500).json({ status: 'error', message: 'Error fetching activities',error: error.message});
  }
};

// Get single activity
export const getActivityById = (req, res) => {
  try {
    const data = readData();
    const activity = data.activities.find(a => a.id === req.params.id);
    
    if (!activity) {
      return res.status(404).json({ status: 'error',message: 'Activity not found'});
    }
    
    res.json({ status: 'success',data: activity });
  } 
  catch (error) {
    res.status(500).json({ status: 'error',message: 'Error fetching activity',error: error.message});
  }
};

// Create new activity
export const createActivity = (req, res) => {
  try {
    const { title, description, latitude, longitude } = req.body;
    
    // Validation
    if (!title || !latitude || !longitude) {
      return res.status(400).json({ status: 'error',message: 'Title, latitude, and longitude are required'});
    }
    
    const data = readData();
    
    const newActivity = {
      id: uuidv4(),
      title: title,
      description: description || '',
      latitude: parseFloat(latitude),
      longitude: parseFloat(longitude),
      imageUrl: req.file ? `/uploads/${req.file.filename}` : null,
      timestamp: new Date().toISOString(),
      createdAt: new Date().toISOString()
    };
    
    data.activities.unshift(newActivity);
    writeData(data);
    
    res.status(201).json({ status: 'success',message: 'Activity created successfully',data: newActivity});
  } 
  catch (error) {
    res.status(500).json({ status: 'error', message: 'Error creating activity',error: error.message});
  }
};

// Update activity
export const updateActivity = (req, res) => {
  try {
    const data = readData();
    const index = data.activities.findIndex(a => a.id === req.params.id);
    
    if (index === -1) {
      return res.status(404).json({ status: 'error',message: 'Activity not found' });
    }
    
    const { title, description, latitude, longitude } = req.body;
    
    data.activities[index] = {
      ...data.activities[index],
      title: title || data.activities[index].title,
      description: description || data.activities[index].description,
      latitude: latitude ? parseFloat(latitude) : data.activities[index].latitude,
      longitude: longitude ? parseFloat(longitude) : data.activities[index].longitude,
      updatedAt: new Date().toISOString()
    };
    
    writeData(data);
    
    res.json({ status: 'success',message: 'Activity updated successfully',data: data.activities[index]});
  } 
  catch (error) 
  {
    res.status(500).json({ status: 'error',message: 'Error updating activity',error: error.message});
  }
};

// Delete activity
export const deleteActivity = (req, res) => {
  try {
    const data = readData();
    const index = data.activities.findIndex(a => a.id === req.params.id);
    
    if (index === -1) {
      return res.status(404).json({ status: 'error', message: 'Activity not found'});
    }
    
    // Delete image if exists
    const activity = data.activities[index];
    if (activity.imageUrl) {
      deleteImage(activity.imageUrl);
    }
    
    data.activities.splice(index, 1);
    writeData(data);
    
    res.json({ status: 'success',message: 'Activity deleted successfully'});
  } 
  catch (error) {
    res.status(500).json({ status: 'error',message: 'Error deleting activity',error: error.message });
  }
};

// Search activities
export const searchActivities = (req, res) => {
  try {
    const data = readData();
    const query = req.params.query.toLowerCase();
    
    const results = data.activities.filter(activity =>
      activity.title.toLowerCase().includes(query) ||
      (activity.description && activity.description.toLowerCase().includes(query))
    );
    
    res.json({ status: 'success',count: results.length,data: results});
  } 
  catch (error) {
    res.status(500).json({ status: 'error',message: 'Error searching activities',error: error.message});
  }
};
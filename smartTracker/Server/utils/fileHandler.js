import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const DATA_FILE = path.join(__dirname, '../data.json');

// Initialize data file if it doesn't exist
if (!fs.existsSync(DATA_FILE)) {
  fs.writeFileSync(DATA_FILE, JSON.stringify({ activities: [] }, null, 2));
}

// Read data from JSON file
export const readData = () => {
  try {
    const data = fs.readFileSync(DATA_FILE, 'utf8');
    return JSON.parse(data);
  } catch (error) {
    console.error('Error reading data:', error);
    return { activities: [] };
  }
};

// Write data to JSON file
export const writeData = (data) => {
  try {
    fs.writeFileSync(DATA_FILE, JSON.stringify(data, null, 2));
    return true;
  } catch (error) {
    console.error('Error writing data:', error);
    return false;
  }
};

// Delete image file
export const deleteImage = (imageUrl) => {
  try {
    if (imageUrl) {
      const imagePath = path.join(__dirname, '../', imageUrl);
      if (fs.existsSync(imagePath)) {
        fs.unlinkSync(imagePath);
        return true;
      }
    }
    return false;
  } catch (error) {
    console.error('Error deleting image:', error);
    return false;
  }
};
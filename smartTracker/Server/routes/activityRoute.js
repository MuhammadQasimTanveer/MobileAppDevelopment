import express from 'express';
import { upload } from '../config/multer.js';
import { getAllActivities, getActivityById, createActivity, updateActivity, deleteActivity,searchActivities}
  from '../controllers/activityController.js';

const router = express.Router();

router.get('/activities', getAllActivities);
router.get('/activities/search/:query', searchActivities);
router.get('/activities/:id', getActivityById);
router.post('/activities', upload.single('image'), createActivity);
router.put('/activities/:id', updateActivity);
router.delete('/activities/:id', deleteActivity);

export default router;
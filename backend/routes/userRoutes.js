const express = require('express');
const router = express.Router(); // Use router instead of UserRoutes

const UserController = require('../controller/userController');

// Define your routes using the router
router.post('/movies', UserController.sendData);
 // Use the appropriate route and controller method

 router.get('/category/:id', UserController.fetchAllMoviesByCategoriesId);
router.get('/movies', UserController.fetchData); 

// Export the router
module.exports = router;

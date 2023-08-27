
const express = require("express");
const categoryController = require("../controller/categortyController");

const categoryRoutes = express.Router();

// POST request to create a category
categoryRoutes.post("/", categoryController.createCategory);

// GET request to fetch a category by ID
categoryRoutes.get("/:id", categoryController.fetchCategoryById);

// GET request to fetch all categories
categoryRoutes.get("/", categoryController.fetchAllCategory);

module.exports = categoryRoutes;

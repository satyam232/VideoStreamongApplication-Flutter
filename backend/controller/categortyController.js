const CategoryModel = require("../users/category");

const categoryController = {
    createCategory: async function(req, res) {
        try {
            const categoryData = req.body;
            const newCategory = new CategoryModel(categoryData);
            await newCategory.save();

            return res.json({ success: true, data: newCategory, message: "Category created successfully" });
        } catch (ex) {
            return res.json({ success: false, message: ex.message });
        }
    },

    fetchAllCategory: async function(req, res) {
        try {
            const categories = await CategoryModel.find();

            return res.json({ success: true, data: categories });
        } catch (ex) {
            return res.json({ success: false, message: ex.message });
        }
    },

    fetchCategoryById: async function(req, res) {
        try {
            const id = req.params.id;
            const foundCategory = await CategoryModel.findById(id);

            if (!foundCategory) {
                return res.json({ success: false, message: "No such category found" });
            }

            return res.json({ success: true, data: foundCategory });
        } catch (ex) {
            return res.json({ success: false, message: ex.message });
        }
    }
};

module.exports = categoryController;

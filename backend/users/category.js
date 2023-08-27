const { Schema, model } = require("mongoose");

const categorySchema= new Schema({
    title:{type:String, required: true},
    description:{type:String,default:""},
    updatedOn:{type:Date},
    createdOn:{tupe:Date}

})

categorySchema.pre('save', async function (next) {
    this.updatedOn= new Date();
    this.createdOn=new Date();
    next();
});

categorySchema.pre(['updateOne', 'findOneAndUpdate'], function (next) {
    const update = this.getUpdate();
    delete update._id;
    this.updatedOn = new Date();
    next();
});

const CategoryModel = model('MovieCategory',categorySchema);

module.exports=CategoryModel
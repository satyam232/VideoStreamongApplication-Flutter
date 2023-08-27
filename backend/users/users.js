const { Schema, model } = require("mongoose");

const UserSchema = new Schema({
    category: { type: Schema.Types.ObjectId, ref: 'categories', required: true },
    movieurl: { type: String, required: true },
    image: { type: String, required: true },
    title: { type: String, required: true },
    description: { type: String, required: true }
});

const UserModel = model('movies', UserSchema);

module.exports = UserModel;

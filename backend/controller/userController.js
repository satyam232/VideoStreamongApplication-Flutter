const UserModel = require('../users/users');

const UserController = {
    sendData: async function (req, res) {
        try {
            const userData = req.body;
            const existing = await UserModel.findOne({ movieurl: userData.movieurl });
            if (existing) {
                return res.json({ success: false, message: "This movie is already present" }); 
            }
            const newUser = new UserModel(userData);
            const savedUser = await newUser.save();

            return res.json({ success: true, data: savedUser });

        } catch (ex) {
            return res.json({ success: false, message: ex }); 
        }
    },

    fetchData: async function(req,res){
        try{
            const allMovies= await UserModel.find();

            return res.json({data:allMovies})

        }
        catch(ex){
            return res.json({sucess:false,message:ex})
        }
    },

    fetchAllMoviesByCategoriesId: async function(req,res){
        try{
            const id=req.params.id;

            const product= await UserModel.find({category:id});

            return res.json({sucess:true,data:product})
        }
        catch(ex){
            return res.json({sucess:false,message:ex})
        }
    }
};

module.exports = UserController;

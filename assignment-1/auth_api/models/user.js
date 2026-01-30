const mongoose = require('mongoose');

const userSchema={
name: {
type: String,
required:true
},
username: {
type:String,
required:true,
unique:true
},
email:{
type: String,
required:true,
unique:true
},
password: {
type: String,
required:true
}
};
const user = new mongoose.model('User', userSchema);
module.exports = user;
var express = require("express");
var app = express();
var bodyParser = require("body-parser");
var mongoose = require("mongoose");

app.use(bodyParser.urlencoded({extended: true}));

//dbconnect
mongoose.connect("mongodb://localhost/userdb");
var userSchema = new mongoose.Schema({
	name: String,
	username: String,
	email: String,
	password: String,
	bday: Number,
	bmonth: Number,
	byear: Number,
	regdate: String
});
var User = mongoose.model("User", userSchema);


app.set("view engine", "ejs");



app.get("/", function(req,res){
	res.render("welcome");
});

app.get("/signup",function(req,res){
	res.render("signup");
});

app.post("/addUser", function(req,res){
	var name = req.body.fullname;
	var username = req.body.username;
	var email = req.body.email;
	var password = req.body.password;
	var bday = req.body.day;
	var bmonth = req.body.month;
	var byear = req.body.year; 
	var date = new Date();
	var insertuser = new User({
		name: name,
		username: username,
		email: email,
		password: password,
		bday: bday,
		bmonth: bmonth,
		byear: byear,
		regdate: date
	});
	insertuser.save(function(err, user){
		if(err){
			console.log("User wasn't inserted");
		} else{
			console.log("User was inserted in the database");
			console.log(user);
		}
	});
	res.redirect("/signin");
});

app.get("/signin", function(req,res){
	res.render("signin");
});

app.post("/checkCreds", function(req,res){
	var dbpass;
	var username = req.body.username;
	var password = req.body.password;
	console.log(username);
	console.log(password);
	User.findOne({ username: username }, function(err, user){
		if(err){
			console.log("Problem with database search");
		} 
		if(!user){
			console.log("No user found. Signup required");
			res.redirect("/signup");
		}
		else{
			console.log("password found!");
			console.log(user.password);
			dbpass = user.password;
			if(dbpass == password){
			res.redirect("/home/"+username);
			} else{
				console.log("password is incorrect. Please sign in again");
				res.redirect("/signin");
			}
		}
	});
});


app.get("/home/:name", function(req,res){
	var uname = req.params.name;
	var name, email, password, bday, bmonth, byear, regisdate;
	User.findOne({username: uname}, function(err, user){
		if(err){
			console.log("Fetching error. Please check if MongoDB is running or not.");
		}
		else{
			console.log("Data found!");
			name = user.name;
			email = user.email;
			password = user.password;
			bday = user.bday;
			bmonth = user.bmonth;
			byear = user.byear;
			regisdate = user.regdate;
			res.render("home", {name:name, uname:uname, email:email, pass:password, bday:bday, bmonth:bmonth, byear:byear, regdate:regisdate});
		}
	});
});

app.listen(3000, function(){
	console.log("Server has started!");
});
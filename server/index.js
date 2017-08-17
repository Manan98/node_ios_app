var http = require('http'),
    express = require('express'),
    MongoClient = require('mongodb').MongoClient,
    Server = require('mongodb').Server,
    nodemailer = require('nodemailer'),
    mongo = require('mongodb');


var url = "mongodb://localhost:27017/lunchapp";

var app=express()
var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

app.post('/forgot_password', function (req, res) {
  var transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: '...@gmail.com',
    pass: ''
  }
});

var mailOptions = {
  from: '...@gmail.com',
  to: req.body.email,
  subject: 'Your new password',
  text: 'Hi, \n \nThis is your new temporary password: ...'+ 
  'Please login with this password and then change it in your '+
  'profile section in the app.\n \nThank you.'
};

transporter.sendMail(mailOptions, function(error, info){
  if (error) {
    console.log(error);
  } else {
    console.log('Email sent: ' + info.response);
  }
});
})

app.post('/login', function (req, res) {

  if (req.body.password=='hello') res.status(200).send({body:"Hi"});
})

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})


app.post('/signup', function (req, res) {


	var record = {'name' : req.body.name,
			  'email' : req.body.email,
			  'password' : encrypt(req.body.password)
			  };
  	console.log(record)
	MongoClient.connect(url, function(err, db) {
  	if (err) throw err;
  	db.collection("users").insertOne(record, function(err, res) {
    if (err) throw err;
    console.log("1 document inserted");
    db.close();
  });
});
})


// Nodejs encryption with CTR
var crypto = require('crypto'),
    algorithm = 'aes-256-ctr',
    password = 'd6F3Efeq';

function encrypt(text){
  var cipher = crypto.createCipher(algorithm,password)
  var crypted = cipher.update(text,'utf8','hex')
  crypted += cipher.final('hex');
  return crypted;
}
 
function decrypt(text){
  var decipher = crypto.createDecipher(algorithm,password)
  var dec = decipher.update(text,'hex','utf8')
  dec += decipher.final('utf8');
  return dec;
}
 
var hw = encrypt("hello world")


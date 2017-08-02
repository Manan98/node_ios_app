var http = require('http'),
    express = require('express'),
    MongoClient = require('mongodb').MongoClient,
    Server = require('mongodb').Server,
    nodemailer = require('nodemailer');

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
  console.log(req.body.email)
  console.log(req.body.password)
})

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})

var http = require('http'),
    express = require('express'),
    MongoClient = require('mongodb').MongoClient,
    Server = require('mongodb').Server;

var app=express()
var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({
    extended: true
}));

/**bodyParser.json(options)
 * Parses the text as JSON and exposes the resulting object on req.body.
 */
app.use(bodyParser.json());
app.post('/login', function (req, res) {
  console.log(req.body.email)
  console.log(req.body.password)
})

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})

var express = require("express")
var app = express()
var stds = []
const { MongoClient, ObjectId } = require("mongodb")

var url = "mongodb://127.0.0.1:27017"

app.use(express.urlencoded({ extended: true }))
app.use(express.json())

app.set('view engine', 'pug');
app.set('views', './views');



app.get("/", function (req, res) {
    res.sendFile(__dirname + "/regmongohtml.html")
})

//insert in postman
app.post("/sturegmongo", function (req, res) {
    MongoClient.connect(url, function (err, conn) {
        var db = conn.db("delta")
        // db.collection("students").find().toArray(function(req,data){
        db.collection("students").insertOne(req.body, function (err, data) {
            res.send(data)
            // res.send(req.body)
        })
    })
})

//view in postman
app.get("/render", function (req, res) {
    MongoClient.connect(url, function (err, conn) {
        var db = conn.db("delta")
        db.collection("students").find().toArray(function (req, data) {
            // res.render("regmongopug", { allstuds1: data })
            // res.send(data[0].weightEntry.weight)
            res.send(data)
        })
    })
})

//delete in postman
app.get("/delete/:id", function (req, res) {
    MongoClient.connect(url, function (err, conn) {
        var db = conn.db("delta")
        db.collection("students").deleteOne({ _id: ObjectId(req.params.id) }, function (err, data) {
            // res.render("regmongopug",{allstuds1:data})
            res.redirect("/render")
            // res.send(data)
        })
    })
})

app.get("/weight/:id", function (req, res) {
    res.render("editweight", { id: req.params.id })
})
app.post("/weightedit", function (req, res) {
    MongoClient.connect(url, function (err, conn) {
        console.log(req.body)
        var db = conn.db("delta");
        db.collection("students")
            .updateOne(
                { _id: ObjectId(req.body.id) },
                {
                    $set: {
                        fname: req.body.fname,
                        lname: req.body.lname,
                        age:req.body.age
                    }
                    // $set: {
                    //     weightEntry: {
                    //         date: req.body.date,
                    //         weight: req.body.addweight
                    //     }
                    // }
                },
                function (err, data) {
                    console.log(data)
                    // res.redirect("/render")
                    res.send(data)
                }
            )
    })
})

app.listen(8080, function (req, res) {
    console.log("listening on 8080")
})
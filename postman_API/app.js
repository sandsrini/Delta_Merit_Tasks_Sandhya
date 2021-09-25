var express = require("express")
var app = express()
// var stds = []
const { MongoClient, ObjectId } = require("mongodb")

var url = "mongodb://127.0.0.1:27017"

app.use(express.urlencoded({ extended: true }))
app.use(express.json())

app.get("/", function (req, res) {
    res.sendFile(__dirname + "/regmongohtml.html")
})

app.post("/sturegmongo", function (req, res) {
    MongoClient.connect(url, function (err, conn) {
        var db = conn.db("delta")
        // db.collection("students").find().toArray(function(req,data){
        db.collection("irctc").insertOne(req.body, function (err, data) {
            res.send(data)
            // res.send(req.body)
        })
    })
})

app.get("/render", function (req, res) {
    MongoClient.connect(url, function (err, conn) {
        var db = conn.db("delta")
        db.collection("irctc").find().toArray(function (req, data) {
            // res.render("regmongopug", { allstuds1: data })
            // res.send(data[0].weightEntry.weight)
            res.send(data)
        })
    })
})

app.get("/delete/:id", function (req, res) {
    MongoClient.connect(url, function (err, conn) {
        var db = conn.db("delta")
        db.collection("irctc").deleteOne({ _id: ObjectId(req.params.id) }, function (err, data) {
            // res.render("regmongopug",{allstuds1:data})
            // res.redirect("/render")
            res.send(data)
            console.log(data)
        })
    })
})

app.get("/update/:id", function (req, res) {
    // res.render("editweight", { id: req.params.id })
    id: req.params.id
})

app.post("/updateform", function (req, res) {
    MongoClient.connect(url, function (err, conn) {
        console.log(req.body)
        var db = conn.db("delta");
        db.collection("irctc")
            .updateOne(
                { _id: ObjectId(req.body.id) },
                {
                    $set: {
                        freight_name: req.body.freight_name,
                    freight_type: req.body.freight_type,
                    origin:req.body.origin,
                    destination:req.body.destination,
                    departure:req.body.departure,
                    arrival:req.body.arrival
                    }
                    // $push:
                    // {freight:{
                    // freight_type:req.body.freight_type
                    // }
                    // }
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
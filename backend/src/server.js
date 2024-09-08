const express = require("express");
const app = express();
const morgan = require("morgan");
const nocache = require("nocache");
const cors = require("cors");

app.use(cors());
app.use(nocache());
app.use(morgan("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/", require("./controllers/profile/controller"));

//start server
app.listen(3000, () => {
  console.log(`Listening on port 3000`);
});

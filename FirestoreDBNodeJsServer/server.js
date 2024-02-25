const express = require("express");
const app = express();
const http = require("http");
const cors = require("cors");
const bodyParser = require('body-parser');
const dotenv = require('dotenv')
const jwt = require('jsonwebtoken')
//APP
dotenv.config()
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(express.json());
app.use(express.static("public"));
app.set("view engine", "ejs");


const corsOptions = {
  origin: '*',
  methods: ['GET', 'POST'],
  optionsSuccessStatus: 204, // For preflight requests
};

app.use(cors(corsOptions));
//Importing Database
const admin = require("firebase-admin");
const db = require("./db");
//ROUTING
const loginRouter = require("./Routers/LoginRoutes");
const appRouter = require("./Routers/AppRoutes");
const CommerceNearMeRouter = require("./Routers/CommerceNearMeRoutes");
const CommerceRequestRouter = require("./Routers/CommerceRequestRoutes");
const RegisterRouter = require("./Routers/RegisterRoutes");
const VendorRouter = require("./Routers/VendorRoutes");
const UserStoreRouter = require("./Routers/UserStoreRoutes");
const UnMappedRouter = require("./Routers/UnMappedRoutes");

//API ROUTESS
app.use("/loginRouter", loginRouter);
app.use("/appRouter", appRouter);
app.use("/CommerceNearMeRouter",CommerceNearMeRouter);
app.use("/CommerceRequestRouter",CommerceRequestRouter);
app.use("/RegisterRouter",RegisterRouter);
app.use("/VendorRouter",VendorRouter);
app.use("/UserStoreRouter", UserStoreRouter);
app.use("/UnMappedRouter", UnMappedRouter);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server started at ${PORT}`));
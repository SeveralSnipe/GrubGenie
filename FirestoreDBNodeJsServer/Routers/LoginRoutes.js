const bcrypt = require("bcrypt");
const express = require("express");
const bodyParser = require("body-parser");
const jwt = require("jsonwebtoken"); // Import JWT library
const LoginRouter = express.Router();
require("dotenv").config();

const { auth, db, admin } = require("../db");
LoginRouter.use(bodyParser.json());

LoginRouter.post("/loginUser", async (req, res) => {
  try {
    const { Identifier, Password } = req.body;
    let querySnapshot;
    if (Identifier.includes("@")) {
      querySnapshot = await db
        .collection("UserDetails")
        .where("Email", "==", Identifier)
        .get();
    } else {
      querySnapshot = await db
        .collection("UserDetails")
        .where("UserId", "==", Identifier)
        .get();
    }
    if (querySnapshot.empty) {
      return res.status(404).json({ error: "User not found" });
    }
    const userData = querySnapshot.docs[0].data();
    console.log(userData.password, Password);
    const passwordMatch = await bcrypt.compare(Password, userData.password);
    if (!passwordMatch) {
      return res.status(401).json({ error: "Invalid credentials" });
    }
    const token = jwt.sign(
      { userId: userData.UserId },
      process.env.JWT_SECRET,
      { expiresIn: "12h" }
    );
    res
      .status(200)
      .json({ message: "success", token: token, userId: userData.UserId });
  } catch (error) {
    console.error("Error authenticating user:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

LoginRouter.post("/loginStore", async (req, res) => {
  try {
    const { Identifier, Password } = req.body;
    let querySnapshot;
    if (Identifier.includes("@")) {
      querySnapshot = await db
        .collection("StoreDetails")
        .where("Email", "==", Identifier)
        .get();
    } else {
      querySnapshot = await db
        .collection("StoreDetails")
        .where("StoreDetails", "==", Identifier)
        .get();
    }
    if (querySnapshot.empty) {
      return res.status(404).json({ error: "User not found" });
    }
    const StoreData = querySnapshot.docs[0].data();
    console.log(StoreData.password, Password);
    const passwordMatch = await bcrypt.compare(Password, StoreData.password);
    if (!passwordMatch) {
      return res.status(401).json({ error: "Invalid credentials" });
    }
    const token = jwt.sign(
      { StoreId: StoreData.StoreId },
      process.env.JWT_SECRET,
      { expiresIn: "12h" }
    );
    res
      .status(200)
      .json({ message: "success", token: token, StoreId: StoreData.StoreId });
  } catch (error) {
    console.error("Error authenticating user:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
module.exports = LoginRouter;

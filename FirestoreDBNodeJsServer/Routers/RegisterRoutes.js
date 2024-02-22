const express = require("express");
const bodyParser = require("body-parser");
const RegisterRouter = express.Router();
const { auth, db, admin } = require("../db");
const { haversine,generateRandomString,validateEmail } = require("../helper");
const bcrypt = require('bcrypt');

RegisterRouter.use(bodyParser.json());


//register StoreDetails
RegisterRouter.post("/registerStore", async (req, res) => {
    try {
        const body = req.body;
        const GST = body.GST; 
        const Location = body.Location;
        const PhoneNumber = body.PhoneNumber || null; 
        const StoreName = body.StoreName;
        const Email = validateEmail(body.Email) ? body.Email : null;
        const StoreId = 'SI' + generateRandomString(10); 
        const geoPoint = new admin.firestore.GeoPoint(Location[0], Location[1]);
        const RegisterRef = db.collection('StoreDetails').doc(StoreId); // Reference to the document
        const data = {
          StoreId: StoreId,
          StoreName: StoreName,
          GST: GST,
          Email: Email,
          Location: geoPoint,
          PhoneNumber: PhoneNumber
        };
        await RegisterRef.set(data);
        res.status(200).json({ message: "success" , StoreId : StoreId});
    } catch (error) {
      console.error("Error authenticating user:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
});


RegisterRouter.post("/registerUser", async (req, res) => {
    try {
        const body = req.body;
        const DOB = body.DOB || null;
        const PhoneNumber = body.PhoneNumber; 
        const UserName = body.UserName ;
        const Email = validateEmail(body.Email) ? body.Email : null;
        const UserId = 'UI' + generateRandomString(10); 
        const UserRef = db.collection('UserDetails').doc(UserId); // Reference to the document
        const password = body.Password;
        const hashedPassword = await bcrypt.hash(password, 10);
        const data = {
          UserId: UserId,
          UserName: UserName,
          DOB: DOB,
          Email: Email,
          PhoneNumber: PhoneNumber,
          password: hashedPassword
        };
        await UserRef.set(data);
        res.status(200).json({ message: "success" , UserId: UserId });
    } catch (error) {
      console.error("Error authenticating user:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
});



module.exports = RegisterRouter;
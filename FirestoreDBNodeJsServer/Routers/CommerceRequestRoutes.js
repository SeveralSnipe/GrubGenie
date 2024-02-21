const express = require("express");
const bodyParser = require("body-parser");
const CommerceRequestRouter = express.Router();
const { auth, db, admin } = require("../db");
const { haversine,generateRandomString,validateEmail } = require("../helper");
CommerceRequestRouter.use(bodyParser.json());

CommerceRequestRouter.post("/requestItem", async (req, res) => {
    try {
        const requestData = req.body;
        const requestId = 'RQ' + generateRandomString(10); // Generate request ID
        const requestRef = db.collection('RequestDetails').doc(requestId); // Reference to the document
        console.log(requestData);
        const Location = requestData.Location;
        const geoPoint = new admin.firestore.GeoPoint(Location[0], Location[1]);
        const data = {
          RequestId: requestId,
          UserId: requestData.UserId,
          Location : geoPoint,
          Orders: requestData.Orders,
          CostPrice: requestData.CostPrice,
          DiscountPrice: requestData.DiscountPrice || 0,
          Status: 'Pending',
          AdditionalNotes: [requestData.AdditionalNotes] || []
        };
        await requestRef.set(data);
        console.log('Request saved successfully with ID:', requestId);
        res.status(200).json({ message: "Request saved successfully." , requestId :requestId });
      } catch (error) {
      console.error("Error saving request:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  });
//PATCH
  CommerceRequestRouter.patch("/requestItem/:requestId", async (req, res) => {
    try {
      const requestId = req.params.requestId;
      const requestData = req.body;
      const requestRef = db.collection('RequestDetails').doc(requestId);
      const snapshot = await requestRef.get();
      if (!snapshot.exists) {
        return res.status(404).json({ error: "Request not found." });
      }
      const AdditionalNotes = snapshot.data().AdditionalNotes || [];
      const newAdditionalNotes = requestData.AdditionalNotes || null;
      if(newAdditionalNotes) AdditionalNotes.push(newAdditionalNotes)
      const dataToUpdate = {
        Status: requestData.Status || snapshot.data().Status,
        DiscountPrice: requestData.DiscountPrice || snapshot.data().DiscountPrice,
        AdditionalNotes: AdditionalNotes
      };
      await requestRef.update(dataToUpdate);
      console.log('Request updated successfully with ID:', requestId);
      res.status(200).json({ message: "Request updated successfully.", requestId: requestId });
    } catch (error) {
      console.error("Error updating request:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  });


  module.exports=CommerceRequestRouter
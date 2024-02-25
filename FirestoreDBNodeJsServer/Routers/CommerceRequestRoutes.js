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

  CommerceRequestRouter.get("/requestStore/:storeid", async (req, res) => {
    try {
        // Retrieve the storeid from the request parameters
        const storeid = req.params.storeid;

        // Query the database to get the details of the request for the given storeid
        const querySnapshot = await db.collection('RequestDetails')
            .where(`Orders.${storeid}`, '!=', null) // Assuming 'Orders' is the field containing store details
            .get();

        // Extract the details from the query snapshot
        const requestDetails = [];
        querySnapshot.forEach(doc => {
            // Assuming each document contains the details of a request
            const requestData = doc.data();
            requestDetails.push(requestData);
        });

        // Send the response with the details of the request for the given storeid
        res.status(200).json({ result: requestDetails });
    } catch (error) {
        // Handle errors
        console.error("Error retrieving request details:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

CommerceRequestRouter.get("/requestUser/:userid", async (req, res) => {
  try {
      // Retrieve the userid from the request parameters
      const userid = req.params.userid;

      // Query the database to get the details of the request for the given userid
      const querySnapshot = await db.collection('RequestDetails')
          .where('UserId', '==', userid) // Assuming 'UserId' is the field containing the user identifier
          .get();

      // Extract the details from the query snapshot
      const requestDetails = [];
      querySnapshot.forEach(doc => {
          // Assuming each document contains the details of a request
          const requestData = doc.data();
          requestDetails.push(requestData);
      });

      // Send the response with the details of the request for the given userid
      res.status(200).json({ result: requestDetails });
  } catch (error) {
      // Handle errors
      console.error("Error retrieving request details:", error);
      res.status(500).json({ error: "Internal Server Error" });
  }
});



  module.exports=CommerceRequestRouter
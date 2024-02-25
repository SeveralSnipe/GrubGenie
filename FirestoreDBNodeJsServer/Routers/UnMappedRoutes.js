const express = require("express");
const bodyParser = require("body-parser");
const UnMappedRouter = express.Router();
const { auth, db, admin } = require("../db");
const { haversine,generateRandomString,validateEmail } = require("../helper");
UnMappedRouter.use(bodyParser.json());

//Add To UnmappedItemDetails Collection

UnMappedRouter.post("/UMRequest", async (req, res) => {
    try {
        const requestData = req.body;
        const requestId = 'URQ' + generateRandomString(10); // Generate request ID
        const itemId = 'UIT' + generateRandomString(10);
        const requestRef = db.collection('UMReqs').doc(requestId); // Reference to the document
        const Location = requestData.Location;
        const geoPoint = new admin.firestore.GeoPoint(Location[0], Location[1]);
        const data = {
          RequestId: requestId,
          UserId: requestData.UserId,
          Location : geoPoint,
          Item: {
            ItemId : itemId,
            ItemName:requestData.Item.ItemName,
            Quantity:requestData.Item.ItemQuantity
          },
          PreferedPrice: requestData.PreferedPrice,
          AgreedPrice: requestData.AgreedPrice || 0,
          Status: 'Not Claimed',
          AdditionalNotes: [requestData.AdditionalNotes] || []
        };
        console.log(data)
        await requestRef.set(data);
        console.log('Request saved successfully with ID:', requestId);
        res.status(200).json({ message: "Request saved successfully." , requestId :requestId });
      } catch (error) {
      console.error("Error saving request:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
});

UnMappedRouter.patch("/updateUMItem/:itemId", async (req, res) => {
    try {
        const itemId = req.params.itemId;
        const body = req.body;
        // Constructing a query to find the document with the nested ItemId
        const ItemRef = db.collection('UMReqs').where(`Item.ItemId`, '==', itemId);
        const querySnapshot = await ItemRef.get();
        
        if (querySnapshot.empty) {
            return res.status(404).json({ error: "Item not found" });
        }
        
        // Assuming there's only one document matching the itemId, otherwise, handle accordingly
        const docSnapshot = querySnapshot.docs[0];
        const itemSnapshot = docSnapshot.data();

        const updatedItem = {
            ...itemSnapshot.Item,
            ExpiryDate: body.ExpiryDate ? admin.firestore.Timestamp.fromDate(new Date(body.ExpiryDate)) : itemSnapshot.Item.ExpiryDate || admin.firestore.Timestamp.now(),
            Quantity: body.StockQuantity || itemSnapshot.Item.Quantity
        };

        const updateFields = {
            Item: updatedItem,
            AgreedPrice: body.AgreedPrice !== undefined ? body.AgreedPrice : itemSnapshot.AgreedPrice,
            Status: body.Status || itemSnapshot.Status,
            AdditionalNotes: body.AdditionalNotes !== undefined ? body.AdditionalNotes : itemSnapshot.AdditionalNotes,
            StoreId:body.StoreId
        };
        
        await docSnapshot.ref.update(updateFields);
        res.status(200).json({ message: "success" });
    } catch (error) {
        console.error("Error updating item:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

UnMappedRouter.get("/NotClaimedUMReqs", async (req, res) => {
    try {
        const snapshot = await db.collection('UMReqs').where('Status', '==', 'NotClaimed').get();

        if (snapshot.empty) {
            return res.status(404).json({ error: "No unclaimed items found" });
        }

        const notClaimedItems = [];
        snapshot.forEach(doc => {
            notClaimedItems.push(doc.data());
        });

        res.status(200).json({ result: notClaimedItems });
    } catch (error) {
        console.error("Error fetching unclaimed items:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

UnMappedRouter.get("/NotClaimedUMReqs/store/:storeId", async (req, res) => {
    try {
        const storeId = req.params.storeId;
        const snapshot = await db.collection('UMReqs').where('Status', '==', 'NotClaimed').where('StoreId', '==', storeId).get();

        if (snapshot.empty) {
            return res.status(404).json({ error: "No unclaimed items found for this store" });
        }

        const notClaimedItems = [];
        snapshot.forEach(doc => {
            notClaimedItems.push(doc.data());
        });

        res.status(200).json({ result: notClaimedItems });
    } catch (error) {
        console.error("Error fetching unclaimed items:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
});

UnMappedRouter.get("/NotClaimedUMReqs/user/:userId", async (req, res) => {
    try {
        const userId = req.params.userId;
        const snapshot = await db.collection('UMReqs').where('Status', '==', 'NotClaimed').where('UserId', '==', userId).get();

        if (snapshot.empty) {
            return res.status(404).json({ error: "No unclaimed items found for this user" });
        }

        const notClaimedItems = [];
        snapshot.forEach(doc => {
            notClaimedItems.push(doc.data());
        });

        res.status(200).json({ result: notClaimedItems });
    } catch (error) {
        console.error("Error fetching unclaimed items:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
});


module.exports = UnMappedRouter;
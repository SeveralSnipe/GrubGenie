const express = require("express");
const bodyParser = require("body-parser");
const VendorRouter = express.Router();
const { auth, db, admin } = require("../db");
const { haversine,generateRandomString,validateEmail } = require("../helper");
VendorRouter.use(bodyParser.json());


VendorRouter.post("/registerItem", async (req, res) => {
    try {
        const body = req.body;
        const ExpiryDates = body.ExpiryDate; 
        const ExpiryDate = admin.firestore.Timestamp.fromDate(new Date(ExpiryDates));
        const ItemMRP = body.ItemMRP;
        const ItemSP = body.ItemSP;
        const ItemName= body.ItemName;
        const StockQuantity = body.StockQuantity || 0;
        const StoreId = body.StoreId; 
        const ItemId = "IT"+generateRandomString(10);
        
        const ItemRef = db.collection('ItemDetails').doc(ItemId); // Reference to the document
        const data = {
          ItemId: ItemId,
          ItemName:ItemName,
          StoreId: StoreId,
          ExpiryDate: ExpiryDate,
          StockQuantity:StockQuantity,
          ItemMRP:ItemMRP,
          ItemSP :ItemSP 
        };
        await ItemRef.set(data);
        res.status(200).json({ message: "success" , ItemId:ItemId});
    } catch (error) {
      console.error("Error authenticating user:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
});

VendorRouter.patch("/updateItem/:itemId", async (req, res) => {
    try {
        const itemId = req.params.itemId;
        const body = req.body;
        const ItemRef = db.collection('ItemDetails').doc(itemId);
        const itemSnapshot = await ItemRef.get();
        const ExpiryDate = admin.firestore.Timestamp.fromDate(new Date(body.ExpiryDate));
        if (!itemSnapshot.exists) {
            return res.status(404).json({ error: "Item not found" });
        }
        const updateFields = {
            ItemName: body.ItemName || itemSnapshot.data().ItemName,
            ExpiryDate: ExpiryDate || itemSnapshot.data().ExpiryDate,
            StockQuantity: body.StockQuantity || itemSnapshot.data().StockQuantity ,
            ItemMRP: body.ItemMRP || itemSnapshot.data().ItemMRP,
            ItemSP: body.ItemSP || itemSnapshot.data().ItemSP,
        };
        await ItemRef.update(updateFields);
        res.status(200).json({ message: "success" });
    } catch (error) {
        console.error("Error updating item:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
});


module.exports = VendorRouter;
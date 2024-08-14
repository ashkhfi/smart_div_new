const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.scheduledDataProcessing = functions.pubsub
  .schedule("59 23 * * *")  
  .timeZone("Asia/Jakarta")
  .onRun(async (context) => {
    try {
      const collectionSensor = admin.firestore().collection("sensors");
      const collectionDaily = admin.firestore().collection("weekly_usage");

      const snapshot = await collectionSensor.limit(1).get();

      if (snapshot.empty) {
        console.log('No documents found.');
        return;
      }

      
      for (const doc of snapshot.docs) {
        const data = doc.data();

        const i_pln = parseFloat(data.i_pln);
        const v_inverter = parseFloat(data.v_inverter);
        const i_inverter = parseFloat(data.i_inverter);
        const v_pln = parseFloat(data.v_pln);

        const re_usage = (v_inverter * i_inverter) / 1000;
        const pln_usage = (v_pln * i_pln) / 1000;

        // Mendapatkan waktu saat ini
        const currentTime = new Date();

        const newData = {
          re_usage: re_usage,
          pln_usage: pln_usage,
          date: currentTime  
        };

        
        await collectionDaily.add(newData);
        console.log(`Data processed and added to weekly_usage: ${doc.id}`);
      }

      console.log("Function executed successfully.");
    } catch (error) {
      console.error("Error in scheduled data processing:", error);
    }
  });

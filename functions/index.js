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
        console.log("No documents found.");
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
          date: currentTime,
        };

        await collectionDaily.add(newData);
        console.log(`Data processed and added to weekly_usage: ${doc.id}`);
      }

      console.log("Function executed successfully.");
    } catch (error) {
      console.error("Error in scheduled data processing:", error);
    }
  });

exports.sendNotification = functions.firestore
  .document("sensors/device1") // Ganti dengan ID dokumen yang diinginkan
  .onUpdate(async (change, context) => {
    const newValue = change.after.data();
    const previousValue = change.before.data();
    console.log("Jalan Coy!");
    // Tindakan yang ingin dilakukan saat dokumen diperbarui
    const allFieldsZero =
      (newValue.i_inverter === "0.00" || newValue.i_inverter === " NAN") &&
      (newValue.v_inverter === "0.00" || newValue.v_inverter === " NAN") &&
      (newValue.i_pln === "0.00" || newValue.i_pln === " NAN") &&
      (newValue.v_pln === "0.00" || newValue.v_pln === " NAN");
      
    if (allFieldsZero) {
      const payload = {
        notification: {
          title: "Daya Mati",
          body: "Tidak ada supply daya masuk, cek ke lokasi sekarang",
        },
        topic: "power_status", // Pastikan ini sesuai dengan format yang benar di v1 API
      };

      try {
        console.log("OTW kirim coy!");
        const response = await admin.messaging().send(payload);
        console.log("FCM Response:", response);

        if (response.successCount > 0) {
          console.log(
            `${response.successCount} messages were sent successfully`
          );
        } else {
          console.log("No messages were sent successfully");
        }

        if (response.failureCount > 0) {
          const failedTokens = [];
          response.responses.forEach((resp, idx) => {
            if (!resp.success) {
              failedTokens.push(tokens[idx]);
            }
          });
          console.log("List of tokens that caused failures: " + failedTokens);
        }
      } catch (error) {
        console.error("Error sending notification: ", error);
      }
    }

    return null;
  });

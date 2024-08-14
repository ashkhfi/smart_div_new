const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.scheduledDataProcessing = functions.pubsub.schedule('every day 23:59').onRun(async (context) => {
  try {
    const collectionOneRef = admin.firestore().collection('collection_one');
    const collectionTwoRef = admin.firestore().collection('collection_two');

    const snapshot = await collectionOneRef.get();

    snapshot.forEach(async (doc) => {
      const data = doc.data();

      // Ambil 2 field dari dokumen
      const field1 = data.field1; // Gantilah dengan nama field yang sesuai
      const field2 = data.field2; // Gantilah dengan nama field yang sesuai

      // Periksa apakah field1 dan field2 ada dan merupakan angka
      if (typeof field1 === 'number' && typeof field2 === 'number') {
        // Lakukan operasi perkalian
        const result = field1 * field2;

        // Siapkan data untuk ditambahkan ke collection_two
        const newData = {
          result: result,
          originalField1: field1,
          originalField2: field2,
        };

        // Tambahkan data ke collection_two
        await collectionTwoRef.add(newData);
        console.log(`Data processed and added to collection_two: ${doc.id}`);
      } else {
        console.log(`Skipping document ${doc.id} due to invalid field types.`);
      }
    });

    console.log('Function executed successfully.');
  } catch (error) {
    console.error('Error in scheduled data processing:', error);
  }
});

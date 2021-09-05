const functions = require('firebase-functions');

module.exports.modifyUser = functions.firestore
    .document('users/{userID}')
    .onWrite((change, context) => {
      
      const document = change.after.exists ? change.after.data() : null;

      
      const oldDocument = change.before.data();

      console.log(document);
      console.log(oldDocument);
    });


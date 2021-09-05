const functions = require('firebase-functions');

module.exports = functions.firestore.document(`users/{userId}`).onUpdate(
     (snap,context) => {
          const newValue = change.after.data();
          const previousValue = change.before.data();
          const name = newValue.name;
          const email = newValue.email;
          console.log(name);
          console.log(email);
    });

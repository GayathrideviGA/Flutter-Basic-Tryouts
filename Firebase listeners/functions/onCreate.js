const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.onCreateUser = functions.firestore.document('users/{userId}').onCreate(
  async (snapshot, context) => {
    const users = snapshot.data();
    const name = users.name;
    const email = users.email;
    console.log(name);
    console.log(email);
  }
);

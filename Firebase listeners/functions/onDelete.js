const functions = require('firebase-functions');

module.exports = functions.firestore.document(`users/{userId}`).onDelete(
     (snap,context) => {
    
        const deletedValue = snap.data();
        const name = deletedValue.name;
        const email = deletedValue.email;
        console.log(name);
        console.log(email);  
    });

const functions = require('firebase-functions');
const express = require('express');
const admin = require('firebase-admin');
const cors = require('cors');
const { Firestore } = require('@google-cloud/firestore');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
admin.initializeApp();
const db = new Firestore();
const app = express();


app.use(cors({ origin: true }));
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.post('/createUser', async (req, res) => {
  try {
    const { name,email } = req.body;
    await db.collection('users').doc().set({
      name,
      email,
    })
    res.send('ok');
  } catch (error) {
    console.log(error);
    res.send('error');
  }
});

app.get('/:name', async(req, res) => {
  try{
    const {name} = req.params;
    const user = (await db.collection('users').where('name', '==', name).get()).docs;
    res.send(user);
  }catch(e){
    res.send('error');
  }
});

app.get('/deleteUser', (req, res) => {
  try{
    const {name} = req.params;
    const isDeleted = (await db.collection('user').where('name','==',name).get()).docs.delete();
    if(isDeleted){
        return res.send({
            hasError: false,
            message: 'successfully deleted'
        });
    } else {
        res.status(412);
        return next(Error('user not found'));
    }
}catch (e) {
    res.status(500);
    return next(e);
}
}
);

app.post('/updateUser', (req, res) => 
{
  const {name} =req.params;
  const users = db.collection('users').where('name', '==', name).get();
  let batch = db.batch();
  users.forEach((user) => {
    const docRef = db.collection('users').doc();
    batch.update(docRef, { name});
  });
  batch.commit();
  res.send('Updated user');
  return true;
});

exports.httpTrig = functions.https.onRequest(app);

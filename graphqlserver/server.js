var express = require('express');
var express_graphql = require('express-graphql');
var { buildSchema } = require('graphql');
// GraphQL schema
var schema = buildSchema(`
    type Query {
     continents:[Continent]
    }
    type Continent {
        id:ID!
        name:String 
     }
`);

// Root resolver
var root = {
    continents: () => [
        { id: 1, name: "Asia"},
        { id: 2, name: "Europe"},
        { id: 3, name: "North America"},
        { id: 4, name: "Antartica"},
        { id: 5, name: "South America"},
        { id: 6, name: "Oceania"},
        { id: 7, name: "Australia"}
      ],
};
// Create an express server and a GraphQL endpoint
var app = express();
app.use('/graphql', express_graphql({
    schema: schema,
    rootValue: root,
    graphiql: true
}));
app.listen(4000, () => console.log('Express GraphQL Server Now Running On localhost:4000/graphql'));

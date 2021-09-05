import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


void main() {
  runApp(MaterialApp(title: "GQL App", home: MyApp()));
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
        uri:
            "http://localhost:4000/graphql");
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: OptimisticCache(
          dataIdFromObject: typenameDataIdFromObject,
        ),
      ),
    );
    return GraphQLProvider(
      child: HomePage(),
      client: client,
    );
  }
}


class HomePage extends StatelessWidget {
  final String query = '''
                    query{
                      continent{
                        id
                        name
                      }
                    }
                  ''';

  

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text("GraphlQL Client"),
      ),
      body: 
      // Query(
      //   builder: (QueryResult result,{ VoidCallback refetch, FetchMore fetchMore }){
      //     return Container();
      //   }, options: null,
      // ),

      Query(
  options: QueryOptions(
    documentNode: gql(query), // this is the query string you just created
    pollInterval: 10,
  ),
  // Just like in apollo refetch() could be used to manually trigger a refetch
  // while fetchMore() can be used for pagination purpose
  builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
    if (result.hasException) {
        return Text(result.exception.toString());
    }

    if (result.loading) {
      return Text('Loading');
    }

    // it can be either Map or List
    List repositories = result.data;
    print(repositories);

    return ListView.builder(
      itemCount: repositories.length,
      itemBuilder: (context, index) {
        final repository = repositories[index];

        return Text(repository['name']);
    });
  },
)
    )
    ;
  }
}

// // import 'package:flutter/material.dart';
// // import 'package:graphql_flutter/graphql_flutter.dart';

// // class CommentProvider with ChangeNotifier {
// //   late final GraphQLClient _client;
// //   late final String _contestId;
// //   bool _isLoading = false;
// //   String? _error;
// //   List<dynamic> _comments = [];

// //   CommentProvider() {
// //     _client = GraphQLClient(
// //       link: HttpLink('https://contest-api.100pay.co/graphql'),
// //       cache: GraphQLCache(),
// //     );
// //     _contestId = '660305fc04c515f43a9d2e13';
// //     _fetchComments();
// //   }

// //   bool get isLoading => _isLoading;
// //   bool get hasError => _error != null;
// //   String? get error => _error;
// //   List<dynamic> get comments => _comments;

// //   Future<void> _fetchComments() async {
// //     try {
// //       _isLoading = true;
// //       final String gqlQuery = '''
// //         query ExampleQuery(\$contestId: ID!) {
// //           comment(contestId: \$contestId) {
// //             userName
// //             msg
// //           }
// //         }
// //       ''';

// //       final QueryOptions options = QueryOptions(
// //         document: gql(gqlQuery),
// //         variables: {'contestId': _contestId},
// //       );

// //       final QueryResult result = await _client.query(options);

// //       if (result.hasException) {
// //         _error = result.exception.toString();
// //       } else {
// //         _comments = result.data?['comment'] ?? [];
// //       }
// //     } catch (e) {
// //       _error = e.toString();
// //     } finally {
// //       _isLoading = false;
// //       notifyListeners();
// //     }
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// class CommentProvider with ChangeNotifier {
//   late final GraphQLClient _client;
//   late String _contestId;
//   bool _isLoading = false;
//   String? _error;
//   List<dynamic> _comments = [];

//   CommentProvider(String contestId) {
//     _client = GraphQLClient(
//       link: HttpLink('https://contest-api.100pay.co/graphql'),
//       cache: GraphQLCache(),
//     );
//     _contestId = contestId;
//     _fetchComments();
//   }

//   bool get isLoading => _isLoading;
//   bool get hasError => _error != null;
//   String? get error => _error;
//   List<dynamic> get comments => _comments;

//   Future<void> _fetchComments() async {
//     try {
//       _isLoading = true;
//       final String gqlQuery = '''
//         query ExampleQuery(\$contestId: ID!) {
//           comment(contestId: \$contestId) {
//             userName
//             msg
//           }
//         }
//       ''';

//       final QueryOptions options = QueryOptions(
//         document: gql(gqlQuery),
//         variables: {'contestId': _contestId},
//       );

//       final QueryResult result = await _client.query(options);

//       if (result.hasException) {
//         _error = result.exception.toString();
//       } else {
//         _comments = result.data?['comment'] ?? [];
//       }
//     } catch (e) {
//       _error = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }

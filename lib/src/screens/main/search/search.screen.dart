// import 'package:contest_app/src/providers/search.modal.dart';
// import 'package:contest_app/src/screens/user_varients/product_details.dart';
// import 'package:contest_app/src/src.dart';
// import 'package:flutter/cupertino.dart';

// // import 'package:contest_app/providers/search_provider.dart';

// class SearchScreen extends StatefulWidget {
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String currencySymbol = '';
//   String? currency;
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchCurrencyData();

//     final searchProvider = Provider.of<SearchProvider>(context, listen: false);
//     // final searchProvider = Provider.of<SearchProvider>(context, listen: false);
//     // final TextEditingController _searchController = TextEditingController();
//     _searchController.addListener(() {
//       searchProvider.search(_searchController.text);
//     });
//   }

//   Future<void> _fetchCurrencyData() async {
//     // Fetch currency data asynchronously
//     // UserData userData = await getUserDataFromPrefs();
//     SharedPreferences sf = await SharedPreferences.getInstance();
//     String savedcurrency = sf.getString('currency') ?? '';
//     currencySymbol = getCurrencySymbol(savedcurrency);
//     setState(() {}); // Update UI when currency data is available
//   }

//   String getCurrencySymbol(String? currency) {
//     if (currency != null && currencies.containsKey(currency)) {
//       return currencies[currency]!;
//     } else {
//       return ''; // Return empty string if currency not found
//     }
//   }

//   String formatTimeRemaining(DateTime startTime) {
//     Duration remainingTime = startTime.difference(DateTime.now());

//     int days = remainingTime.inDays;
//     int hours = remainingTime.inHours.remainder(24);
//     int minutes = remainingTime.inMinutes.remainder(60);
//     int seconds = remainingTime.inSeconds.remainder(60);

//     if (days > 0) {
//       return '${days}: ${hours}: ${minutes}: ${seconds}';
//     } else if (hours > 0) {
//       return '${days}: ${hours}: ${minutes}: ${seconds}';
//     } else if (minutes > 0) {
//       return '${days}: ${hours}: ${minutes}: ${seconds}';
//     } else if (seconds <= 0) {
//       return '${0}: ${0}: ${0}: ${0}';
//     } else {
//       return '';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: TextFormField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   suffixIcon: Platform.isIOS
//                       ? CupertinoPicker(
//                           backgroundColor: Colors.white,
//                           itemExtent: 32.0,
//                           onSelectedItemChanged: (int index) {
//                             // Handle item selection
//                           },
//                           children: <Widget>[
//                             // Add your picker items here
//                             Text('Electronics'),
//                             Text('Gadgets'),
//                             Text('Clothing'),
//                             Text('Food'),
//                           ],
//                         )
//                       : DropdownButton<String>(
//                           dropdownColor: Colors.white,
//                           // Add your dropdown items here
//                           items: <String>[
//                             'Electronics',
//                             'Gadgets',
//                             'Clothing',
//                             'Food',
//                           ].map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                           onChanged: (String? value) {
//                             // Handle dropdown item selection
//                           },
//                           // Add any additional properties you need for DropdownButton
//                         ),
//                   filled: true,
//                   fillColor: const Color(0xffF9FAFB),
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: AppColor.gray9,
//                   ),
//                   border: InputBorder.none,
//                   isDense: true,
//                   hintText: 'Search by product ID, Merchant name',
//                   hintStyle: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: AppColor.gray4,
//                   ),
//                   contentPadding: const EdgeInsets.only(
//                     top: 15,
//                     bottom: 10,
//                     left: 10,
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(
//                       color: Color(0xffF9FAFB),
//                       width: 1,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(
//                       color: Color(0xffF9FAFB),
//                       width: 1,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Consumer<SearchProvider>(
//                 builder: (context, searchProvider, _) {
//                   if (searchProvider.isLoading) {
//                     return Center(
//                         child: SpinKitFadingCircle(
//                       color: Colors.red,
//                       size: 50,
//                     ));
//                   } else if (searchProvider.searchResults.isEmpty) {
//                     return Center(child: Text('No results found.'));
//                   } else {
//                     return ListView.builder(
//                       itemCount: searchProvider.searchResults.length,
//                       itemBuilder: (context, index) {
//                         final Product product =
//                             searchProvider.searchResults[index];
//                         currencySymbol = getCurrencySymbol(product.currency);
//                         return GestureDetector(
//                           onTap: () {
//                             nextPage1(
//                               context,
//                               page: ProductDetailsScreen(
//                                 currency: '${currencySymbol}',
//                                 amount: product.amount,
//                                 productName: product.productName,
//                                 productId: product.productCode,
//                                 contestId: product.id,
//                                 tapCount: product.tapData.length,
//                                 targetTime: DateTime.parse(
//                                   product.startTime2.toString(),
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey.shade100),
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             margin: EdgeInsets.only(bottom: 10),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     width: 123,
//                                     height: 123,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Image.asset(
//                                       'assets/images/producticon.png',
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const SizedBox(height: 6),
//                                         Text.rich(
//                                           TextSpan(
//                                             children: [
//                                               TextSpan(
//                                                 text: 'Product: ',
//                                                 style: PageService
//                                                     .bigHeaderStylebold2,
//                                               ),
//                                               TextSpan(
//                                                 text: product.productName,
//                                                 style:
//                                                     PageService.bigHeaderStyle2,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(height: 2),
//                                         Text.rich(
//                                           TextSpan(
//                                             children: [
//                                               TextSpan(
//                                                 text: 'Date: ',
//                                                 style: PageService
//                                                     .bigHeaderStylebold2,
//                                               ),
//                                               TextSpan(
//                                                 text: DateFormat.yMMMMd()
//                                                     .add_jm()
//                                                     .format(DateTime.parse(
//                                                         product.startTime)),
//                                                 style:
//                                                     PageService.bigHeaderStyle2,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(height: 2),
//                                         Text.rich(
//                                           TextSpan(
//                                             children: [
//                                               TextSpan(
//                                                 text: 'Time remaining: ',
//                                                 style: PageService
//                                                     .bigHeaderStylebold2,
//                                               ),
//                                               TextSpan(
//                                                 text: formatTimeRemaining(
//                                                     DateTime.parse(
//                                                         product.startTime)),
//                                                 style:
//                                                     PageService.bigHeaderStyle2,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(height: 2),
//                                         Text.rich(
//                                           TextSpan(
//                                             children: [
//                                               TextSpan(
//                                                 text: 'category: ',
//                                                 style: PageService
//                                                     .bigHeaderStylebold2,
//                                               ),
//                                               TextSpan(
//                                                 text: product.category,
//                                                 style:
//                                                     PageService.bigHeaderStyle2,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         const SizedBox(height: 3),
//                                         Align(
//                                           alignment: Alignment.bottomRight,
//                                           child: GestureDetector(
//                                             onTap: () {},
//                                             child: Text(
//                                               product.completed
//                                                   ? 'Closed Contest'
//                                                   : 'Join Contest',
//                                               style: TextStyle(
//                                                 color: product.completed
//                                                     ? Colors.yellow
//                                                     : Colors.red,
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:contest_app/src/models/search.modal.dart';
import 'package:contest_app/src/screens/user_varients/product_details.dart';
import 'package:contest_app/src/src.dart';
import 'package:flutter/cupertino.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String currencySymbol = '';
  String? currency;
  String? selectedCategory; // Variable to store selected category
  List<String> categories = ['Electronics', 'Gadgets', 'Clothing', 'Food'];
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchCurrencyData();

    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    _searchController.addListener(() {
      searchProvider.search(_searchController.text);
    });
  }

  Future<void> _fetchCurrencyData() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    String savedcurrency = sf.getString('currency') ?? '';
    currencySymbol = getCurrencySymbol(savedcurrency);
    setState(() {});
  }

  String getCurrencySymbol(String? currency) {
    if (currency != null && currencies.containsKey(currency)) {
      return currencies[currency]!;
    } else {
      return '';
    }
  }

  String formatTimeRemaining(DateTime startTime) {
    Duration remainingTime = startTime.difference(DateTime.now());

    int days = remainingTime.inDays;
    int hours = remainingTime.inHours.remainder(24);
    int minutes = remainingTime.inMinutes.remainder(60);
    int seconds = remainingTime.inSeconds.remainder(60);

    if (days > 0) {
      return '${days}: ${hours}: ${minutes}: ${seconds}';
    } else if (hours > 0) {
      return '${days}: ${hours}: ${minutes}: ${seconds}';
    } else if (minutes > 0) {
      return '${days}: ${hours}: ${minutes}: ${seconds}';
    } else if (seconds <= 0) {
      return '${0}: ${0}: ${0}: ${0}';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  suffixIcon:
//                   Platform.isIOS
//                       ?

//                       // Define the list of categories

// // Inside your widget's build method
//                       CupertinoPicker(
//                           backgroundColor: Colors.white,
//                           itemExtent: 32.0,
//                           onSelectedItemChanged: (int index) {
//                             final selectedCategory = categories[index];
//                             print(
//                                 'Selected Category: $selectedCategory'); // Add debug print statement
//                             // Call searchCategory method with selected category
//                             Provider.of<SearchProvider>(context, listen: false)
//                                 .searchCategory(selectedCategory);
//                           },
//                           children: categories
//                               .map((category) => Text(category))
//                               .toList(),
//                         )

                      // CupertinoPicker(
                      //     backgroundColor: Colors.white,
                      //     itemExtent: 32.0,
                      //     onSelectedItemChanged: (int index) {
                      //       // Handle item selection
                      //     },

                      //     children: <Widget>[
                      //       Text('Electronics'),
                      //       Text('Gadgets'),
                      //       Text('Clothing'),
                      //       Text('Food'),
                      //     ],
                      //   )
                      // :
                      DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: selectedCategory,
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory = value;
                      });
                      print(
                          'Selected Category: $value'); // Add debug print statement
                      // Call searchCategory method with selected category
                      Provider.of<SearchProvider>(context, listen: false)
                          .searchCategory(value ?? "");
                    },
                    items: <String>[
                      'Electronics',
                      'Gadgets',
                      'Clothing',
                      'Food',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  filled: true,
                  fillColor: const Color(0xffF9FAFB),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColor.gray9,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  hintText: 'Search by product name',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.gray4,
                  ),
                  contentPadding: const EdgeInsets.only(
                    top: 15,
                    bottom: 10,
                    left: 10,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xffF9FAFB),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color(0xffF9FAFB),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Consumer<SearchProvider>(
                  builder: (context, searchProvider, _) {
                    if (searchProvider.isLoading) {
                      return Center(
                        child: SpinKitFadingCircle(
                          color: Colors.red,
                          size: 50,
                        ),
                      );
                    } else if (searchProvider.searchResults.isEmpty) {
                      return Center(child: Text('No results found.'));
                    } else {
                      return ListView.builder(
                        itemCount: searchProvider.searchResults.length,
                        itemBuilder: (context, index) {
                          final Product product =
                              searchProvider.searchResults[index];
                          currencySymbol = getCurrencySymbol(product.currency);
                          return GestureDetector(
                            onTap: () {
                              nextPage1(
                                context,
                                page: ProductDetailsScreen(
                                  image: product.videoURL,
                                  currency: '${currencySymbol}',
                                  amount: product.amount,
                                  productName: product.productName,
                                  productId: product.productCode,
                                  contestId: product.id,
                                  tapCount: product.tapData.length,
                                  targetTime: DateTime.parse(
                                    product.startTime2.toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade100),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: EdgeInsets.only(bottom: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      clipBehavior: Clip.hardEdge,
                                      width: 123,
                                      height: 123,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Image.network(
                                        '${product.videoURL}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 6),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Product: ',
                                                  style: PageService
                                                      .bigHeaderStylebold2,
                                                ),
                                                TextSpan(
                                                  text: product.productName,
                                                  style: PageService
                                                      .bigHeaderStyle2,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Date: ',
                                                  style: PageService
                                                      .bigHeaderStylebold2,
                                                ),
                                                TextSpan(
                                                  text: DateFormat.yMMMMd()
                                                      .format(DateTime.parse(
                                                          product.startTime)),
                                                  style: PageService
                                                      .bigHeaderStyle2,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'Amount: ',
                                                  style: PageService
                                                      .bigHeaderStylebold2,
                                                ),
                                                TextSpan(
                                                  text:
                                                      '$currencySymbol ${product.amount}',
                                                  style: PageService
                                                      .bigHeaderStyle2,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'category: ',
                                                  style: PageService
                                                      .bigHeaderStylebold2,
                                                ),
                                                TextSpan(
                                                  text: product.category,
                                                  style: PageService
                                                      .bigHeaderStyle2,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 3),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: Text(
                                                product.completed
                                                    ? 'Closed Contest'
                                                    : 'Join Contest',
                                                style: TextStyle(
                                                  color: product.completed
                                                      ? Colors.yellow
                                                      : Colors.red,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

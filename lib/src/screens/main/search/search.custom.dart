import 'package:contest_app/src/src.dart';

class UserProfileStack extends StatelessWidget {
  final List<String> userProfiles;
  final int maxUsersToShow;
  final double avatarRadius = 20.0;

  UserProfileStack({
    required this.userProfiles,
    this.maxUsersToShow = 2,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];

    // Calculate the total number of visible avatars
    int visibleAvatars = userProfiles.length > maxUsersToShow
        ? maxUsersToShow
        : userProfiles.length;

    // Add avatar widgets to the stack
    for (int i = 0; i < visibleAvatars; i++) {
      stackChildren.add(
        Positioned(
          left:
              i * (avatarRadius * 2 - 10), // Adjust the spacing between avatars
          child: CircleAvatar(
            radius: avatarRadius,
            backgroundImage: AssetImage(userProfiles[i]),
          ),
        ),
      );
    }

    // Add indicator for more users if needed
    if (userProfiles.length > maxUsersToShow) {
      stackChildren.add(
        Positioned(
          left: maxUsersToShow * (avatarRadius * 2 - 10), // Adjust position
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '+${userProfiles.length - maxUsersToShow}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            width: avatarRadius * 2,
            height: avatarRadius * 2,
          ),
        ),
      );
    }

    return Stack(
      children: stackChildren,
    );
  }
}

class SearchFeatures extends StatelessWidget {
  final String date;
  final String productName;
  final String currency;
  final int amount;
  final String category;
  // final String brandImage;
  final List<String> userProfiles;
  String image;
  final String joinClosed;
  final Color myColor;

  SearchFeatures(
      {required this.date,
      required this.currency,
      required this.productName,
      // required this.brandImage,
      required this.amount,
      required this.joinClosed,
      required this.category,
      required this.userProfiles,
      required this.myColor,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade100),
          borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.only(bottom: 10),
      // elevation: 0,
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
                image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     CircleAvatar(
                  //       radius: 10,
                  //       backgroundImage: AssetImage(brandImage),
                  //     ),
                  //     const SizedBox(width: 10),
                  //     Text(
                  //       labelName,
                  //       // style: PageService.bigHeaderStylebold2, // Style not provided, replace with your style
                  //     )
                  //   ],
                  // ),
                  const SizedBox(height: 6),
                  Text.rich(TextSpan(
                    children: [
                      TextSpan(
                          text: 'Product: ',
                          style: PageService.bigHeaderStylebold2
                          // style: PageService.bigHeaderStylebold2, // Style not provided, replace with your style
                          ),
                      TextSpan(
                          text: productName, style: PageService.bigHeaderStyle2
                          // style: PageService.bigHeaderStyle2, // Style not provided, replace with your style
                          ),
                    ],
                  )),
                  const SizedBox(height: 2),
                  Text.rich(TextSpan(
                    children: [
                      TextSpan(
                          text: 'Date: ', style: PageService.bigHeaderStylebold2
                          // style: PageService.bigHeaderStylebold2, // Style not provided, replace with your style
                          ),
                      TextSpan(text: date, style: PageService.bigHeaderStyle2
                          // style: PageService.bigHeaderStyle2, // Style not provided, replace with your style
                          ),
                    ],
                  )),
                  Text.rich(TextSpan(
                    children: [
                      TextSpan(
                          text: 'Amount: ',
                          style: PageService.bigHeaderStylebold2
                          // style: PageService.bigHeaderStylebold2, // Style not provided, replace with your style
                          ),
                      TextSpan(
                          text: '$currency $amount',
                          style: PageService.bigHeaderStyle2
                          // style: PageService.bigHeaderStyle2, // Style not provided, replace with your style
                          ),
                    ],
                  )),
                  const SizedBox(height: 3),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'category: ',
                          style: PageService.bigHeaderStylebold2,
                        ),
                        TextSpan(
                          text: category,
                          style: PageService.bigHeaderStyle2,
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
                        joinClosed,
                        style: TextStyle(
                          color: myColor,
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
    );
  }
}

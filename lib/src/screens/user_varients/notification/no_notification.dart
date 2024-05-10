import 'package:contest_app/src/src.dart';

class NoNotificationList extends StatefulWidget {
  const NoNotificationList({
    super.key,
  });

  @override
  State<NoNotificationList> createState() => _NoNotificationListState();
}

class _NoNotificationListState extends State<NoNotificationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Artwork.png'),
            const Padding(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 120),
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

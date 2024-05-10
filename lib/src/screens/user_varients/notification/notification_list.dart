import 'package:contest_app/src/screens/user_varients/notification/notification_details.dart';
import 'package:contest_app/src/src.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (c) => const NotificationDetails()));
      },
      child: ListTile(
        leading: Image.asset('assets/images/jumialogo.png'),
        title: const Flexible(
          child: Text(
            'Jumia Iphone 13 Contest!',
            overflow: TextOverflow.ellipsis, // Added to handle long titles
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: const Text(
          'Contest starts in 2mins.',
          style: TextStyle(
              fontSize: 14, color: Colors.grey, fontWeight: FontWeight.normal),
        ),
        trailing: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 14,
            ),
            Text(
              'Jan 29th 2024',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              '01:45:12 pm',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

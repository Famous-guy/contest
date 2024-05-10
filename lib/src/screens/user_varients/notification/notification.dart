import 'package:contest_app/src/export/export.dart';
import 'package:contest_app/src/screens/user_varients/notification/no_notification.dart';
import 'package:contest_app/src/screens/user_varients/notification/notification_list.dart';
import 'package:contest_app/src/src.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    int notifications = 1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Notification',
          style: PageService.bigHeaderStylesmall,
        ),
        centerTitle: true,
      ),
      body: notifications != 1
          ? const NotificationList()
          : const NoNotificationList(),
    );
  }
}

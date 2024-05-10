import 'package:contest_app/src/src.dart';

class NotificationDetails extends StatefulWidget {
  const NotificationDetails({super.key});

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('images/Store Logos jumia.png'),
                  Padding(padding: EdgeInsets.all(10)),
                  Text(
                    'Jumia Iphone 13 Contest!',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  Padding(padding: EdgeInsets.all(4)),
                  Text(
                    'Time remaining:  10:02:11',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(30))
                ],
              ),
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    child: Text(
                      'Contest Details',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  ContestDetails(
                    name: 'Merchant Name',
                    content: 'Jumia',
                  ),
                  ContestDetails(name: 'Product ID', content: '234590'),
                  ContestDetails(
                      name: 'Contest Starts', content: 'Jan 29, 2024 10:14 am'),
                  ContestDetails(
                      name: 'Contest Ends', content: 'Jan 29, 2024 15:14 am'),
                  Padding(padding: EdgeInsets.symmetric(vertical: 50)),
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xfff20732),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Join Contest',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ContestDetails extends StatelessWidget {
  ContestDetails({super.key, required this.name, required this.content});
  final String name;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          Text(
            content,
            style: TextStyle(fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}

import 'package:contest_app/src/src.dart';
import 'package:flutter/material.dart';

class WeekScreen extends StatelessWidget {
  const WeekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaderboardProvider>(builder: (context, today, _) {
      var leadership = today.weekly;

      return SliverList(
          delegate: SliverChildBuilderDelegate(childCount: leadership.length,
              (context, index) {
        final todayList = leadership[index];
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: index == 0
                ? Color.fromRGBO(
                    255,
                    251,
                    235,
                    1,
                  )
                : index == 1
                    ? Color.fromRGBO(
                        150,
                        212,
                        246,
                        0.1,
                      )
                    : index == 2
                        ? Color.fromRGBO(
                            249,
                            250,
                            251,
                            1,
                          )
                        : Color.fromRGBO(
                            254,
                            242,
                            242,
                            1,
                          ),
            border: index == 0
                ? Border.all(
                    color: Color.fromRGBO(
                      253,
                      230,
                      138,
                      1,
                    ),
                  )
                : index == 1
                    ? Border.all(
                        color: Color.fromRGBO(
                          150,
                          212,
                          246,
                          1,
                        ),
                      )
                    : index == 2
                        ? Border.all(
                            color: Color.fromRGBO(
                              229,
                              231,
                              235,
                              1,
                            ),
                          )
                        : Border.all(
                            color: Color.fromRGBO(
                              254,
                              202,
                              202,
                              1,
                            ),
                          ),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 15,
              ),
              Visibility(
                  visible: index == 0,
                  child: Image.asset('assets/images/smallcup.png')),
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xffE5E7EB),
                    radius: 40,
                    child: ClipOval(
                      child: Image.network(
                        todayList.userDetails?.username == null
                            ? 'https://robohash.org/default.png?size=100x100&set=set1'
                            : 'https://robohash.org/${todayList.userDetails?.username}.png?size=100x100&set=set1',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  visualDensity: const VisualDensity(horizontal: -4),
                  title: Text(
                    '${todayList.userDetails?.username} currently rank',
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColor.gray8,
                        fontWeight: FontWeight.w700),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Text(
                        '${todayList.count} X',
                        style: TextStyle(
                            color: AppColor.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }));
    });
  }
}

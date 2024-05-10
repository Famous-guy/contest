import 'package:contest_app/src/src.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          alignment: Alignment.bottomCenter,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/successcheck.png"),
                PageService.textSpacexL,
                Text(
                  "Password reset successful",
                  style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
                PageService.textSpace,
                Text("Your password has been updated\nsuccessfully",
                    textAlign: TextAlign.center, style: PageService.labelStyle),
                PageService.textSpacexL,
                customButton(context,
                    onTap: () {}, text: 'Done', bgColor: AppColor.primaryColor)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

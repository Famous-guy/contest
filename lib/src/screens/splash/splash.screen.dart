import 'package:contest_app/src/src.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _controller.forward().whenComplete(() {
      // Set isLoading to false to stop the loading animation
      setState(() {
        isLoading = false;
      });
      Future.delayed(const Duration(seconds: 0), () {
        DatabaseProvider().getToken().then((token) async {
          if (token != "") {
            await Provider.of<HomeProvider>(context, listen: false)
                .fetchContests();
            nextPageAndRemovePrevious(context, page: MainActivityPage());
          } else {
            nextPageAndRemovePrevious(context, page: const SignInScreen());
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF20732),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(
                'assets/images/contest.png',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 98,
                right: 98,
                top: 16,
              ),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 5, // Adjust the height of the loading bar
                    decoration: BoxDecoration(
                      color: Color(0xffDDDDDD),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Container(
                        width: MediaQuery.of(context).size.width *
                            _controller.value,
                        height: 5, // Adjust the height of the loading bar
                        decoration: BoxDecoration(
                          color: Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

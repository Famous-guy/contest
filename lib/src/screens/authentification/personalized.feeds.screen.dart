import 'package:contest_app/src/src.dart';

class PersonalizedFeedsScreen extends StatefulWidget {
  const PersonalizedFeedsScreen({super.key});

  @override
  State<PersonalizedFeedsScreen> createState() =>
      _PersonalizedFeedsScreenState();
}

class _PersonalizedFeedsScreenState extends State<PersonalizedFeedsScreen> {
  List<String> selectedTechStack = [];
  bool isInputFocused = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    content: Container(
                      // width: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      'Are You Sure you want to skip this process?',
                                      style: TextStyle(
                                          color: AppColor.gray9,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: Color(0xffACACCA),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              customButton(
                                context,
                                onTap: () {
                                  nextPage(
                                    context,
                                    page: MainActivityPage(),
                                  );
                                },
                                text: "Proceed",
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              customButton(
                                bgColor: Colors.red,
                                context,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                text: "Cancel",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Skip',
                style: TextStyle(
                    color: AppColor.gray9,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {
            isInputFocused = false;
          });
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personalize your feed',
                      style: PageService.bigHeaderStylebold,
                    ),
                    PageService.textSpace,
                    Text(
                      'Select products of interests',
                      style: PageService.labelStyle,
                    ),
                    PageService.textSpacexL,
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              elevation: 0,
                              backgroundColor: Colors.white,
                              content: Container(
                                width: 400,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Add a new interest',
                                              style: TextStyle(
                                                  color: AppColor.gray9,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: CircleAvatar(
                                                  backgroundColor:
                                                      Color(0xffEBEBEB),
                                                  child: Icon(
                                                    Icons.close,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: Color(0xffACACCA),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            textAlign: TextAlign.left,
                                            'Tag:',
                                            style: TextStyle(
                                                color: Color(
                                                  0xff2F2924,
                                                ),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            // width: 200,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  hintStyle: TextStyle(
                                                    color: Color(0xff999999),
                                                  ),
                                                  hintText: 'Add interest here',
                                                  filled: true,
                                                  fillColor: Color(0xffF9FAFB)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 24,
                                        ),
                                        customButton(context, onTap: () {
                                          Navigator.pop(context);
                                        }, text: "Add interest")
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.add, color: Colors.red),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Add a new interest',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'SpaceGrotesk',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    PageService.textSpacexxL,
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: interestList
                          .map(
                            (tech) => FilterChip(
                              selectedColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                    color: selectedTechStack.contains(tech)
                                        ? Colors.red
                                        : AppColor.gray6,
                                  )),
                              label: Text(
                                tech,
                                style: TextStyle(
                                    color: selectedTechStack.contains(tech)
                                        ? AppColor.primaryColor
                                        : AppColor.gray6,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              backgroundColor: selectedTechStack.contains(tech)
                                  ? Colors.white
                                  : Colors.white,
                              selected: selectedTechStack.contains(tech),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    selectedTechStack.add(tech);
                                  } else {
                                    selectedTechStack.remove(tech);
                                  }
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    customButton(context, onTap: () {}, text: "Done")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

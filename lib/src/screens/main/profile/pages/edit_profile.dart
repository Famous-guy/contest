import 'package:contest_app/src/src.dart';
import 'package:image_picker/image_picker.dart';


class EditProfileScreen extends StatefulWidget {
  // const EditProfileScreen({super.key});
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();

  String path = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: PageService.headerStyle,
        ),
      ),
      body: Consumer<ProfileProvider>(builder: (context, model, child) {
        if (model.isLoading == true) {
          return BusyOverlay(
            title: 'Updating profile',
            show: true,
            child: Text(""),
          );
        } else {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: SizedBox(
                        height: 120,
                        child: Stack(
                          children: [
                            path == ''
                                ? Image.asset("assets/images/person.png")
                                : CircleAvatar(
                                    radius: 60,
                                    backgroundImage: FileImage(File(path))),
                            Positioned(
                              bottom: 5,
                              left: 30,
                              child: GestureDetector(
                                onTap: () async {
                                  try {
                                    final pickedFile = await OpenCamera()
                                        .pickCamera(source: ImageSource.gallery)
                                        .then((value) {
                                      if (value != '') {
                                        setState(() {
                                          path = value;
                                          success(context,
                                              message:
                                                  'Selected Image Path: $path'); // Add this print statement
                                        });
                                      }
                                    });
                                  } catch (e) {
                                    print('Error picking image: $e');
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: AppColor.primaryColor,
                                  child: Icon(
                                    Icons.camera_alt_sharp,
                                    color: AppColor.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                      PageService.textSpacexxL,
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.gray8,
                                    fontSize: 14)),
                            TextSpan(
                                text: " *",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.primaryColor,
                                    fontSize: 14)),
                          ]))),
                      TextFormField(
                        controller: _fullname,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color(0xff9E9E9E),
                          ),
                          border: InputBorder.none,
                          filled: true,
                          isDense: true,
                          hintText: 'Enter name',
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.gray4),
                          contentPadding: const EdgeInsets.only(
                              top: 15, bottom: 10, left: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: AppColor.gray2, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: AppColor.gray2, width: 1),
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 10, top: 15),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Username ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.gray8,
                                    fontSize: 14)),
                            TextSpan(
                                text: " *",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.primaryColor,
                                    fontSize: 14)),
                          ]))),
                      TextFormField(
                        controller: _username,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color(0xff9E9E9E),
                          ),
                          border: InputBorder.none,
                          filled: true,
                          isDense: true,
                          hintText: 'Enter Username',
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.gray4),
                          contentPadding: const EdgeInsets.only(
                              top: 15, bottom: 10, left: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: AppColor.gray2, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: AppColor.gray2, width: 1),
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 10, top: 15),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Email ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.gray8,
                                    fontSize: 14)),
                            TextSpan(
                                text: " *",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.primaryColor,
                                    fontSize: 14)),
                          ]))),
                      TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color(0xff9E9E9E),
                          ),
                          border: InputBorder.none,
                          filled: true,
                          isDense: true,
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.gray4),
                          contentPadding: const EdgeInsets.only(
                              top: 15, bottom: 10, left: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: AppColor.gray2, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: AppColor.gray2, width: 1),
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(bottom: 10, top: 15),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "Gender ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.gray8,
                                    fontSize: 14)),
                            TextSpan(
                                text: " *",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.primaryColor,
                                    fontSize: 14)),
                          ]))),
                      TextFormField(
                        controller: _gender,
                        decoration: InputDecoration(
                          prefixIcon: Image.asset("assets/images/Swap.png"),
                          border: InputBorder.none,
                          filled: true,
                          isDense: true,
                          hintText: 'Enter Gender',
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColor.gray4),
                          contentPadding: const EdgeInsets.only(
                              top: 15, bottom: 10, left: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: AppColor.gray2, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: AppColor.gray2, width: 1),
                          ),
                        ),
                      ),
                      PageService.textSpacexxL,
                      PageService.textSpacexxL,
                      customButton(context, onTap: () {
                        if (_fullname.text.isEmpty ||
                            _username.text.isEmpty ||
                            _email.text.isEmpty ||
                            _gender.text.isEmpty) {
                          errorSnackBar(context, 'Fields are required');
                        } else {
                          model.updateUser(
                            email: _email.text.trim(),
                            gender: _gender.text.trim(),
                            fullName: _fullname.text.trim(),
                            username: _username.text.trim(),
                            image: path,
                            context: context,
                          );
                        }
                      }, text: 'Update Changes', bgColor: AppColor.primaryColor)
                    ],
                  ),
                ),
              )
            ],
          );
        }
      }),
    );
  }
}

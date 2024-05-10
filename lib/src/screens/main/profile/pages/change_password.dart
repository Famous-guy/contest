// import 'package:contest_app/src/src.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});

//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final TextEditingController _password = TextEditingController();
//   final TextEditingController _newPassword = TextEditingController();
//   final TextEditingController _confirmPassword = TextEditingController();

//   bool _passwordVisible = false;
//   bool _newPasswordVisible = false;
//   bool _confirmPasswordVisible = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Change password",
//           style: PageService.bigHeaderStyle,
//         ),
//         centerTitle: true,
//         leading: GestureDetector(
//           child: const Icon(Icons.arrow_back_ios),
//           onTap: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Change password",
//                     style: PageService.bigHeaderStylesmall,
//                   ),
//                   PageService.textSpace,
//                   Text(
//                     "New password must be different from\npreviously used password",
//                     style: PageService.labelStyle,
//                   ),
//                   PageService.textSpacexxL,
//                   Row(
//                     children: [
//                       Text(
//                         'Old password ',
//                         style: PageService.labelStyle500,
//                       ),
//                       const Text(
//                         '*',
//                         style: TextStyle(
//                           color: Color.fromRGBO(239, 68, 68, 1),
//                         ),
//                       )
//                     ],
//                   ),
//                   PageService.textSpace,
//                   TextFormField(
//                     obscureText: !_passwordVisible,
//                     controller: _password,
//                     decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _passwordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                           color: const Color(0xff9BA59F),
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _passwordVisible = !_passwordVisible;
//                           });
//                         },
//                       ),
//                       prefixIcon: const Icon(
//                         Icons.lock,
//                         color: Color(0xff9E9E9E),
//                       ),
//                       border: InputBorder.none,
//                       isDense: true,
//                       hintText: 'Enter Old Password',
//                       hintStyle: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: AppColor.gray4),
//                       contentPadding:
//                           const EdgeInsets.only(top: 15, bottom: 10, left: 10),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: AppColor.gray2, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: AppColor.gray2, width: 2),
//                       ),
//                     ),
//                   ),
//                   PageService.textSpacexL,
//                   Row(
//                     children: [
//                       Text(
//                         'New password ',
//                         style: PageService.labelStyle500,
//                       ),
//                       const Text(
//                         '*',
//                         style: TextStyle(
//                           color: Color.fromRGBO(239, 68, 68, 1),
//                         ),
//                       )
//                     ],
//                   ),
//                   PageService.textSpace,
//                   TextFormField(
//                     obscureText: !_newPasswordVisible,
//                     controller: _newPassword,
//                     decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _newPasswordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                           color: const Color(0xff9BA59F),
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _newPasswordVisible = !_newPasswordVisible;
//                           });
//                         },
//                       ),
//                       prefixIcon: const Icon(
//                         Icons.lock,
//                         color: Color(0xff9E9E9E),
//                       ),
//                       border: InputBorder.none,
//                       isDense: true,
//                       hintText: 'Enter New Password',
//                       hintStyle: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: AppColor.gray4),
//                       contentPadding:
//                           const EdgeInsets.only(top: 15, bottom: 10, left: 10),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: AppColor.gray2, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: AppColor.gray2, width: 2),
//                       ),
//                     ),
//                   ),
//                   PageService.textSpacexL,
//                   Row(
//                     children: [
//                       Text(
//                         'Confirm password ',
//                         style: PageService.labelStyle500,
//                       ),
//                       const Text(
//                         '*',
//                         style: TextStyle(
//                           color: Color.fromRGBO(239, 68, 68, 1),
//                         ),
//                       )
//                     ],
//                   ),
//                   PageService.textSpace,
//                   TextFormField(
//                     obscureText: !_confirmPasswordVisible,
//                     controller: _confirmPassword,
//                     decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _confirmPasswordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                           color: const Color(0xff9BA59F),
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _confirmPasswordVisible = !_confirmPasswordVisible;
//                           });
//                         },
//                       ),
//                       prefixIcon: const Icon(
//                         Icons.lock,
//                         color: Color(0xff9E9E9E),
//                       ),
//                       border: InputBorder.none,
//                       isDense: true,
//                       hintText: 'Confirm Password',
//                       hintStyle: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: AppColor.gray4),
//                       contentPadding:
//                           const EdgeInsets.only(top: 15, bottom: 10, left: 10),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: AppColor.gray2, width: 2),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(color: AppColor.gray2, width: 2),
//                       ),
//                     ),
//                   ),
//                   PageService.textSpacexxL,
//                   PageService.textSpacexxL,
//                   customButton(context, onTap: () {
//                     nextPage(context, page:  SuccessScreen());
//                   },
//                       text: 'Reset password',
//                       bgColor: const Color(0xffA5B0C1),
//                       textColor: AppColor.gray9)
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

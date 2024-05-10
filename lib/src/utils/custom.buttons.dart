import 'package:contest_app/src/src.dart';

Widget customButton(
  BuildContext context, {
  required VoidCallback onTap,
  required String text,
  Color? bgColor,
  double? padding = 15,
  Color? textColor,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(padding!),
        decoration: BoxDecoration(
            color: bgColor ?? Color(0xffA5B0C1),
            borderRadius: BorderRadius.circular(50)),
        child: Text(
          text,
          style: TextStyle(
              color: textColor ?? Colors.white,
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w700,
              fontSize: 16),
        )),
  );
}

Widget LoadingButton(
  BuildContext context, {
  required VoidCallback onTap,
  required Widget chil,
  Color? bgColor,
  double? padding = 15,
  Color? textColor,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(
          color: bgColor ?? Color(0xffA5B0C1),
          borderRadius: BorderRadius.circular(50)),
      child: chil,
      // Text(
      //   text,
      //   style: TextStyle(
      //       color: textColor ?? Colors.white,
      //       fontFamily: 'SF Pro Display',
      //       fontWeight: FontWeight.w700,
      //       fontSize: 16),
      // )
    ),
  );
}

// class LoadingButton1 extends StatelessWidget {
//   final BuildContext context;
//   final Function()? onTap;
//   final Widget child;
//   final bool isLoading; // New parameter for loading state

//   const LoadingButton1({
//     required this.context,
//     required this.onTap,
//     required this.child,
//     required this.isLoading, // Initialize the new parameter
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed:
//           isLoading ? null : onTap, // Disable button when isLoading is true
//       child: isLoading
//           ? SizedBox(
//               width: 24,
//               height: 24,
//               child: CircularProgressIndicator(
//                 color: Colors.white,
//               ),
//             )
//           : child,
//     );
//   }
// }

// class LoadingButton1 extends StatelessWidget {
//   final BuildContext context;
//   final Function()? onTap;
//   final Widget child;
//   double? padding = 15;
//   Color? textColor;
//   final bool isLoading; // New parameter for loading state
//   Color? bgColor; // New property for background color
//   String text;
//   LoadingButton1({
//     required this.context,
//     required this.onTap,
//     required this.child,
//     required this.isLoading,
//     required this.text,
//     this.bgColor,
//     this.padding,
//     this.textColor, // Initialize the new parameter
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//           alignment: Alignment.center,
//           width: MediaQuery.of(context).size.width,
//           padding: EdgeInsets.all(padding!),
//           decoration: BoxDecoration(
//               color: bgColor ?? Color(0xffA5B0C1),
//               borderRadius: BorderRadius.circular(50)),
//           child: isLoading
//               ? SizedBox(
//                   width: 24,
//                   height: 24,
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                   ),
//                 )
//               : Text(
//                   text,
//                   style: TextStyle(
//                       color: textColor ?? Colors.white,
//                       fontFamily: 'SF Pro Display',
//                       fontWeight: FontWeight.w700,
//                       fontSize: 16),
//                 )),
//     );
//     // ElevatedButton(
//     //   onPressed: isLoading ? null : onTap,
//     //   child: isLoading
//     //       ? SizedBox(
//     //           width: 24,
//     //           height: 24,
//     //           child: CircularProgressIndicator(
//     //             color: Colors.white,
//     //           ),
//     //         )
//     //       : child,
//     //   style: ButtonStyle(
//     //     backgroundColor: MaterialStateProperty.all<Color>(bgColor),
//     //   ),
//     // );
//   }
// }

class LoadingButton1 extends StatelessWidget {
  final BuildContext context;
  final Function()? onTap;
  final Widget child;
  final double padding;
  final Color? textColor;
  final bool isLoading;
  final Color? bgColor;
  final String text;
  final double radius;
  LoadingButton1(
      {required this.context,
      required this.onTap,
      required this.child,
      this.padding = 15,
      this.textColor,
      this.radius = 50,
      required this.isLoading,
      required this.bgColor,
      required this.text,
      thi});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: bgColor ?? Color(0xffA5B0C1),
          borderRadius: BorderRadius.circular(50),
        ),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}

// Widget customButton(
//   BuildContext context, {
//   required VoidCallback onTap,
//   required String text,
//   Color? bgColor,
//   double? padding = 15,
//   Color? textColor,
// }) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//         alignment: Alignment.center,
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.all(padding!),
//         decoration: BoxDecoration(
//             color: bgColor ?? Color(0xffA5B0C1),
//             borderRadius: BorderRadius.circular(50)),
//         child: Text(
//           text,
//           style: TextStyle(
//               color: textColor ?? Colors.white,
//               fontFamily: 'SF Pro Display',
//               fontWeight: FontWeight.w700,
//               fontSize: 16),
//         )),
//   );
// }

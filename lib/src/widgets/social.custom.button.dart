import 'package:contest_app/src/src.dart';

class ScoiallTabButton extends StatelessWidget {
  const ScoiallTabButton({super.key, this.onTap, required this.icon});

  final VoidCallback? onTap;
  final Widget icon;

  //Color Instance

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 11, right: 15),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.gray1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: icon,
      ),
    );
  }
}

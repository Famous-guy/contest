import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 68,
      backgroundColor: const Color(0xfffae388),
      child: CircleAvatar(
        radius: 55,
        backgroundColor: const Color(0xfffae388),
        child: CircleAvatar(
          backgroundColor: const Color(0xffE5E7EB),
          radius: 50,
          child: ClipOval(
            child: Image.asset(
              'assets/images/boyface.png',
              fit: BoxFit.cover,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}

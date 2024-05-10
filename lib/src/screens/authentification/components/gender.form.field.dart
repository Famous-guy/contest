import 'package:contest_app/src/constants/appcolors.dart';
import 'package:flutter/material.dart';

class GenderFormField extends StatelessWidget {
  final String? initialValue;
  final void Function(String?)? onChanged;

  const GenderFormField({Key? key, this.initialValue, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      value: initialValue,
      onChanged: onChanged,
      items: ['Male', 'Female', 'Other']
          .map<DropdownMenuItem<String>>(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList(),
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.people_rounded,
          color: Color(0xff9E9E9E),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.gray2, width: 2),
        ),
        isDense: true,
        hintText: 'gender',
        hintStyle: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: AppColor.gray4),
        contentPadding: const EdgeInsets.only(top: 15, bottom: 10, left: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.gray2, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.gray2, width: 2),
        ),
      ),

      // InputDecoration(
      //   // labelText: 'Gender',

      //   enabledBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(12),
      //     borderSide: BorderSide(color: AppColor.gray2, width: 2),
      //   ),
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(12),
      //     borderSide: BorderSide(color: AppColor.gray2, width: 2),
      //   ),
      // ),
    );
  }
}

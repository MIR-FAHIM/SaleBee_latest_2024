import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../common/ui.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.onTapped,
    this.keyboardType,
    this.initialValue,
    this.hintText,
    this.errorText,
    this.iconData,
    this.labelText,
    this.counterText,
    this.obscureText,
    this.suffixIcon,
    this.isFirst,
    this.isLast,
    this.style,
    this.textAlign,
    this.suffix,
    this.limit,
    this.tapping,
    this.imageData,
    this.hasDropdown = false,
    this.dropDownData,
    this.initialDropDownValue,
    this.readOnly = false,
  }) : super(key: key);

  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTapped;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final TextAlign? textAlign;
  final String? labelText;
  final String? counterText;
  final TextStyle? style;
  final IconData? iconData;
  final bool? obscureText;
  final bool? isFirst;
  final bool? isLast;
  final Widget? suffixIcon;
  final Widget? suffix;
  final int? limit;
  final bool? tapping;
  final imageData;
  final bool? hasDropdown;
  final dropDownData;
  final initialDropDownValue;
  final readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 14, left: 20, right: hasDropdown! ? 0 : 10),
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: buildBorderRadius,
        boxShadow: [
          BoxShadow(color: const Color(0xFF652981).withOpacity(0.2), blurRadius: 2, offset: const Offset(0, 2)),
        ],
        //   border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          labelText != null
              ? Text(
            labelText ?? "",
            style: Get.textTheme.bodyText1,
            textAlign: textAlign ?? TextAlign.start,
          )
              : Wrap(),
          hasDropdown!
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // color: AppColors.primaryColor,
                width: hasDropdown! ? Get.size.width * .75 : Get.size.width,
                child: TextFormField(
                  onTap: onTapped,
                  keyboardType: keyboardType ?? TextInputType.text,
                  onSaved: onSaved,
                  maxLength: limit,
                  onChanged: onChanged,
                  validator: validator,
                  readOnly: readOnly,
                  initialValue: initialValue ?? '',
                  style: style ?? Get.textTheme.bodyText2,
                  obscureText: obscureText ?? false,
                  textAlign: textAlign ?? TextAlign.start,
                  cursorColor: const Color(0xFF652981),
                  decoration: iconData == null && imageData == null
                      ? InputDecoration(
                    counterText: "",
                    hintText: hintText,
                    hintStyle: Get.textTheme.caption,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: const EdgeInsets.all(0),
                    focusColor: const Color(0xFF652981),
                    border: const OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                  )
                      : Ui.getInputDecorationWithoutCounter(
                    hintText: hintText ?? '',
                    iconData: iconData,
                    suffixIcon: suffixIcon,
                    suffix: suffix,
                    errorText: errorText,
                    imageData: imageData,
                    counterText: counterText,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: initialDropDownValue != ''
                      ? Image.asset(
                    initialDropDownValue,
                    height: 20,
                    width: 20,
                  )
                      : Text(initialDropDownValue)

                // DropdownButton(
                //   // Initial Value
                //   value: initialDropDownValue ?? '',
                //   alignment: AlignmentDirectional.centerEnd,
                //   // Down Arrow Icon
                //   icon: const Icon(Icons.keyboard_arrow_down),
                //   borderRadius: BorderRadius.circular(8),
                //
                //   underline: SizedBox(),
                //   items: dropDownData.map((String items) {
                //     return DropdownMenuItem(
                //       value: items,
                //       child: items != ''
                //           ? Image.asset(
                //               items,
                //               height: 20,
                //               width: 20,
                //             )
                //           : Text(items),
                //     );
                //   }).toList(),
                //   // After selecting the desired option,it will
                //   // change button value to selected value
                //   onChanged: (newValue) {},
                // ),
              )
            ],
          )
              : SizedBox(
            // color: AppColors.primaryColor,
            width: hasDropdown! ? Get.size.width * .75 : Get.size.width,
            child: TextFormField(
              onTap: onTapped,
              keyboardType: keyboardType ?? TextInputType.text,
              onSaved: onSaved,
              maxLength: limit,
              onChanged: onChanged,
              validator: validator,
              readOnly: readOnly,
              initialValue: initialValue ?? '',
              style: style ?? Get.textTheme.bodyText2,
              obscureText: obscureText ?? false,
              textAlign: textAlign ?? TextAlign.start,
              cursorColor: const Color(0xFF652981),
              decoration: iconData == null && imageData == null
                  ? InputDecoration(
                counterText: "",
                hintText: hintText,
                hintStyle: Get.textTheme.caption,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.all(0),
                focusColor: const Color(0xFF652981),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
              )
                  : Ui.getInputDecorationWithoutCounter(
                hintText: hintText ?? '',
                iconData: iconData,
                suffixIcon: suffixIcon,
                suffix: suffix,
                errorText: errorText,
                imageData: imageData,
                counterText: counterText,
              ),
            ),
          )
        ],
      ),
    );
  }

  BorderRadius get buildBorderRadius {
    if (isFirst != null && isFirst!) {
      return const BorderRadius.vertical(top: Radius.circular(10));
    }
    if (isLast != null && isLast!) {
      return const BorderRadius.vertical(bottom: const Radius.circular(10));
    }
    if (isFirst != null && !isFirst! && isLast != null && !isLast!) {
      return const BorderRadius.all(Radius.circular(0));
    }
    return const BorderRadius.all(const Radius.circular(10));
  }

  double get topMargin {
    if ((isFirst != null && isFirst!)) {
      return 20;
    } else if (isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast != null && isLast!)) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
}

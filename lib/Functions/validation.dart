//////////////// Function to Vaiidate Email /////////////////

String? validateEmail(String? value) {
  if (value == "") {
    return 'الرجاء إدخال عنوان بريدك الإلكتروني.';
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
    return 'الرجاء إدخال عنوان بريد إلكتروني صحيح.';
  }
  return null;
}

////////////////////  Function to Validate Password //////////////////

String? validateLoginPassword(String? value) {
  if (value == "") {
    return 'الرجاء إدخال كلمة المرور..';
  }

  if (value!.length < 8) {
    return 'يجب أن تتكون كلمة المرور من الأقل ٨ أحرف.';
  }
  return null;
}

String? validateRegisterPassword(String? value) {
  if (value == "") {
    return 'الرجاء إدخال كلمة المرور.';
  }
  if (value!.length < 8) {
    return 'يجب أن تتكون كلمة المرور من الأقل ٨ أحرف..';
  }
  if (!RegExp(
          r'^(?=.*[a-zA-Z])(?=.*[!@#$%^&*(),.?":{}|<>])[a-zA-Z0-9!@#$%^&*(),.?":{}|<>]{8,}$')
      .hasMatch(value)) {
    return 'يجب أن تحتوي كلمة المرور على حرف واحد على الأقل ورمز واحد على الأقل.';
  }
  return null;
}

/////////////////// Validate Phone Number //////////////////////

String? validatePhoneNumber(String value) {
  if (value.isEmpty) {
    return 'الرجاء إدخال رقم الهاتف.';
  }

  if (!RegExp(r'^\d{11}$').hasMatch(value)) {
    return 'يجب أن يتكون رقم الهاتف من 11 رقمًا.';
  }
  return null;
}

////////////////////////// Validate NationalId//////////////////////////

String? validateNationalId(String? value) {
  if (value == "") {
    return 'الرجاء إدخال الرقم القومي.';
  }
  if (!RegExp(r'^\d{14}$').hasMatch(value!)) {
    return 'يجب أن يتكون الرقم القومي من 14 رقمًا.';
  }
  return null;
}
//////////////////// Validate Price //////////////////////////////////////

String? validatePrice(String? value) {
  if (value == "") {
    return 'الرجاء إدخال السعر.';
  }
  // Custom price validation: must not be greater than 300
  double? price = double.tryParse(value!);
  if (price == null) {
    return 'الرجاء إدخال سعر صحيح.';
  }
  if (price > 300) {
    return 'يجب أن لا يزيد السعر عن 300.';
  }
  return null;
}

String? validateDescription(String? value) {
  if (value == "") {
    return 'الرجاء إدخال وصف الفني.';
  }
  if (value!.length < 100) {
    return 'يجب أن يتكون الوصف من 100 حرف على الأقل.';
  }
  if (value!.length > 200) {
    return 'يجب أن لا يزيد الوصف عن 200 حرف.';
  }
  return null;
}

bool isValidEgyptianPhoneNumber(String input) {
  final RegExp egyptianPhoneRegExp = RegExp(r'^(\+20|0)?1[0125][0-9]{8}$');
  return egyptianPhoneRegExp.hasMatch(input);
}

bool isValidEmail(String input) {
  final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,4})+$');
  return emailRegExp.hasMatch(input);
}

String? validateEmailOrPhoneNumber(String? value) {
  if (value == "") {
    return 'الرجاء إدخال عنوان بريدك الإلكتروني.';
  } else {
    if (isValidEgyptianPhoneNumber(value!)) {
      return null;
    } else if (isValidEmail(value)) {
      return null;
    } else {
      return 'البريد الالكتروني او رقم الهاتف غير صالح';
    }
  }
}

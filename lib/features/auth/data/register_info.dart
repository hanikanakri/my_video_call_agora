class RegisterInfo {
  String? emailAddress;
  String? fullName;
  String? confirmPassword;
  String? token;
  int? verificationCode;
  int? phoneNumber;

  RegisterInfo({
    this.emailAddress,
    this.verificationCode,
    this.token,
    this.fullName,
    this.phoneNumber,
    this.confirmPassword,
  });

  factory RegisterInfo.fromJson(Map<String, dynamic> json) => RegisterInfo(
    emailAddress: 'emailAddress',
    fullName: 'fullName',
    phoneNumber: int.tryParse('phoneNumber'),
  );

  Map<String, dynamic> toJson() => {
        "emailAddress": emailAddress,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
      };
}

/*class Tasks {
  String? emailAddress;
  String? fullName;
  int? phoneNumber;

  Tasks({
    this.emailAddress,
    this.fullName,
    this.phoneNumber,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
        emailAddress: 'emailAddress',
        fullName: 'fullName',
        phoneNumber: int.tryParse('phoneNumber'),
      );

  Map<String, dynamic> toJson() => {
        "emailAddress": emailAddress,
        "fullName": fullName,
        "phoneNumber": phoneNumber,
      };
}*/

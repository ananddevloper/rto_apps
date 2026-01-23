class RtoOfficesModal {
  final String? code;
  final String? office;
  final String? address;
  final String? phone;
  final String? email;

  RtoOfficesModal({
    required this.code,
    required this.office,
    required this.address,
    this.phone,
    this.email,
  });

  factory RtoOfficesModal.fromJson(Map<String, dynamic> json) {
    return RtoOfficesModal(
      code: json['code'],
      office: json['office'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'office': office,
      'address': address,
      'phone': phone,
      'email': email,
    };
  }
}

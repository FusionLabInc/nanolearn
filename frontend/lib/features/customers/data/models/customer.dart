import 'package:faker/faker.dart';

class Address {
  String? street;
  String? city;
  String? state;
  String? postalCode;
  String? country;

  Address({
    required this.street,
    required this.city,
    required this.country,
    required this.state,
    required this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      postalCode:
          json['postal_code'] != null ? json['postal_code'] as String? : null,
      state: json['state'] != null ? json['state'] as String? : null,
      city: json['city'] != null ? json['city'] as String? : null,
      street: json['street'] != null ? json['street'] as String? : null,
      country: json['country'] != null ? json['country'] as String? : null,
    );
  }
}

class EmergencyContact {
  String? name;
  String? phoneNumber;
  String? relationship;

  EmergencyContact({
    required this.name,
    required this.phoneNumber,
    required this.relationship,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      phoneNumber:
          json['phone_number'] != null ? json['phone_number'] as String? : null,
      name: json['name'] != null ? json['name'] as String? : null,
      relationship:
          json['relationship'] != null ? json['relationship'] as String? : null,
    );
  }
}

class NotificationsPreferences {
  bool? email;
  bool? sms;

  NotificationsPreferences({
    required this.email,
    required this.sms,
  });

  factory NotificationsPreferences.fromJson(Map<String, dynamic> json) {
    return NotificationsPreferences(
      sms: json['sms'] ?? false,
      email: json['email'] ?? false,
    );
  }
}

enum Gender { male, female, other }

Gender stringToGender(String genderString) {
  switch (genderString.toLowerCase()) {
    case 'male':
      return Gender.male;
    case 'female':
      return Gender.female;
    case 'other':
      return Gender.other;
    default:
      return Gender.other;
  }
}

class Customer {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  DateTime? dateOfBirth;
  Address? address;
  String? profilePictureUrl;
  EmergencyContact? emergencyContact;
  String? referralSource;
  NotificationsPreferences? notificationsPreferences;
  Gender? gender;
  DateTime? createdAt;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.address,
    this.profilePictureUrl,
    required this.emergencyContact,
    this.referralSource,
    required this.notificationsPreferences,
    required this.gender,
    required this.createdAt,
  });

  static final Faker _faker = Faker();
  factory Customer.random({required int id}) {
    return Customer(
      id: _faker.guid.guid(),
      firstName: _faker.person.firstName(),
      lastName: _faker.person.lastName(),
      email: _faker.internet.email(),
      phoneNumber: _faker.phoneNumber.us(),
      dateOfBirth: _faker.date.dateTime(minYear: 1997, maxYear: 2006),
      address: Address(
        street: _faker.address.streetAddress(),
        city: _faker.address.city(),
        country: _faker.address.city(),
        state: _faker.address.state(),
        postalCode: _faker.address.zipCode(),
      ),
      profilePictureUrl: _faker.internet.httpUrl(),
      emergencyContact: EmergencyContact(
        name: _faker.person.name(),
        phoneNumber: _faker.phoneNumber.us(),
        relationship:
            _faker.randomGenerator.element(['Friend', 'Family', 'Colleague']),
      ),
      referralSource:
          _faker.randomGenerator.element(['Instagram', 'Social', 'Twitter']),
      notificationsPreferences: NotificationsPreferences(
        email: _faker.randomGenerator.boolean(),
        sms: _faker.randomGenerator.boolean(),
      ),
      gender: _faker.randomGenerator.element(Gender.values),
      createdAt: _faker.date.dateTime(minYear: 2024, maxYear: 2024),
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] != null ? json['id'] as String? : null,
      firstName:
          json['first_name'] != null ? json['first_name'] as String? : null,
      lastName: json['last_name'] != null ? json['last_name'] as String? : null,
      createdAt: json['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (json['created_at'] as int) * 1000)
          : null,
      phoneNumber:
          json['phone_number'] != null ? json['phone_number'] as String? : null,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'] as String)
          : null,
      emergencyContact: EmergencyContact.fromJson(json['emergency_contact']),
      notificationsPreferences:
          NotificationsPreferences.fromJson(json['notifications_preferences']),
      referralSource: json['referral_source'] != null
          ? json['referral_source'] as String?
          : null,
      profilePictureUrl: json['profile_picture_url'] != null
          ? json['profile_picture_url'] as String?
          : null,
      address: Address.fromJson(json['address']),
      email: json['email'] != null ? json['email'] as String? : null,
      gender: json['email'] != null
          ? stringToGender(json['email'] as String)
          : null,
    );
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is Customer ? other.id == id : false;

  @override
  String toString() {
    return '''
    Customer(
      id: $id, 
      firstName: $firstName, 
      lastName: $lastName, 
      email: $email, 
      phoneNumber: $phoneNumber, 
      dateOfBirth: $dateOfBirth, 
      address: $address, 
      profilePictureUrl: $profilePictureUrl, 
      emergencyContact: $emergencyContact, 
      referralSource: $referralSource, 
      notificationsPreferences: $notificationsPreferences,
      createdAt: $createdAt
    )
    ''';
  }
}

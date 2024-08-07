import 'package:frontend/features/authentication/data/data_source/index.dart';

/// Defines a User class for the application.
///
/// This is done to decouple the dependency on the [AuthenticationDataSource] user schema.
/// For example, in an implementation update of the user schema from the [AuthenticationDataSourceImpl],
/// only the implementation is changed as the rest of the application i.e this [User] is not coupled
/// to the [AuthenticationDataSourceImpl] class
class User {
  /// The is of the user.
  final String? id;

  // /// The email address of the user.
  // final String? emailAddress;

  const User({
    required this.id,
    // required this.emailAddress,
  });
}

import 'package:frontend/features/authentication/data/index.dart';

class AuthProviderUserUserMapper {
  User? toDomain(Map<String, dynamic>? _) {
    return _ == null
        ? null
        : User(
            id: _["id"],
            // emailAddress: _.email,
          );
  }
}

import 'package:frontend/core/index.dart';
import 'package:frontend/features/core/data/index.dart';
import 'package:frontend/features/core/domain/index.dart';

class GetUserDetails with UseCases<ApiResult<UserDetails>, NoParams> {
  final CoreRepo _repo;

  GetUserDetails(this._repo);

  @override
  Future<ApiResult<UserDetails>> call(NoParams params) {
    return _repo.getUserDetails();
  }
}

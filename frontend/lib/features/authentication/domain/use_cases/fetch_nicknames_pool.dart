import 'package:frontend/core/index.dart';
import 'package:frontend/features/authentication/data/index.dart';
import 'package:frontend/features/authentication/domain/index.dart';

class FetchNicknamesPool
    with UseCases<ApiResult<FetchNicknamesPoolResponse>, NoParams> {
  final AuthenticationRepo _repo;

  FetchNicknamesPool(this._repo);

  @override
  Future<ApiResult<FetchNicknamesPoolResponse>> call(
    NoParams params,
  ) {
    return _repo.fetchNicknamesPool();
  }
}

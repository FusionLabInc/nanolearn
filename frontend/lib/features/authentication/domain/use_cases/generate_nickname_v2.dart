import 'package:frontend/core/index.dart';
import 'package:frontend/features/authentication/data/index.dart';
import 'package:frontend/features/authentication/domain/index.dart';

class GenerateNicknameV2
    with
        UseCases<ApiResult<GenerateNicknameV2Response>,
            GenerateNicknameV2Param> {
  final AuthenticationRepo _repo;

  GenerateNicknameV2(this._repo);

  @override
  Future<ApiResult<GenerateNicknameV2Response>> call(
    GenerateNicknameV2Param params,
  ) {
    return _repo.generateNicknameV2(params);
  }
}

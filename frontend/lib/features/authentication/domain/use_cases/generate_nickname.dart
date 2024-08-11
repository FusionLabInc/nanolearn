import 'package:frontend/core/index.dart';
import 'package:frontend/features/authentication/domain/index.dart';
import 'package:frontend/pb/llm.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class GenerateNickname
    with
        ResponseStreamUseCases<GenerateNicknameResponse,
            GenerateNicknameParam> {
  final AuthenticationRepo _repo;

  GenerateNickname(this._repo);

  @override
  ResponseStream<GenerateNicknameResponse> call(
    GenerateNicknameParam params,
  ) {
    return _repo.generateNickname(params);
  }
}

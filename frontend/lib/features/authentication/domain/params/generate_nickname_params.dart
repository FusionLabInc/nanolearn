import 'dart:async';

import 'package:frontend/pb/llm.pb.dart';

class GenerateNicknameParam {
  /// The registering user's email address.
  final StreamController<GenerateNicknameRequest>
      generatedNicknameRequestStreamController;

  GenerateNicknameParam({
    required this.generatedNicknameRequestStreamController,
  });
}

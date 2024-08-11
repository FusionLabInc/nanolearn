import 'dart:convert';

class GenerateNicknameV2Param {
  final List<String> nicknamesFromPool;

  GenerateNicknameV2Param({
    required this.nicknamesFromPool,
  });

  Map<String, dynamic> toMap() {
    return {
      "nicknames_from_pool": nicknamesFromPool,
    };
  }

  String toJson() => json.encode(toMap());
}

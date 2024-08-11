//
//  Generated code. Do not modify.
//  source: llm.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GenerateNicknameRequest extends $pb.GeneratedMessage {
  factory GenerateNicknameRequest({
    $core.Iterable<$core.String>? selectedNicknamesFromPool,
  }) {
    final $result = create();
    if (selectedNicknamesFromPool != null) {
      $result.selectedNicknamesFromPool.addAll(selectedNicknamesFromPool);
    }
    return $result;
  }
  GenerateNicknameRequest._() : super();
  factory GenerateNicknameRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateNicknameRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateNicknameRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'llm'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'selectedNicknamesFromPool', protoName: 'selectedNicknamesFromPool')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateNicknameRequest clone() => GenerateNicknameRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateNicknameRequest copyWith(void Function(GenerateNicknameRequest) updates) => super.copyWith((message) => updates(message as GenerateNicknameRequest)) as GenerateNicknameRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateNicknameRequest create() => GenerateNicknameRequest._();
  GenerateNicknameRequest createEmptyInstance() => create();
  static $pb.PbList<GenerateNicknameRequest> createRepeated() => $pb.PbList<GenerateNicknameRequest>();
  @$core.pragma('dart2js:noInline')
  static GenerateNicknameRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateNicknameRequest>(create);
  static GenerateNicknameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get selectedNicknamesFromPool => $_getList(0);
}

class GenerateNicknameResponse extends $pb.GeneratedMessage {
  factory GenerateNicknameResponse({
    $core.String? nickname,
  }) {
    final $result = create();
    if (nickname != null) {
      $result.nickname = nickname;
    }
    return $result;
  }
  GenerateNicknameResponse._() : super();
  factory GenerateNicknameResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GenerateNicknameResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GenerateNicknameResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'llm'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nickname')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GenerateNicknameResponse clone() => GenerateNicknameResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GenerateNicknameResponse copyWith(void Function(GenerateNicknameResponse) updates) => super.copyWith((message) => updates(message as GenerateNicknameResponse)) as GenerateNicknameResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GenerateNicknameResponse create() => GenerateNicknameResponse._();
  GenerateNicknameResponse createEmptyInstance() => create();
  static $pb.PbList<GenerateNicknameResponse> createRepeated() => $pb.PbList<GenerateNicknameResponse>();
  @$core.pragma('dart2js:noInline')
  static GenerateNicknameResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GenerateNicknameResponse>(create);
  static GenerateNicknameResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get nickname => $_getSZ(0);
  @$pb.TagNumber(1)
  set nickname($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNickname() => $_has(0);
  @$pb.TagNumber(1)
  void clearNickname() => clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');

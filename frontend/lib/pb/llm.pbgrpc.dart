//
//  Generated code. Do not modify.
//  source: llm.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'llm.pb.dart' as $0;

export 'llm.pb.dart';

@$pb.GrpcServiceName('llm.LlmService')
class LlmServiceClient extends $grpc.Client {
  static final _$generateNickname = $grpc.ClientMethod<$0.GenerateNicknameRequest, $0.GenerateNicknameResponse>(
      '/llm.LlmService/GenerateNickname',
      ($0.GenerateNicknameRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GenerateNicknameResponse.fromBuffer(value));

  LlmServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseStream<$0.GenerateNicknameResponse> generateNickname($async.Stream<$0.GenerateNicknameRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$generateNickname, request, options: options);
  }
}

@$pb.GrpcServiceName('llm.LlmService')
abstract class LlmServiceBase extends $grpc.Service {
  $core.String get $name => 'llm.LlmService';

  LlmServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GenerateNicknameRequest, $0.GenerateNicknameResponse>(
        'GenerateNickname',
        generateNickname,
        true,
        true,
        ($core.List<$core.int> value) => $0.GenerateNicknameRequest.fromBuffer(value),
        ($0.GenerateNicknameResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$0.GenerateNicknameResponse> generateNickname($grpc.ServiceCall call, $async.Stream<$0.GenerateNicknameRequest> request);
}

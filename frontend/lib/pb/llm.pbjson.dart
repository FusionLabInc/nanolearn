//
//  Generated code. Do not modify.
//  source: llm.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use generateNicknameRequestDescriptor instead')
const GenerateNicknameRequest$json = {
  '1': 'GenerateNicknameRequest',
  '2': [
    {'1': 'selectedNicknamesFromPool', '3': 1, '4': 3, '5': 9, '10': 'selectedNicknamesFromPool'},
  ],
};

/// Descriptor for `GenerateNicknameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateNicknameRequestDescriptor = $convert.base64Decode(
    'ChdHZW5lcmF0ZU5pY2tuYW1lUmVxdWVzdBI8ChlzZWxlY3RlZE5pY2tuYW1lc0Zyb21Qb29sGA'
    'EgAygJUhlzZWxlY3RlZE5pY2tuYW1lc0Zyb21Qb29s');

@$core.Deprecated('Use generateNicknameResponseDescriptor instead')
const GenerateNicknameResponse$json = {
  '1': 'GenerateNicknameResponse',
  '2': [
    {'1': 'nickname', '3': 1, '4': 1, '5': 9, '10': 'nickname'},
  ],
};

/// Descriptor for `GenerateNicknameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List generateNicknameResponseDescriptor = $convert.base64Decode(
    'ChhHZW5lcmF0ZU5pY2tuYW1lUmVzcG9uc2USGgoIbmlja25hbWUYASABKAlSCG5pY2tuYW1l');


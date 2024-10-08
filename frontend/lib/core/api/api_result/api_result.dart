import 'package:frontend/core/index.dart';
// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({required T data}) = Success<T>;

  const factory ApiResult.apiFailure({
    required ApiExceptions error,
    @Default(-1) int statusCode,
  }) = Failure<T>;
}

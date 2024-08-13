// ignore_for_file: avoid_dynamic_calls, unused_local_variable

import 'package:frontend/core/index.dart';
import 'package:frontend/features/core/data/index.dart';
import 'package:frontend/features/core/domain/index.dart';
import 'package:dartz/dartz.dart';

class CoreDataSourceImpl implements CoreDataSource {
  final _getUserDetails = '/backend/user';

  // ignore: unused_field
  final NLApiClient _apiClient;
  // ignore: unused_field
  final String _baseApiUrl;

  CoreDataSourceImpl(
    this._apiClient,
    this._baseApiUrl,
  );

  @override
  Future<Option<String>> uploadImageToFirebaseStorage(
    UploadImageParam params,
  ) async {
    return Future.value(optionOf("downloadURL"));
  }

  @override
  Future<UserDetails> getUserDetails() async {
    final response = await _apiClient.get(
      '$_baseApiUrl$_getUserDetails',
    );

    final data = response.data;

    final userDetails =
        UserDetails.fromJson(data["data"] as Map<String, dynamic>);
    return userDetails;
  }
}

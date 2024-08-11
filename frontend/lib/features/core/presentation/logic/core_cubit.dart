import 'package:frontend/core/index.dart';
import 'package:frontend/utils/index.dart';
import 'package:bloc/bloc.dart';
import 'package:frontend/features/authentication/presentation/index.dart';
import 'package:frontend/features/core/domain/index.dart';
import 'package:equatable/equatable.dart';

part 'core_state.dart';

class CoreCubit extends Cubit<CoreState>
    implements OnAppStartLazy, OnAppStartPriority, OnAppLogout {
  UploadImageToFirebaseStorage uploadImageToFirebaseStorage;
  GetUserDetails getUserDetails;

  CoreCubit(
    this.uploadImageToFirebaseStorage,
    this.getUserDetails,
  ) : super(CoreInitial());

  String? username;
  String? superadminCompanyName;

  Future<bool> uploadImageToFirebaseStorageLogic(
    UploadImageParam params,
  ) async {
    final response = await uploadImageToFirebaseStorage(params);
    return response.maybeWhen(
      success: (data) => data.fold(
        () => false,
        (value) {
          return true;
        },
      ),
      apiFailure: (exception, _) => false,
      orElse: () => false,
    );
  }

  Future getUserDetailsLogic() async {
    emit(CoreLoading());
    final _ = NoParams();
    final response = await getUserDetails(_);
    return response.maybeWhen(
      success: (data) async {
        username = data.username;
        emit(CoreLoaded(data: data));
        return data;
      },
      apiFailure: (exception, _) =>
          emit(CoreError(ApiExceptions.getErrorMessage(exception))),
      orElse: () => emit(const CoreError(AppConstants.defaultErrorMessage)),
    );
  }

  @override
  Future<void> onAppStartLazy() async {
    return Future.value();
  }

  @override
  Future<void> onAppStartPriority() async {
    await getUserDetailsLogic();
  }

  @override
  Future<void> onAppLogout() {
    return Future.value();
  }
}

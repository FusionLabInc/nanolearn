import 'package:equatable/equatable.dart';
import 'package:grpc/grpc.dart';

///[Future].
mixin UseCases<T, Params> {
  Future<T> call(Params params);
}

///[Streams].
mixin StreamUseCases<T, Params> {
  Stream<T> call(Params params);
}

///[NoParams]
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

///[ResponseStream].
mixin ResponseStreamUseCases<T, Params> {
  ResponseStream<T> call(Params params);
}

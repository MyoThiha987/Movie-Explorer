import 'package:flutter_architecture/core/data_state/resource.dart';

abstract class BaseUseCase<In, Out> {
  Future<Resource<Out>> execute(In input);
}

abstract class BaseNormalUseCase<In, Out> {
  Future<Out> execute(In input);
}

abstract class BaseStreamUseCase<In, Out> {
  Stream<Out> execute(In input);
}

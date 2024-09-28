import 'package:flutter_architecture/core/data_state/resource.dart';

abstract class BaseUseCase<In, Out> {
  Future<Resource<Out>> execute(In input);
}

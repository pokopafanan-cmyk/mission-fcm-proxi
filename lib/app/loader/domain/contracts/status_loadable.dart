import 'package:equatable/equatable.dart';
import '../../../../core/config/enums.dart';
import 'loadable_state.dart';

abstract class StatusLoadable extends Equatable implements LoadableState {

  Status get status;

  @override
  bool get isLoading => status == Status.loading;

  @override
  bool get isFinished => status == Status.success || status == Status.failure;
}



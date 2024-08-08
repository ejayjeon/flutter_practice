import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miner_skale_proto/actions/actionables.dart';

abstract class BasicCubit extends Cubit<Actionables> {
  BasicCubit({Actionables? initState}) : super(initState ?? Actionables.undefined);

  void onPressed(Actionables userAction) {
    emit(userAction);
  }
}
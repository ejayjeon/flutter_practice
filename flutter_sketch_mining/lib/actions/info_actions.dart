import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miner_skale_proto/actions/displayable.dart';
import 'package:miner_skale_proto/mixins/logger_mixin.dart';

class InfoAction extends Cubit<Displayable> with LoggerMixin {
  InfoAction({Displayable? initState}) : super(initState ?? Displayable.undefined);


  String _text = 'System not started';
  String get ms => _text;

  @override
  void onChange(Change<Displayable> change) {
    super.onChange(change);

    switch(change.currentState) {

      case Displayable.appReady: {
        _text = 'system is ready';
        break;
      }

      case Displayable.miningGasBeg: {
        _text = 'Mining job started in background mode';
        break;
      }
      case Displayable.miningGasProc: {
        _text = "Mining gas... This may take awhile";
        break;
      }
      case Displayable.miningGasEnd: {
        _text = "Mining job finished";
        break;
      }
      
      default: {
        _text = 'Something went wrong';
      }
    }
  }

}
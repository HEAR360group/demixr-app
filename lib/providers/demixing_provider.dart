import 'package:demixr_app/helpers/demixing_helper.dart';
import 'package:demixr_app/models/song.dart';
import 'package:demixr_app/models/unmixed_song.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class DemixingProvider extends ChangeNotifier {
  final _helper = DemixingHelper();
  bool _isDemixing = false;
  CancelableOperation<UnmixedSong>? _operation;

  bool get isDemixing => _isDemixing;

  _setStatus({required bool isDemixing}) {
    if (_isDemixing != isDemixing) {
      _isDemixing = isDemixing;
      notifyListeners();
    }
  }

  CancelableOperation<UnmixedSong>? unmix(Song song) {
    _setStatus(isDemixing: true);
    _operation =
        CancelableOperation<UnmixedSong>.fromFuture(_helper.separate(song));
    return _operation;
  }

  void cancelDemixing() {
    _operation?.cancel();
    _setStatus(isDemixing: false);
  }
}
import 'package:contest_app/src/src.dart';

class ModelProviders extends ChangeNotifier {
  ///bottom nav counter
  int _bottomCounter = 0;
  int get bottomCounter => _bottomCounter;

  //
  void changeCounter(int value) {
    _bottomCounter = value;
    notifyListeners();
  }
}

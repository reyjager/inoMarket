import 'package:inomarket/helper/position.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class HomeViewmodel extends BaseViewModel {
  bool _isBalanceVisible = true;
  bool get isBalanceVisible => _isBalanceVisible;

  HomeViewmodel() {
    initPosition();
  }

  void toggleBalanceVisibility() {
    _isBalanceVisible = !_isBalanceVisible;
    notifyListeners();
  }

  initPosition() async {
    await Permission.notification.request();
    // await Geolocator.requestPermission();
    // UserCurrentPosition.currentPosition = await Geolocator.getCurrentPosition();
    // notificationList = await NotificationService().getAllNotification();
  }
}

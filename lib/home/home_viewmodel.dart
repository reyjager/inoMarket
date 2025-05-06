import 'package:inomarket/helper/position.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class HomeViewmodel extends BaseViewModel {
  HomeViewModel() {
    initPosition();
  }

  initPosition() async {
    await Permission.notification.request();
    // await Geolocator.requestPermission();
    // UserCurrentPosition.currentPosition = await Geolocator.getCurrentPosition();
    // notificationList = await NotificationService().getAllNotification();
  }
}

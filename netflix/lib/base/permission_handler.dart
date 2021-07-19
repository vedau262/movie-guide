import 'package:netflix/utilities.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService{

  // You can request multiple permissions at once.
  Future<bool> _requestPermission() async {
    // You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
      Permission.contacts,
      Permission.storage,
      //add more permission to request here.
    ].request();

    if(statuses[Permission.location]!.isDenied){ //check each permission status after.
      logDebug("Location permission is denied.");
      return false;
    }

    if(statuses[Permission.contacts]!.isDenied){ //check each permission status after.
      logDebug("Contacts permission is denied.");
      return false;
    }

    if(statuses[Permission.camera]!.isDenied){ //check each permission status after.
      logDebug("Camera permission is denied.");
      return false;
    }

    if(statuses[Permission.storage]!.isDenied){ //check each permission status after.
      logDebug("ManageExternalStorage permission is denied.");
      return false;
    }

    return true;
  }

  Future<bool> requestPermission({required Function onPermissionDenied}) async {
    var granted = await _requestPermission();
    if (!granted) {
      onPermissionDenied();
    } else {
      logDebug("All permission is granted!!!");
    }
    return granted;
  }
}
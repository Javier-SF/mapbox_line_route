// //=========================Funcion para menejar los permissos al iniciar la app=====================
import 'package:permission_handler/permission_handler.dart';

Future<bool> handleLocationPermission() async {
  PermissionStatus permissionStatus = await Permission.location.status;

  if (permissionStatus.isGranted) {
    return true; // Permiso concedido
  }

  // Solicitar permisos si están denegados o no determinados
  permissionStatus = await Permission.location.request();

  return permissionStatus.isGranted;
}
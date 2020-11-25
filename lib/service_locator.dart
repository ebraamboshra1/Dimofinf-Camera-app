import 'package:camera/camera.dart';
import 'package:get_it/get_it.dart';

final GetIt sL = GetIt.I;

Future<void> setupLocators(cameras) async {
  final List<CameraDescription> camerass = cameras;
  sL.registerSingleton<List<CameraDescription>>(camerass);

}

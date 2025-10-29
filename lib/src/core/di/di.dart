import 'package:get_it/get_it.dart';
import 'package:e_comm/src/core/di/di.config.dart';
import 'package:e_comm/src/core/routes/route_config.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.init(); // Auto-generated Injectable setup
  getIt.registerSingleton<AppRouteConf>(AppRouteConf()); // Manual registration
}
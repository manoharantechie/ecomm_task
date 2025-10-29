
import 'package:e_comm/src/core/routes/route_config.dart';

import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

void injectionSetup() {
  getIt.registerSingleton<AppRouteConf>(AppRouteConf());

}
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:e_comm/src/features/domain/cubit/cart/cart_cubit.dart' as _i745;
import 'package:e_comm/src/features/domain/cubit/product/product_cubit.dart'
    as _i776;
import 'package:e_comm/src/features/domain/db_service/cart_db_service.dart'
    as _i1064;
import 'package:e_comm/src/features/domain/db_service/db_services.dart'
    as _i381;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i1064.CartDatabaseService>(
      () => _i1064.CartDatabaseService(),
    );
    gh.singleton<_i381.DatabaseService>(() => _i381.DatabaseService());
    gh.factory<_i776.ProductCubit>(
      () => _i776.ProductCubit(gh<_i381.DatabaseService>()),
    );
    gh.factory<_i745.CartCubit>(
      () => _i745.CartCubit(gh<_i1064.CartDatabaseService>()),
    );
    return this;
  }
}

import 'package:flutter_clean_architecture/rounter/app_route_config.dart';

import '../../../features/auth/di/auth_dependency.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../../../core/cubits_blocs/app_user/app_user_cubit.dart';
import '../../../core/network/connection_checker.dart';
import '../../core/secrets/shared_preference.dart';
import '../../core/theme/theme_bloc/theme_bloc.dart';
import '../../core/theme/theme_provider.dart';
import '../../rounter/app_route_utils.dart';
part 'init_dependencies.main.dart';
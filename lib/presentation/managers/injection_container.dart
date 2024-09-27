import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../data/data_sources/remote_data_source.dart';
import '../../data/repositories/news_repository_impl.dart';
import '../../data/services/api_client.dart';
import '../../domain/repositories/news_repository.dart';
import '../../domain/use_cases/get_market_news.dart';
import '../utils/helpers/url_launcher_utils.dart';
import 'local_storage_manager.dart';
import 'permission_handler_helper.dart';


final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register apiClient
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));

  // Register data source
  getIt.registerLazySingleton<NewsDataSource>(() => NewsDataSourceImpl(getIt<ApiClient>()));

  // Register repository
  getIt.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(getIt<NewsDataSource>()));

  // Register use case
  getIt.registerLazySingleton<GetMarketNews>(() => GetMarketNews(getIt<NewsRepository>()));

  // Register urlLauncherUtil
  getIt.registerLazySingleton<UrlLauncherUtils>(() => UrlLauncherUtils());

  // Register sharedPreferencesService
  getIt.registerLazySingleton<SharedPreferencesService>(() => SharedPreferencesService());

  // Register permission handling
  getIt.registerLazySingleton<PermissionHandlingHelper>(() => PermissionHandlingHelper());
}



import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

class CustomCacheManager extends BaseCacheManager {
  static const int maxNumberOfFiles = 10;
  static const Duration cacheTimeout = Duration(seconds: kDebugMode ? 10: 7200);
  static const key = "myCache";
  CustomCacheManager() : super(key,
    maxNrOfCacheObjects:maxNumberOfFiles,
      maxAgeCacheObject : cacheTimeout
  );
  @override
  Future<String> getFilePath() async {
    var tempDirectory = await getTemporaryDirectory();
    return tempDirectory.path;
  }
}

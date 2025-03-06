/// value = App Module
const String CONFIG_APPLICATION = "config_application";

/// value = Map<String, ModuleEntity> 所有模块的配置
const String CONFIG_ALL_MODULES = "config_application";

/// value = Map<String, ModuleEntity>
/// 被选中处理的模块
const String CONFIG_OPERATE_MODULES = "config_modules";

/// value = String
const String CONFIG_PIPELINE_WORKSPACE = "config_pipeline_workspace";

/// value = Map<String, String>
const String CONFIG_PIPELINE_ENVIRONMENT = "config_pipeline_environment";

/// value = String
const String CONFIG_PIPELINE_BUILD_ID = "config_pipeline_build_id";

/// value = String
const String CONFIG_ENV_ANDROID_HOME = 'ANDROID_HOME';

/// value = String
const String CONFIG_ENV_JAVA_HOME = 'JAVA_HOME';

abstract class Environment {
  String get androidHome;

  String get javaHome;
}
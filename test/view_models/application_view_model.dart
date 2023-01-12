import 'package:elearning/core/navigator/top_screen/top_screen_routes.dart';
import 'package:elearning/core/utils/info_utils.dart';
import 'package:elearning/view_models/base_view_model.dart';

class ApplicationViewModel extends BaseViewModel {
  Future<void> destroySingletonObject() async {
    _destroyRouteInstance();
    // SharedPreference
    _destroySharedPreferenceInstance();
    // InfoUtils
    _destroyInfoUtils();
  }

  void _destroyRouteInstance() {
    TopScreenRoutes().destroyInstance();
  }

  void _destroySharedPreferenceInstance() {
    // TODO(後で処理する)
  }

  void _destroyInfoUtils() {
    InfoUtils().destroyInstance();
  }
}

import 'package:get/get.dart';
import 'package:samwise/app/bindings/add_client_page_bindings.dart';
import 'package:samwise/app/bindings/client_detail_bindings.dart';
import 'package:samwise/app/bindings/home_view_bindings.dart';
import 'package:samwise/app/routes/app_routes.dart';
import 'package:samwise/app/views/add_client_view.dart';
import 'package:samwise/app/views/client_detail_view.dart';
import 'package:samwise/app/views/home_view.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeView(),
      binding: HomeViewBindings(),
    ),
    GetPage(
      name: AppRoutes.CLIENT,
      page: () => ClientDetailView(),
      binding: ClientDetailBindings(),
    ),
    GetPage(
      name: AppRoutes.ADD_CLIENT,
      page: () => AddClientView(),
      binding: AddClientPageBindings(),
    ),
  ];
}

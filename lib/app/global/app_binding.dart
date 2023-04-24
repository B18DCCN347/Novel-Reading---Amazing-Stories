import 'package:get/get.dart';
import 'package:love_novel/app/global/controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppController());
  }
}

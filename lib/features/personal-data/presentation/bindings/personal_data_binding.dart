import 'package:get/get.dart';
import 'package:path_earn_app/features/personal-data/presentation/controllers/personal_data_controller.dart';

class PersonalDataBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PersonalDataController>(() => PersonalDataController());
  }
}
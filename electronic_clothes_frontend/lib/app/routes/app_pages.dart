import 'package:electronic_clothes_frontend/app/modules/anonymous_user_details_page/bindings/anonymous_user_details_page_bindings.dart';
import 'package:electronic_clothes_frontend/app/modules/anonymous_user_details_page/controllers/anonymous_user_details_page_controllers.dart';
import 'package:electronic_clothes_frontend/app/modules/anonymous_user_details_page/views/anonymous_user_details_page_view.dart';
import 'package:get/get.dart';

import '../modules/clothes_detail_page/bindings/clothes_detail_page_binding.dart';
import '../modules/clothes_detail_page/views/clothes_detail_page_view.dart';
import '../modules/clothes_page/bindings/clothes_page_binding.dart';
import '../modules/clothes_page/views/clothes_page_view.dart';
import '../modules/contacts_page/bindings/contacts_page_binding.dart';
import '../modules/contacts_page/views/contacts_page_view.dart';
import '../modules/document_page/bindings/document_page_binding.dart';
import '../modules/document_page/views/document_page_view.dart';
import '../modules/document_summarization_page/bindings/document_summarization_page_binding.dart';
import '../modules/document_summarization_page/views/document_summarization_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/medical_reports_page/bindings/medical_reports_page_binding.dart';
import '../modules/medical_reports_page/views/medical_reports_page_view.dart';
import '../modules/register_page/bindings/register_page_binding.dart';
import '../modules/register_page/views/register_page_view.dart';
import '../modules/user_details_page/bindings/user_details_page_binding.dart';
import '../modules/user_details_page/views/user_details_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.USER_DETAILS_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.USER_DETAILS_PAGE,
      page: () => const UserDetailsPageView(),
      binding: UserDetailsPageBinding(),
    ),
    GetPage(
      name: _Paths.DOCUMENT_PAGE,
      page: () => const DocumentPageView(),
      binding: DocumentPageBinding(),
    ),
    GetPage(
      name: _Paths.MEDICAL_REPORTS_PAGE,
      page: () => const MedicalReportsPageView(),
      binding: MedicalReportsPageBinding(),
    ),
    GetPage(
      name: _Paths.CLOTHES_PAGE,
      page: () => const ClothesPageView(),
      binding: ClothesPageBinding(),
    ),
    GetPage(
      name: _Paths.CLOTHES_DETAIL_PAGE,
      page: () => const ClothesDetailPageView(),
      binding: ClothesDetailPageBinding(),
    ),
    GetPage(
      name: _Paths.CONTACTS_PAGE,
      page: () => const ContactsPageView(),
      binding: ContactsPageBinding(),
    ),
    GetPage(
      name: _Paths.DOCUMENT_SUMMARIZATION_PAGE,
      page: () => const DocumentSummarizationPageView(),
      binding: DocumentSummarizationPageBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_PAGE,
      page: () => const RegisterPageView(),
      binding: RegisterPageBinding(),
    ),
    GetPage(
      name: _Paths.ANONYMOUS_USER_DETAILS_PAGE,
      page: () => const AnonymousUserDetailsPageView(),
      binding: AnonymousUserDetailsPageBindings(),
    ),
  ];
}

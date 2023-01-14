import 'package:get/get.dart';

import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/dosen-dashboard/bindings/dosen_dashboard_binding.dart';
import '../modules/dosen-dashboard/views/dosen_dashboard_view.dart';
import '../modules/laporan/bindings/laporan_binding.dart';
import '../modules/laporan/views/laporan_view.dart';
import '../modules/log-book/bindings/log_book_binding.dart';
import '../modules/log-book/views/log_book_view.dart';
import '../modules/magang-participant/bindings/magang_participant_binding.dart';
import '../modules/magang-participant/views/magang_participant_view.dart';
import '../modules/participant-score/bindings/participant_score_binding.dart';
import '../modules/participant-score/views/participant_score_view.dart';
import '../modules/presensi/bindings/presensi_binding.dart';
import '../modules/presensi/views/presensi_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      title: 'login',
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      title: 'menu_dashboard',
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.PRESENSI,
      title: 'pdf_file',
      page: () => PresensiView(),
      binding: PresensiBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN,
      title: 'menu_task',
      page: () => LaporanView(),
      binding: LaporanBinding(),
    ),
    GetPage(
      name: _Paths.DOSEN_DASHBOARD,
      title: 'dosen_Dashboard',
      page: () => DosenDashboardView(),
      binding: DosenDashboardBinding(),
    ),
    GetPage(
      name: _Paths.MAGANG_PARTICIPANT,
      title: 'dosen_partisipan_magang',
      page: () => MagangParticipantView(),
      binding: MagangParticipantBinding(),
    ),
    GetPage(
      name: _Paths.LOG_BOOK,
      title: 'dosen_log_book',
      page: () => LogBookView(),
      binding: LogBookBinding(),
    ),
    GetPage(
      name: _Paths.PARTICIPANT_SCORE,
      title: 'dosen_participant_score',
      page: () => ParticipantScoreView(),
      binding: ParticipantScoreBinding(),
    ),
  ];
}

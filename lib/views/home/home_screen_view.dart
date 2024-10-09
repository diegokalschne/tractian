import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../constants/assets/assets_path.dart';
import '../../constants/routes/local_routes.dart';
import '../../models/company/company_model.dart';
import '../../stores/companies/companies_store.dart';
import '../../widgets/cs_app_bar.dart';
import '../../widgets/cs_elevated_button.dart';
import '../../widgets/cs_loading_progress.dart';
import '../../widgets/cs_refresh_indicator.dart';
import '../../widgets/has_error_widget.dart';
import '../../widgets/no_info_widget.dart';
import '../../widgets/no_wifi_widget.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final companiesStore = CompaniesStore();

  @override
  void initState() {
    super.initState();

    companiesStore.fetchCompanies();
  }

  void onTapCompany(CompanyModel company) {
    Navigator.of(context).pushNamed(LocalRoutes.ASSETS, arguments: company);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CsAppBar.image(
        imagePath: AssetsPath.LOGO_TRACTIAN,
        color: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Observer(
          builder: (_) {
            if (companiesStore.loading) {
              return const CsLoadingProgress.fetching();
            }

            if (!companiesStore.hasInternet) {
              return NoWifiWidget(callback: companiesStore.fetchCompanies);
            }

            if (companiesStore.hasError) {
              return HasErrorWidget(callback: () => companiesStore.fetchCompanies(forceSynk: true));
            }

            if (companiesStore.companies.isEmpty && !companiesStore.loading) {
              return NoInfoWidget(
                message: 'Nenhuma companhia encontrada',
                callback: () => companiesStore.fetchCompanies(forceSynk: true),
                labelCallback: 'TENTAR NOVAMENTE',
              );
            }

            return CsRefreshIndicator(
              onRefresh: () => companiesStore.fetchCompanies(forceSynk: true),
              child: ListView.separated(
                itemCount: companiesStore.companies.length,
                itemBuilder: (_, index) {
                  final company = companiesStore.companies[index];

                  return Padding(
                    padding: EdgeInsets.only(top: index == 0 ? 25 : 0),
                    child: CsElevatedButton.expanded(
                      label: company.name,
                      icon: Image.asset(AssetsPath.COMPANY_ICON, width: 30),
                      height: 70,
                      onPressed: () => onTapCompany(company),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 30),
              ),
            );
          },
        ),
      ),
    );
  }
}

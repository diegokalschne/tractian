import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../models/assets/asset_model.dart';
import '../../models/company/company_model.dart';
import '../../models/filters/assets_filter.dart';
import '../../services/service_locator.dart';
import '../../stores/assets-locations/assets_locations_store.dart';
import '../../stores/tree/tree_store.dart';
import '../../utils/debouncer.dart';
import '../../utils/function_utils.dart';
import '../../widgets/cs_app_bar.dart';
import '../../widgets/cs_elevated_button.dart';
import '../../widgets/cs_loading_progress.dart';
import '../../widgets/cs_refresh_indicator.dart';
import '../../widgets/cs_text_form_field.dart';
import '../../widgets/cs_toggle_button.dart';
import '../../widgets/dialog/content_info_assets_widget.dart';
import '../../widgets/has_error_widget.dart';
import '../../widgets/no_info_widget.dart';
import '../../widgets/no_wifi_widget.dart';
import '../../widgets/tree_widget.dart';

class AssetsView extends StatefulWidget {
  const AssetsView({
    required this.company,
    super.key,
  });

  final CompanyModel company;

  @override
  State<AssetsView> createState() => _AssetsViewState();
}

class _AssetsViewState extends State<AssetsView> {
  final assetsLocationsStore = AssetsLocationsStore();
  final treeStore = TreeStore();

  final filters = locator<AssetsFilter>();

  final debouncer = Debouncer(milliseconds: 200);
  final whereController = TextEditingController();

  @override
  void initState() {
    super.initState();

    fetchAssetsAndBuildTree();
  }

  @override
  void dispose() {
    whereController.dispose();
    filters.clearFilters();

    super.dispose();
  }

  Future<void> fetchAssetsAndBuildTree({bool forceSynk = false}) async {
    await assetsLocationsStore.fetchAssetsAndLocations(widget.company);

    treeStore.buildTree(assetsLocationsStore.assetsAndLocations);
  }

  void onLongPressNode(AssetLocationBaseModel node) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ContentInfoAssetsWidget(node: node);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CsAppBar(
        title: 'Assets',
        subtitle: widget.company.name,
      ),
      body: Observer(
        builder: (_) {
          if (assetsLocationsStore.loading || treeStore.loading) {
            return const CsLoadingProgress.fetching();
          }

          if (!assetsLocationsStore.hasInternet) {
            return NoWifiWidget(callback: fetchAssetsAndBuildTree);
          }

          if (assetsLocationsStore.hasError) {
            return HasErrorWidget(callback: () => fetchAssetsAndBuildTree(forceSynk: true));
          }

          if (assetsLocationsStore.assetsAndLocations.isEmpty && !assetsLocationsStore.loading) {
            return NoInfoWidget(
              message: 'Nenhum asset encontrado',
              callback: () => fetchAssetsAndBuildTree(forceSynk: true),
              labelCallback: 'TENTAR NOVAMENTE',
            );
          }

          return Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CsTextFormField(
                  hintText: 'Buscar ativo ou local',
                  prefixIcon: const Icon(Icons.search),
                  controller: whereController,
                  onChanged: (value) {
                    debouncer(() {
                      filters.setWhere(value);
                    });
                  },
                  suffixIcon: clearField(
                    value: filters.where,
                    onClear: () {
                      filters.setWhere(null);
                      whereController.clear();
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Observer(
                      builder: (_) {
                        return CsToggleButton(
                          toggled: filters.energySensor,
                          label: 'Sensor de Energia',
                          icon: const Icon(Icons.electric_bolt_rounded),
                          onToggle: (value) {
                            debouncer(() {
                              filters.setEnergySensor();
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    Observer(
                      builder: (_) {
                        return CsToggleButton(
                          label: 'Crítico',
                          toggled: filters.criticalStatus,
                          icon: const Icon(Icons.error_outline_rounded),
                          onToggle: (value) {
                            debouncer(() {
                              filters.setCriticalStatus();
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Divider(
                color: theme.colorScheme.primaryContainer,
                thickness: 2,
              ),
              Expanded(
                child: Observer(
                  builder: (_) {
                    if (treeStore.treeList.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Nenhum ativo corresponde a sua pesquisa',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: CsElevatedButton.expanded(
                                label: 'Limpar Filtros',
                                onPressed: () {
                                  filters.clearFilters();
                                  whereController.clear();
                                },
                                alignment: Alignment.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return CsRefreshIndicator(
                      onRefresh: () async {
                        filters.clearFilters();
                        fetchAssetsAndBuildTree(forceSynk: true);
                      },
                      child: ListView.builder(
                        itemCount: treeStore.treeList.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final node = treeStore.treeList[index];

                          return TreeWidget(
                            key: UniqueKey(),
                            node: node,
                            onLongPressNode: onLongPressNode,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

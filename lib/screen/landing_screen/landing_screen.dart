part of 'index.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LandingScreenCubit, LandingScreenState>(
      listener: (context, state) {
        if (state is LandingScreenRowTappedState) {
          Navigator.pushNamed(context, RouteConstants.startedRepoDetailScreen,
              arguments: {'url': state.url});
        } else if (state is LandingScreenFailureState) {
          SnackBarUti.showErorSnackBar(
              context, state.errorMessage.isNotEmpty ? state.errorMessage : 'Error Occurred');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColorsConfig.primary,
          appBar: const SharedAppBar(
              title: 'Repositories',
              leading: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SvgIcon(
                  icon: AppConstants.githubIcon,
                  color: AppColorsConfig.surface,
                ),
              )),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: state is LandingScreenLoadingState
                ? const Center(
                    child: CustomCircularProgressIndicator(
                        size: 40.0,
                        strokeWidth: 6.0,
                        color: AppColorsConfig.primaryDark,
                        backgroundColor: AppColorsConfig.background),
                  )
                : context.read<LandingScreenCubit>().staredGithubRepoList.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                              child: DataTable2(
                            columnSpacing: 12,
                            horizontalMargin: 12,
                            minWidth: 600,
                            showCheckboxColumn: false,
                            sortAscending: context.read<LandingScreenCubit>().sortDirectionAced,
                            sortArrowBuilder: (localContext, statex) {
                              return Icon(
                                context.read<LandingScreenCubit>().sortDirectionAced
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                size: 14,
                                color: AppColorsConfig.surface,
                              );
                            },
                            columns: [
                              DataColumn(
                                  label: const Text(
                                    'Repo Star',
                                    style: TextStyle(color: AppColorsConfig.surface),
                                  ),
                                  onSort: context.read<LandingScreenCubit>().onSortCallBack),
                              const DataColumn2(
                                label: Text(
                                  'Repo Id',
                                  style: TextStyle(color: AppColorsConfig.surface),
                                ),
                                size: ColumnSize.L,
                              ),
                              const DataColumn(
                                label: Text(
                                  'Repo Name',
                                  style: TextStyle(color: AppColorsConfig.surface),
                                ),
                              ),
                            ],
                            rows: List<DataRow>.generate(
                                context.read<LandingScreenCubit>().staredGithubRepoList.length,
                                (index) {
                              StaredGithubRepoListModel item =
                                  context.read<LandingScreenCubit>().staredGithubRepoList[index];
                              return _rowBuilder(context, item);
                            }),
                          )),
                        ],
                      )
                    : Container(),
          ),
        );
      },
    );
  }

  //used to build the row component of the table; Helper Method
  DataRow _rowBuilder(BuildContext context, StaredGithubRepoListModel item) {
    return DataRow(
      onSelectChanged: (selected) => context.read<LandingScreenCubit>().onTap(selected, item.url),
      cells: [
        DataCell(
          Row(
            children: [
              const Icon(
                Icons.star,
                color: AppColorsConfig.accent,
                size: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                item.stargazers_count.toString(),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            item.id.toString(),
          ),
        ),
        DataCell(
          Text(item.name.toString()),
        ),
      ],
    );
  }
}

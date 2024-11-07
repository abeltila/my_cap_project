part of 'index.dart';

//StartedRepoDetailScreen displays the repo detail wit the image and detail information
class StartedRepoDetailScreen extends StatelessWidget {
  const StartedRepoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StaredRepoDetailScreenCubit, StaredRepoDetailScreenState>(
      listener: (context, state) {
        if (state is StaredRepoDetailScreenFailure) {
          SnackBarUti.showErorSnackBar(
              context, state.errorMessage.isNotEmpty ? state.errorMessage : 'Error Occurred');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColorsConfig.primary,
          appBar: SharedAppBar(
            title: "Repo Detail",
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: AppColorsConfig.surface,
                size: 18,
              ),
            ),
          ),
          body: state is StaredRepoDetailScreenLoading
              ? const Center(
                  child: CustomCircularProgressIndicator(
                      size: 40.0,
                      strokeWidth: 6.0,
                      color: AppColorsConfig.primaryDark,
                      backgroundColor: AppColorsConfig.background),
                )
              : state is StaredRepoDetailScreenSuccess && state.repoDetail != null
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: kToolbarHeight - 20,
                          ),
                          Text(
                            state.repoDetail!.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context
                                .read<StaredRepoDetailScreenCubit>()
                                .openUrl(state.repoDetail!.html_url),
                            child: Text(
                              state.repoDetail!.html_url,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ImageViewer(
                            imageUrl: state.repoDetail!.owner.avatarUrl,
                            boxShape: BoxShape.circle,
                            height: 200,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () => context
                                .read<StaredRepoDetailScreenCubit>()
                                .openUrl(state.repoDetail!.homepage),
                            child: TextTile(
                              text: "Home Page",
                              fontColor: AppColorsConfig.primaryDark,
                              value: state.repoDetail!.homepage,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: TextTile(
                                  text: "Last Pushed Date",
                                  value: DateTimeUtils.formatDateTime(
                                    DateTime.parse(state.repoDetail!.lastPushed),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextTile(
                                  text: "Created Date",
                                  value: DateTimeUtils.formatDateTime(
                                    DateTime.parse(state.repoDetail!.createdAt),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextTile(
                              text: "Repository Star",
                              value: state.repoDetail!.stargazersCount.toString(),
                              icon: Icons.star),
                          TextTile(
                              text: "Description",
                              value: state.repoDetail!.description!,
                              maxLines: 5),
                          TextTile(text: "Repo Id", value: state.repoDetail!.id.toString())
                        ],
                      ),
                    )
                  : Container(),
        );
      },
    );
  }
}

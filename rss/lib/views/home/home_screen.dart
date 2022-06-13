import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/views/home/cubit/home_cubit.dart';
import 'package:rss/views/home/dialogs/incorrect_link_dialog.dart';
import 'package:rss/views/home/dialogs/no_connection_dialog.dart';
import 'package:rss/views/home/dialogs/smth_went_wrong_dialog.dart';
import 'package:rss/views/home/widgets/custom_appbar.dart';
import 'package:rss/views/home/widgets/news_element.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final rssController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder(
            future: Future.delayed(
              Duration.zero,
              () async {
                await context.read<HomeCubit>().init();
                await context.read<HomeCubit>().updateNews();
              },
            ),
            builder: (context, snapshot) {
              return Column(
                children: [
                  CustomAppBar(
                    rssController: rssController,
                    onUpdateRssUrl: (link) {
                      context.read<HomeCubit>().updateRssLink(link);
                      context.read<HomeCubit>().updateNews();
                    },
                    historyLinks: context.read<HomeCubit>().state.historyLinks,
                  ),
                  Expanded(
                    child: BlocConsumer<HomeCubit, HomeState>(
                      listener: (context, state) {
                        if (state.errorType == ErrorType.noConnection) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const NoConnectionDialog();
                            },
                          );
                        } else if (state.errorType == ErrorType.smthWentWrong) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const SmthWentWrongDialog();
                            },
                          );
                        } else if (state.errorType ==
                            ErrorType.incorrectRssLink) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return const IncorrectLinkDialog();
                            },
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return RefreshIndicator(
                          onRefresh: context.read<HomeCubit>().updateNews,
                          child: ListView.builder(
                            itemCount: state.news.length,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: NewsElement(
                                  item: state.news[index],
                                ),
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
        ),
      ),
    );
  }
}

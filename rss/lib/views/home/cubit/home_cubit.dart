import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rss/models/news_item.dart';
import 'package:rss/providers/database_provider.dart';
import 'package:rss/providers/news_provider.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  late NewsProvider newsProvider;

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    //reversed for last added links to be first
    var savedLinks = (await DatabaseProvider.fetchLinks()).reversed.toList();
    if (savedLinks.isEmpty) {
      savedLinks.add('https://globalnews.ca/world/feed/');
    }
    newsProvider = NewsProvider(baseUrl: savedLinks.first);
    emit(state.copyWith(
      historyLinks: savedLinks,
      isLoading: true,
    ));
  }

  Future<void> updateNews() async {
    try {
      var news = await newsProvider.fetchNews();
      emit(state.copyWith(news: news));
    } catch (e) {
      print('got error: $e');
      switch (e) {
        case ErrorType.noConnection:
          emit(state.copyWith(errorType: ErrorType.noConnection));
          break;
        case ErrorType.incorrectRssLink:
          emit(state.copyWith(errorType: ErrorType.incorrectRssLink));
          break;
        default:
          emit(state.copyWith(errorType: ErrorType.smthWentWrong));
      }
    }
  }

  Future<void> updateRssLink(String link) async {
    if (link.isEmpty) return;
    emit(state.copyWith(isLoading: true));
    try {
      await newsProvider.updateLink(link);
      var historyLinks = List<String>.from(state.historyLinks);
      if (historyLinks.contains(link)) {
        historyLinks.remove(link);
        await DatabaseProvider.deletelink(link);
      }
      historyLinks.insert(0, link);
      await DatabaseProvider.insertLink(link);
      emit(state.copyWith(historyLinks: historyLinks));
    } catch (e) {
      print('got error: $e');
      switch (e) {
        case ErrorType.noConnection:
          emit(state.copyWith(errorType: ErrorType.noConnection));
          break;
        case ErrorType.incorrectRssLink:
          emit(state.copyWith(errorType: ErrorType.incorrectRssLink));
          break;
        default:
          emit(state.copyWith(errorType: ErrorType.smthWentWrong));
      }
    }
  }
}

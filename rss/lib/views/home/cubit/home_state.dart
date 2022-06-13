part of 'home_cubit.dart';

enum ErrorType { none, noConnection, incorrectRssLink, smthWentWrong }

class HomeState extends Equatable {
  final List<String> historyLinks;
  final List<NewsItem> news;
  final bool isLoading;
  final ErrorType errorType;

  const HomeState({
    this.historyLinks = const [],
    this.news = const [],
    this.isLoading = false,
    this.errorType = ErrorType.none,
  });

  HomeState copyWith({
    List<String>? historyLinks,
    List<NewsItem>? news,
    bool? isLoading,
    ErrorType? errorType,
  }) {
    return HomeState(
      historyLinks: historyLinks ?? this.historyLinks,
      news: news ?? this.news,
      isLoading: isLoading ?? false,
      errorType: errorType ?? ErrorType.none,
    );
  }

  @override
  List<Object> get props => [historyLinks, news, isLoading, errorType];
}

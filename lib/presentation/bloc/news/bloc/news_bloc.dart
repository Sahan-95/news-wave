import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/news.dart';
import '../../../../domain/use_cases/get_market_news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetMarketNews getMarketNewsUseCase;

  NewsBloc(this.getMarketNewsUseCase) : super(NewsInitial()) {
    on<LoadNewsEvent>(_onLoadNewsEvent);
  }

  Future<void> _onLoadNewsEvent(
      LoadNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());

    try {
      // Fetch market news from use case
      final newsList = await getMarketNewsUseCase.execute(event.category);

      // Emit loaded state with the news list
      emit(NewsLoaded(newsList));
    } catch (e) {
      // In case of error, emit NewsError state
      emit(NewsError(e.toString()));
    }
  }
}


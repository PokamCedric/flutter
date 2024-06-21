import 'package:bloc/bloc.dart';
import 'event.dart';
import 'state.dart';


// Define FilterBloc
class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc()
      : super(const FilterState(
          filters: {},
        )) {
    on<ChangeFilterEvent>((event, emit) {
      emit(state.copyWith(filters: event.filters));
    });
  }
}
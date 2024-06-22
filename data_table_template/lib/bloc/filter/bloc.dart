import 'package:bloc/bloc.dart';
import 'package:job_listings/models/filter_model.dart';
import 'event.dart';
import 'state.dart';


// Define FilterBloc
class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc()
      : super(
        FilterState(
          filter: FilterModel.defaultInstance(),
        )) {
    on<ChangeFilterEvent>((event, emit) {
      emit(state.copyWith(filter: event.filters));
    });
  }
}
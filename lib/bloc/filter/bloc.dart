import 'package:bloc/bloc.dart';
import 'event.dart';
import 'state.dart';


// Define FilterBloc
class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc()
      : super(const FilterState(
          filters: {},
          currentPage: 1,
          rowsPerPage: 10,
        )) {
    on<ChangeFilterEvent>((event, emit) {
      emit(state.copyWith(filters: event.filters, currentPage: 1));
    });

    on<ChangePageEvent>((event, emit) {
      emit(state.copyWith(currentPage: event.newPage));
    });

    on<ChangeRowsPerPageEvent>((event, emit) {
      emit(state.copyWith(rowsPerPage: event.newRowsPerPage, currentPage: 1));
    });
  }
}
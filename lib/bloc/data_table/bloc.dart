import 'package:bloc/bloc.dart';
import 'event.dart';
import 'state.dart';


// Define DataTableBloc
class DataTableBloc extends Bloc<DataTableEvent, DataTableState> {
  DataTableBloc()
      : super(const DataTableState(
          currentPage: 1,
          rowsPerPage: 10,
        )) {

    on<ChangePageEvent>((event, emit) {
      emit(state.copyWith(currentPage: event.newPage));
    });

    on<ChangeRowsPerPageEvent>((event, emit) {
      emit(state.copyWith(rowsPerPage: event.newRowsPerPage, currentPage: 1));
    });
  }
}
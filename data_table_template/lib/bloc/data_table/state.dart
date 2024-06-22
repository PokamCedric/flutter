import 'package:equatable/equatable.dart';

class DataTableState extends Equatable {
  final int currentPage;
  final int rowsPerPage;

  const DataTableState({
    required this.currentPage,
    required this.rowsPerPage,
  });

  DataTableState copyWith({
    int? currentPage,
    int? rowsPerPage,
  }) {
    return DataTableState(
      currentPage: currentPage ?? this.currentPage,
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
    );
  }

  @override
  List<Object> get props => [currentPage, rowsPerPage];
}

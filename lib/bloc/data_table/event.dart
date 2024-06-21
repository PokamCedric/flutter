import 'package:equatable/equatable.dart';

abstract class DataTableEvent extends Equatable {
  const DataTableEvent();

  @override
  List<Object> get props => [];
}

class ChangePageEvent extends DataTableEvent {
  final int newPage;

  const ChangePageEvent(this.newPage);

  @override
  List<Object> get props => [newPage];
}

class ChangeRowsPerPageEvent extends DataTableEvent {
  final int newRowsPerPage;

  const ChangeRowsPerPageEvent(this.newRowsPerPage);

  @override
  List<Object> get props => [newRowsPerPage];
}
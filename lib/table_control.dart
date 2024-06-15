import 'package:flutter/material.dart';


class PaginationHeader extends StatelessWidget {
  final int totalHits;
  final int rowsPerPage;
  final List<int> availableRowsPerPage;
  final ValueChanged<int?> onRowsPerPageChanged;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final double containerWidth;

  const PaginationHeader({
    required this.totalHits,
    required this.rowsPerPage,
    required this.availableRowsPerPage,
    required this.onRowsPerPageChanged,
    required this.currentPage,
    required this.onPageChanged,
    required this.containerWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: containerWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Search result: $totalHits hits'),
          Row(
            children: [
              Text('Hits per page:'),
              const SizedBox(width: 10),
              DropdownButton<int>(
                value: rowsPerPage,
                items: availableRowsPerPage.map((int value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value'),
                  );
                }).toList(),
                onChanged: onRowsPerPageChanged,
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
              ),
              Text('$currentPage'),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () => onPageChanged(currentPage + 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

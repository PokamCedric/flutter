import 'package:flutter/material.dart';

class PaginationHeader extends StatelessWidget {
  final int totalHits;
  final int rowsPerPage;
  final List<int> availableRowsPerPage;
  final ValueChanged<int?> onRowsPerPageChanged;
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;
  final double containerWidth;

  const PaginationHeader({
    required this.totalHits,
    required this.rowsPerPage,
    required this.availableRowsPerPage,
    required this.onRowsPerPageChanged,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    required this.containerWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: containerWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Page $currentPage of $totalPages'),
          Row(
            children: [
              const Text('Hits per page:'),
              Container(
                  decoration: BoxDecoration(border:
                  Border.all(color: Theme.of(context).primaryColor )),
                child: DropdownButton<int>(
                  value: rowsPerPage,
                  alignment: AlignmentDirectional.centerStart,
                  underline: const SizedBox(), // Remove the underline
                  padding: const EdgeInsets.only(left: 50.0),
                  items: availableRowsPerPage.map((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      alignment: AlignmentDirectional.center,
                      child: Text('$value',style: Theme.of(context).textTheme.bodyLarge,),
                    );
                  }).toList(),
                  onChanged: onRowsPerPageChanged,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            height: 50,
            child: GridView(
              padding: const EdgeInsets.only(top: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 2,
                  ),
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      width: 10,
                      decoration: roundedBox(true),
                      child: IconButton(
                          icon: Icon(Icons.chevron_left, color: currentPage > 1 ? Colors.black : Colors.grey),
                          onPressed: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null
                          ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 10 ,
                      color: Colors.blue,
                      child: Text('$currentPage')
                      ),
                    Container(width: 10,
                      decoration: roundedBox(false),
                      child: IconButton(
                        icon: Icon(Icons.chevron_right, color: currentPage < totalPages ? Colors.black : Colors.grey),
                        onPressed: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
                      )
                      )
                  ],
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration roundedBox(bool isLeft) {
    final  double left = isLeft? 20.0 : 0;
    final  double right = isLeft? 0 : 20.0;
    return BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.green),
                      borderRadius:
                      BorderRadius.only(
                        topLeft: Radius.circular(left),
                        topRight: Radius.circular(right),
                        bottomLeft: Radius.circular(left),
                        bottomRight: Radius.circular(right),
                      ),
                    );
  }
}

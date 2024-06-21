
class FilterModel {
  final String label;
  final List<String> items;

  FilterModel(this.label, this.items);
}

List<FilterModel> getFilterModels() {
  return [
    FilterModel('Field', [
      'All Fields',
      'Food security, agriculture',
      'Peace-building and crisis prevention',
      'Infrastructure, ICT'
    ]),
    FilterModel('Type of function', [
      'All types of function',
      'Integrated Expert'
    ]),
    FilterModel('Country', [
      'All countries',
      'Kenya',
      'Sri Lanka',
      'Benin',
      'Madagascar'
    ]),
  ];
}

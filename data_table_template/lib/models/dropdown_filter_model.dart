
class DropdownFilterModel {
  final String label;
  final String propertyName;
  final List<String> items;

  DropdownFilterModel(this.label, this.propertyName, this.items);
}

List<DropdownFilterModel> getDropdownFilterModels() {
  return [
    DropdownFilterModel(
      'Field',
      'field',
      [
      'All Fields',
      'Food security, agriculture',
      'Peace-building and crisis prevention',
      'Infrastructure, ICT'
    ]),
    DropdownFilterModel(
      'Type of function',
      'type',
      [
      'All types of function',
      'Integrated Expert'
    ]),
    DropdownFilterModel(
      'Country',
      'country',
      [
      'All countries',
      'Kenya',
      'Sri Lanka',
      'Benin',
      'Madagascar'
    ]),
  ];
}

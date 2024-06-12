import 'package:flutter/material.dart';


class Filter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Keywords'),
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Field'),
            items: [
              'Food security, agriculture',
              'Peace-building and crisis prevention',
              'Infrastructure, ICT'
            ].map((field) => DropdownMenuItem<String>(
                  value: field,
                  child: Text(field),
                )).toList(),
            onChanged: (value) {},
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Type of function'),
            items: [
              'All types of function',
              'Integrated Expert'
            ].map((type) => DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                )).toList(),
            onChanged: (value) {},
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Country'),
            items: [
              'All countries',
              'Kenya',
              'Sri Lanka',
              'Benin',
              'Madagascar'
            ].map((country) => DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                )).toList(),
            onChanged: (value) {},
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Handle search/filter action
            },
            child: Text('Search Jobs'),
          ),
        ],
      ),
    );
  }
}

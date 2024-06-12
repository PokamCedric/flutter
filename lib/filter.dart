import 'package:flutter/material.dart';


class Filter extends StatelessWidget {
  const Filter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextField(
            decoration: InputDecoration(labelText: 'Keywords'),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Field'),
            items: [
              'Food security, agriculture',
              'Peace-building and crisis',
              'Infrastructure, ICT'
            ].map((field) => DropdownMenuItem<String>(
                  value: field,
                  child: Text(field),
                )).toList(),
            onChanged: (value) {},
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Type of function'),
            items: [
              'All types of function',
              'Integrated Expert'
            ].map((type) => DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                )).toList(),
            onChanged: (value) {},
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Country'),
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
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Handle search/filter action
            },
            child: const Text('Search Jobs'),
          ),
        ],
      ),
    );
  }
}

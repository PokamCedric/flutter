// Copyright 2023 The terCAD team. All rights reserved.
// Use of this source code is governed by a CC BY-NC-ND 4.0 license that can be found in the LICENSE file.

import 'package:template_app/_configs/theme_helper.dart';
import 'package:template_app/_ext/build_context_ext.dart';
import 'package:template_app/design/wrapper/text_wrapper.dart';
import 'package:template_app/pages/_interfaces/abstract_page_state.dart';
import 'package:flutter/material.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  TablePageState createState() => TablePageState();
}

class TablePageState extends AbstractPageState<TablePage> {
  final List<Person> _people = [
    Person(id: 1, name: 'Alice Martin', email: 'alice.martin@example.com', age: 28, role: 'Developer'),
    Person(id: 2, name: 'Bob Durant', email: 'bob.durant@example.com', age: 34, role: 'Designer'),
    Person(id: 3, name: 'Charlie Dubois', email: 'charlie.dubois@example.com', age: 29, role: 'Manager'),
    Person(id: 4, name: 'Diana Lefebvre', email: 'diana.lefebvre@example.com', age: 31, role: 'Developer'),
    Person(id: 5, name: 'Étienne Moreau', email: 'etienne.moreau@example.com', age: 26, role: 'Designer'),
    Person(id: 6, name: 'Françoise Bernard', email: 'francoise.bernard@example.com', age: 38, role: 'Manager'),
    Person(id: 7, name: 'Gabriel Petit', email: 'gabriel.petit@example.com', age: 27, role: 'Developer'),
    Person(id: 8, name: 'Hélène Roux', email: 'helene.roux@example.com', age: 32, role: 'Designer'),
  ];

  Person? _selectedPerson;

  @override
  String getTitle() => 'Table Demo';

  @override
  String getButtonName() => 'Add Person';

  @override
  String? getHelperName() => null;

  void _addPerson() {
    setState(() {
      final newId = _people.isEmpty ? 1 : _people.map((p) => p.id).reduce((a, b) => a > b ? a : b) + 1;
      _people.add(
        Person(
          id: newId,
          name: 'New Person $newId',
          email: 'person$newId@example.com',
          age: 25,
          role: 'Developer',
        ),
      );
    });
  }

  void _deletePerson(Person person) {
    setState(() {
      _people.removeWhere((p) => p.id == person.id);
      if (_selectedPerson?.id == person.id) {
        _selectedPerson = null;
      }
    });
  }

  @override
  Widget buildButton(BuildContext context, BoxConstraints constraints) {
    return FloatingActionButton.extended(
      heroTag: 'add_person_button',
      onPressed: _addPerson,
      icon: const Icon(Icons.person_add),
      label: TextWrapper(getButtonName()),
      tooltip: 'Add a new person',
    );
  }

  @override
  Widget buildContent(BuildContext context, BoxConstraints constraints) {
    final theme = Theme.of(context);
    
    return Container(
      color: context.colorScheme.surface,
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(ThemeHelper.getIndent(2)),
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              border: Border(
                bottom: BorderSide(
                  color: context.colorScheme.outline.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.people, color: context.colorScheme.primary),
                SizedBox(width: ThemeHelper.getIndent()),
                TextWrapper(
                  'People Directory (${_people.length})',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Table Header
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ThemeHelper.getIndent(2),
              vertical: ThemeHelper.getIndent(),
            ),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              border: Border(
                bottom: BorderSide(
                  color: context.colorScheme.outline,
                  width: 2,
                ),
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  child: TextWrapper(
                    'ID',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextWrapper(
                    'Name',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextWrapper(
                    'Email',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextWrapper(
                    'Age',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                Expanded(
                  child: TextWrapper(
                    'Role',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ),
                SizedBox(width: 80),
              ],
            ),
          ),

          // Table Body (ListView)
          Expanded(
            child: _people.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 64,
                          color: context.colorScheme.onSurface.withValues(alpha: 0.3),
                        ),
                        SizedBox(height: ThemeHelper.getIndent(2)),
                        TextWrapper(
                          'No people in the directory',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _people.length,
                    itemBuilder: (context, index) {
                      final person = _people[index];
                      final isSelected = _selectedPerson?.id == person.id;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedPerson = isSelected ? null : person;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ThemeHelper.getIndent(2),
                            vertical: ThemeHelper.getIndent(1.5),
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? context.colorScheme.primaryContainer.withValues(alpha: 0.3)
                                : index.isEven
                                    ? context.colorScheme.surface
                                    : context.colorScheme.surfaceContainerHighest.withValues(alpha: 0.2),
                            border: Border(
                              bottom: BorderSide(
                                color: context.colorScheme.outline.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40,
                                child: TextWrapper(
                                  '${person.id}',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: TextWrapper(
                                  person.name,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: context.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: TextWrapper(
                                  person.email,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: context.colorScheme.onSurface.withValues(alpha: 0.8),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child: TextWrapper(
                                  '${person.age}',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: context.colorScheme.onSurface.withValues(alpha: 0.8),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ThemeHelper.getIndent(0.5),
                                    vertical: ThemeHelper.getIndent(0.25),
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getRoleColor(person.role, context).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextWrapper(
                                    person.role,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: _getRoleColor(person.role, context),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, size: 20),
                                      onPressed: () {
                                        // Edit action
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Edit ${person.name}')),
                                        );
                                      },
                                      tooltip: 'Edit',
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                    SizedBox(width: ThemeHelper.getIndent(0.5)),
                                    IconButton(
                                      icon: Icon(Icons.delete, size: 20, color: context.colorScheme.error),
                                      onPressed: () => _deletePerson(person),
                                      tooltip: 'Delete',
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Footer with selection info
          if (_selectedPerson != null)
            Container(
              padding: EdgeInsets.all(ThemeHelper.getIndent(2)),
              decoration: BoxDecoration(
                color: context.colorScheme.secondaryContainer,
                border: Border(
                  top: BorderSide(
                    color: context.colorScheme.outline.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: context.colorScheme.onSecondaryContainer),
                  SizedBox(width: ThemeHelper.getIndent()),
                  TextWrapper(
                    'Selected: ${_selectedPerson!.name} (${_selectedPerson!.role})',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSecondaryContainer,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Color _getRoleColor(String role, BuildContext context) {
    switch (role) {
      case 'Developer':
        return context.colorScheme.primary;
      case 'Designer':
        return context.colorScheme.tertiary;
      case 'Manager':
        return context.colorScheme.secondary;
      default:
        return context.colorScheme.onSurface;
    }
  }
}

// Data model
class Person {
  final int id;
  final String name;
  final String email;
  final int age;
  final String role;

  Person({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.role,
  });
}
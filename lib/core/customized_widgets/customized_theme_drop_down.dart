import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/l10n/app_translations.dart';

class ThemeDropdown extends StatefulWidget {
  const ThemeDropdown({super.key});

  @override
  _ThemeDropdownState createState() => _ThemeDropdownState();
}

class _ThemeDropdownState extends State<ThemeDropdown> {
  String _selectedTheme = 'light';

  final Map<String, IconData> _themes = {
    'light': Icons.wb_sunny,
    'dark': Icons.nights_stay,
    'system': Icons.brightness_auto,
  };

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedTheme,
      decoration: InputDecoration(
        fillColor: AppColors.lightGrey2,
        labelText: LocalizationService.instance.tr.theme,
      ),
      items: _themes.entries.map((entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Row(
            children: [
              Icon(entry.value, size: 20),
              const SizedBox(width: 8),
              Text(entry.key),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedTheme = value;
          });
          // TODO: Implement theme change logic here
        }
      },
    );
  }
}
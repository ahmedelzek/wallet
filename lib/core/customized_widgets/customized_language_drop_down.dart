import 'package:flutter/material.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/l10n/app_translations.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  String _selectedLang = 'en';

  final Map<String, String> _languages = {
    'en': 'English',
    'ar': 'العربية',
  };
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedLang,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightGrey2,
        labelText: LocalizationService.instance.tr.language,
      ),
      items: _languages.entries.map((entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Row(
            children: [
              if (entry.key == 'en')
                const Text('🇺🇸 ', style: TextStyle(fontSize: 18))
              else if (entry.key == 'ar')
                const Text('🇸🇦 ', style: TextStyle(fontSize: 18)),
              Text(entry.value),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedLang = value;
          });
          // TODO: Implement language change logic here
          // Example: context.setLocale(Locale(value));
        }
      },
    );
  }
}

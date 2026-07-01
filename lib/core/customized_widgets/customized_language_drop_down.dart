import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/core/resources/app_colors.dart';
import 'package:wallet/features/home_screen/settings_page/cubit/language_cubit.dart';
import 'package:wallet/l10n/app_translations.dart';

class LanguageDropdown extends StatefulWidget {
  const LanguageDropdown({super.key});

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {


  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    final cubit = context.watch<LocaleCubit>();
    final currentLang = cubit.state.languageCode;

    final Map<String, String> languages = {'en': 'English', 'ar': 'العربية'};

    return DropdownButtonFormField<String>(
      value: currentLang,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightGrey2,
        labelText:tr.language,
      ),
      items:
          languages.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Row(
                children: [
                  Text(
                    entry.key == 'en' ? '🇺🇸 ' : '🇸🇦 ',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(entry.value),
                ],
              ),
            );
          }).toList(),
      onChanged: (value) {
        if (value != null) {
          value == 'en'
              ? context.read<LocaleCubit>().setEnglish()
              : context.read<LocaleCubit>().setArabic();
        }
      },
    );
  }
}

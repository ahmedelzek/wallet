import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/core/customized_widgets/customized_language_drop_down.dart';
import 'package:wallet/core/customized_widgets/customized_show_delete_dialog.dart';
import 'package:wallet/core/customized_widgets/customized_theme_drop_down.dart';
import 'package:wallet/l10n/app_translations.dart';

import 'cubit/delete_cubit.dart';
import 'cubit/delete_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BlocListener<DeleteAllCubit, DeleteAllState>(
        listener: (context, state) {
          if (state is DeleteLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Deleting all transactions...'),
                duration: Duration(seconds: 1),
              ),
            );
          } else if (state is DeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('All transactions deleted!')),
            );
          } else if (state is DeleteFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to delete transactions.')),
            );
          }
        },
        child: Column(
          children: [
            Text(
              LocalizationService.instance.tr.settings,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 30),
            const LanguageDropdown(),
            const SizedBox(height: 30),
            const ThemeDropdown(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final confirm = await showDeleteAllDialog(
                  context,
                  LocalizationService.instance.tr.deleteAllShowDialogTitle,
                  LocalizationService.instance.tr.deleteAllShowDialogMessage,
                );
                if (confirm == true) {
                  context.read<DeleteAllCubit>().deleteAllTransactions();
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
              ),
              child: Text(LocalizationService.instance.tr.deleteAll),
            ),
          ],
        ),
      ),
    );
  }
}

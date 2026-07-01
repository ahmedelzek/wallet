import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/core/customized_widgets/app_snack_bar_manager.dart';
import 'package:wallet/core/customized_widgets/customized_language_drop_down.dart';
import 'package:wallet/core/customized_widgets/customized_show_delete_dialog.dart';
import 'package:wallet/core/customized_widgets/customized_theme_drop_down.dart';
import 'package:wallet/features/home_screen/settings_page/cubit/settings_cubit.dart';
import 'package:wallet/l10n/app_translations.dart';

import '../../../core/di/injector.dart';
import 'cubit/delete_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return BlocProvider(
      create: (context) => sl<SettingsCubit>(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<SettingsCubit, DeleteAllState>(
          listener: (context, state) {
            if (state is DeleteLoadingState) {
              AppSnackBar.showWarning(context, tr.deletingAllTransactions);
            } else if (state is DeleteSuccessState) {
              AppSnackBar.showSuccess(
                  context, tr.deleteAllTransactionsSuccessfully);
            } else if (state is DeleteFailureState) {
              AppSnackBar.showSuccess(context, tr.failedToDeleteTransactions);
            }
          },
          builder: (context, state) {
            final cubit = SettingsCubit.get(context);
            return Column(
              children: [
                Text(
                  tr.settings,
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineMedium,
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
                      tr.deleteAllShowDialogTitle,
                      tr.deleteAllShowDialogMessage,
                    );
                    if (confirm == true) {
                      cubit.deleteAllTransactions();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  child: Text(tr.deleteAll),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

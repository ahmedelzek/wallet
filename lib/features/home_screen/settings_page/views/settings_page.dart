import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/core/customized_widgets/customized_language_drop_down.dart';
import 'package:wallet/core/customized_widgets/customized_show_delete_dialog.dart';
import 'package:wallet/core/customized_widgets/customized_theme_drop_down.dart';
import 'package:wallet/core/resources/app_sizes.dart';
import 'package:wallet/features/home_screen/settings_page/cubit/settings_cubit.dart';
import 'package:wallet/l10n/app_translations.dart';

import '../../../../core/customized_widgets/customized_app_snack_bar.dart';
import '../../../../core/di/injector.dart';
import '../cubit/delete_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tr = LocalizationService.instance.tr(context);
    return BlocProvider(
      create: (context) => sl<SettingsCubit>(),
      child: Padding(
        padding:  EdgeInsets.all(AppPadding.p20),
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
                SizedBox(height: AppHeight.h30),
                const LanguageDropdown(),
                SizedBox(height: AppHeight.h30),
                const ThemeDropdown(),
                 SizedBox(height: AppHeight.h30),
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

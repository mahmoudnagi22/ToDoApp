import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/colors_manager.dart';
import 'package:to_do_app/provider/settings_proviider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Theme Selection
          Text(
            AppLocalizations.of(context)!.theme,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).indicatorColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                // Display the selected theme in the same place as DropdownButton
                Text(
                  provider.currentTheme == ThemeMode.light
                      ? AppLocalizations.of(context)!.light
                      : AppLocalizations.of(context)!.dark,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const Spacer(),
                DropdownButton<String>(
                  underline: SizedBox.shrink(),
                  dropdownColor: ColorsManager.whiteColor,
                  iconDisabledColor: Colors.transparent,
                  iconEnabledColor: ColorsManager.blueColor,
                  isDense: false,
                  style: GoogleFonts.poppins(
                    color: ColorsManager.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.all(0),
                  isExpanded: false,
                  items: <String>[AppLocalizations.of(context)!.light, AppLocalizations.of(context)!.dark]
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newTheme) {
                    provider.changeAppTheme(
                      newTheme == AppLocalizations.of(context)!.light
                          ? ThemeMode.light
                          : ThemeMode.dark,
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Language Selection
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).indicatorColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                // Display the selected language in the same place as DropdownButton
                Text(
                  provider.isAppLanguageEn()
                      ? AppLocalizations.of(context)!.english
                      : AppLocalizations.of(context)!.arabic,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const Spacer(),
                DropdownButton<String>(
                  dropdownColor: ColorsManager.whiteColor,
                  underline: SizedBox.shrink(),
                  iconDisabledColor: Colors.transparent,
                  iconEnabledColor: ColorsManager.blueColor,
                  isDense: false,
                  style: GoogleFonts.poppins(
                    color: ColorsManager.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.all(0),
                  isExpanded: false,
                  items: <String>[AppLocalizations.of(context)!.english, AppLocalizations.of(context)!.arabic]
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newLang) {
                    provider.changeAppLanguage(newLang == AppLocalizations.of(context)!.english ? 'en' : 'ar');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

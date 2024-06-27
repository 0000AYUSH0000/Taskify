import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/theme_provider.dart';


class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark,
      onChanged: (value) {
        Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      },
    );
  }
}

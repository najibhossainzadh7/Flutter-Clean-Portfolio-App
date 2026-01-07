import 'package:flutter/material.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/core/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';


class AppThemes {
  static ThemeData getLightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.poppins().fontFamily,
      scaffoldBackgroundColor: ColorBlock.white,
      colorScheme: _colorScheme,
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: _appBarTheme,
      inputDecorationTheme: _inputDecorationTheme,
      checkboxTheme: _checkboxTheme,
      dialogTheme: _dialogTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      filledButtonTheme: _filledButtonTheme,
      textButtonTheme: _textButtonTheme,
      bottomNavigationBarTheme: _bottomNavigationTheme,
      chipTheme: chipTheme,
      bottomSheetTheme: bottomSheetTheme,
    );
  }
}

const _dialogTheme = DialogThemeData(backgroundColor: ColorBlock.white);

const bottomSheetTheme = BottomSheetThemeData(
  dragHandleColor: Color(0xff979797),
  dragHandleSize: Size(72, 5),
  backgroundColor: ColorBlock.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
  ),
);

const chipTheme = ChipThemeData(
  shape: RoundedRectangleBorder(borderRadius: borderRadiusLarge),
);

const _bottomNavigationTheme = BottomNavigationBarThemeData(
  backgroundColor: ColorBlock.bottomNavigatoinBackground,
);

final _outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    side: const BorderSide(color: ColorBlock.primary),
    shape: const RoundedRectangleBorder(borderRadius: borderRadiusMedium),
  ),
);

final _filledButtonTheme = FilledButtonThemeData(
  style: OutlinedButton.styleFrom(
    shape: const RoundedRectangleBorder(borderRadius: borderRadiusMedium),
  ),
);

final _textButtonTheme = TextButtonThemeData(
  style: OutlinedButton.styleFrom(
    shape: const RoundedRectangleBorder(borderRadius: borderRadiusMedium),
  ),
);

final _checkboxTheme = CheckboxThemeData(
  fillColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return ColorBlock.primary;
    }
    return ColorBlock.fill;
  }),
  side: const BorderSide(color: ColorBlock.borderLight, width: 2),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final _colorScheme = ColorScheme.fromSeed(
  seedColor: ColorBlock.primary,
  primary: ColorBlock.primary,
);

final _appBarTheme = AppBarTheme(
  titleTextStyle: GoogleFonts.poppins(
    fontSize: 16,
    color: ColorBlock.black,
    fontWeight: FontWeight.bold,
  ),
  foregroundColor: ColorBlock.black,
  backgroundColor: ColorBlock.white,
  surfaceTintColor: Colors.transparent,
  elevation: 0,
);

const _inputDecorationTheme = InputDecorationTheme(
  contentPadding: paddingSmall,
  iconColor: ColorBlock.primary,
  fillColor: ColorBlock.fill,
  errorMaxLines: 2,
  hintStyle: TextStyle(
    fontSize: 14,
    letterSpacing: 0.2,
    color: ColorBlock.grey,
    fontWeight: FontWeight.w400,
  ),
  prefixIconColor: ColorBlock.black,
  errorBorder: OutlineInputBorder(
    borderRadius: borderRadiusMedium,
    borderSide: BorderSide(color: Colors.red),
  ),
  border: OutlineInputBorder(
    borderRadius: borderRadiusMedium,
    borderSide: BorderSide(color: ColorBlock.borderLight),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: borderRadiusMedium,
    borderSide: BorderSide(color: ColorBlock.borderLight),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: borderRadiusMedium,
    borderSide: BorderSide(color: ColorBlock.primary),
  ),
);

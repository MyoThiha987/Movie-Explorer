import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4285684736),
      surfaceTint: Color(4285684736),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4294956605),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4285357568),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4294169875),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4283851093),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4292865244),
      onTertiaryContainer: Color(4282601027),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294965488),
      onSurface: Color(4280228625),
      onSurfaceVariant: Color(4283254323),
      outline: Color(4286543456),
      outlineVariant: Color(4291872428),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281610277),
      inversePrimary: Color(4293640986),
      primaryFixed: Color(4294959229),
      onPrimaryFixed: Color(4280490752),
      primaryFixedDim: Color(4293640986),
      onPrimaryFixedVariant: Color(4283843840),
      secondaryFixed: Color(4294959685),
      onSecondaryFixed: Color(4280359680),
      secondaryFixedDim: Color(4293117440),
      onSecondaryFixedVariant: Color(4283582208),
      tertiaryFixed: Color(4292470486),
      onTertiaryFixed: Color(4279442964),
      tertiaryFixedDim: Color(4290628283),
      onTertiaryFixedVariant: Color(4282272318),
      surfaceDim: Color(4292991433),
      surfaceBright: Color(4294965488),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294767586),
      surfaceContainer: Color(4294372828),
      surfaceContainerHigh: Color(4293978070),
      surfaceContainerHighest: Color(4293583569),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4283515136),
      surfaceTint: Color(4285684736),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4287394304),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4283253504),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4287001600),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4282009146),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4285298795),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294965488),
      onSurface: Color(4280228625),
      onSurfaceVariant: Color(4278190080),
      outline: Color(4284899146),
      outlineVariant: Color(4286806628),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281610277),
      inversePrimary: Color(4293640986),
      primaryFixed: Color(4287394304),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4285487616),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4287001600),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4285160448),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4285298795),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4283653971),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292991433),
      surfaceBright: Color(4294965488),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294767586),
      surfaceContainer: Color(4291872428),
      surfaceContainerHigh: Color(4293978070),
      surfaceContainerHighest: Color(4293583569),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4281016576),
      surfaceTint: Color(4285684736),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283515136),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280885760),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4283253504),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4279903515),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4282009146),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294965488),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280886291),
      outline: Color(4282991151),
      outlineVariant: Color(4282991151),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281610277),
      inversePrimary: Color(4294962097),
      primaryFixed: Color(4283515136),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4281805824),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4283253504),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4281609472),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4282009146),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4280561445),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292991433),
      surfaceBright: Color(4294965488),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294767586),
      surfaceContainer: Color(4294372828),
      surfaceContainerHigh: Color(4293978070),
      surfaceContainerHighest: Color(4293583569),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294965746),
      surfaceTint: Color(4293640986),
      onPrimary: Color(4282068736),
      primaryContainer: Color(4294298663),
      onPrimaryContainer: Color(4294965746),
      secondary: Color(4294964431),
      onSecondary: Color(4281937920),
      secondaryContainer: Color(4293380608),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4294967295),
      onTertiary: Color(4280824616),
      tertiaryContainer: Color(4291549384),
      onTertiaryContainer: Color(4281811511),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279636745),
      onSurface: Color(4294965746),
      onSurfaceVariant: Color(4288254073),
      outline: Color(4288254073),
      outlineVariant: Color(4294965746),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293583569),
      inversePrimary: Color(4285684736),
      primaryFixed: Color(4294959229),
      onPrimaryFixed: Color(4280490752),
      primaryFixedDim: Color(4293640986),
      onPrimaryFixedVariant: Color(4283843840),
      secondaryFixed: Color(4294959685),
      onSecondaryFixed: Color(4280359680),
      secondaryFixedDim: Color(4293117440),
      onSecondaryFixedVariant: Color(4283582208),
      tertiaryFixed: Color(4292470486),
      onTertiaryFixed: Color(4279442964),
      tertiaryFixedDim: Color(4290628283),
      onTertiaryFixedVariant: Color(4282272318),
      surfaceDim: Color(4279636745),
      surfaceBright: Color(4282202413),
      surfaceContainerLowest: Color(4279307781),
      surfaceContainerLow: Color(4280228625),
      surfaceContainer: Color(4280491797),
      surfaceContainerHigh: Color(4281215519),
      surfaceContainerHighest: Color(4281938985),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294965746),
      surfaceTint: Color(4293640986),
      onPrimary: Color(4282068736),
      primaryContainer: Color(4294298663),
      onPrimaryContainer: Color(4280424960),
      secondary: Color(4294964431),
      onSecondary: Color(4281937920),
      secondaryContainer: Color(4293380608),
      onSecondaryContainer: Color(4279899648),
      tertiary: Color(4294967295),
      onTertiary: Color(4280824616),
      tertiaryContainer: Color(4291549384),
      onTertiaryContainer: Color(4279706136),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279636745),
      onSurface: Color(4294966006),
      onSurfaceVariant: Color(4292201136),
      outline: Color(4289503882),
      outlineVariant: Color(4287333228),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293583569),
      inversePrimary: Color(4283909632),
      primaryFixed: Color(4294959229),
      onPrimaryFixed: Color(4279701504),
      primaryFixedDim: Color(4293640986),
      onPrimaryFixedVariant: Color(4282529024),
      secondaryFixed: Color(4294959685),
      onSecondaryFixed: Color(4279570688),
      secondaryFixedDim: Color(4293117440),
      onSecondaryFixedVariant: Color(4282332672),
      tertiaryFixed: Color(4292470486),
      onTertiaryFixed: Color(4278785034),
      tertiaryFixedDim: Color(4290628283),
      onTertiaryFixedVariant: Color(4281219374),
      surfaceDim: Color(4279636745),
      surfaceBright: Color(4282202413),
      surfaceContainerLowest: Color(4279307781),
      surfaceContainerLow: Color(4280228625),
      surfaceContainer: Color(4280491797),
      surfaceContainerHigh: Color(4281215519),
      surfaceContainerHighest: Color(4281938985),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294966006),
      surfaceTint: Color(4293640986),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4294298663),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294966004),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4293380608),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294967295),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4291549384),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279636745),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294966006),
      outline: Color(4292201136),
      outlineVariant: Color(4292201136),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293583569),
      inversePrimary: Color(4293583569),
      primaryFixed: Color(4294960534),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4293969697),
      onPrimaryFixedVariant: Color(4280096256),
      secondaryFixed: Color(4294961008),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4293446144),
      onSecondaryFixedVariant: Color(4279965184),
      tertiaryFixed: Color(4292733658),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4290891455),
      onTertiaryFixedVariant: Color(4279113999),
      surfaceDim: Color(4279636745),
      surfaceBright: Color(4282202413),
      surfaceContainerLowest: Color(4279307781),
      surfaceContainerLow: Color(4280228625),
      surfaceContainer: Color(4280491797),
      surfaceContainerHigh: Color(4281215519),
      surfaceContainerHighest: Color(4281938985),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        fontFamily: "Lora",
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
  GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}



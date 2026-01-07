import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*
SPACING SYSTEM (px)
2  / 4 / 8 / 12 / 16 / 24 / 32 / 48 / 64 / 80 / 96 / 128
xt/ tiny/xxs/xs/ sm / md / lg / xlg /xxlg
FONT SIZE SYSTEM (px)
10 / 12 / 14 / 16 / 18 / 20 / 24 / 30 / 36 / 44 / 52 / 62 / 74 / 86 / 98
*/

const Duration animationDuration = Duration(milliseconds: 260);

const double secondItemPaddingTiny = 2;

const double secondItemPaddingSmall = 10;

const double itemPadding = 8;

const double itemPaddingSmall = 12;

const double itemPaddingMedium = 16;

const double itemPaddingLarge = 24;

const double itemPaddingExtraLarge = 32;

// padding
const EdgeInsets paddingTiny = EdgeInsets.all(8);

const EdgeInsets paddingSmall = EdgeInsets.all(12);

const EdgeInsets paddingMedium = EdgeInsets.all(16);

const EdgeInsets paddingLarge = EdgeInsets.all(24);

const EdgeInsets paddingExtraLarge = EdgeInsets.all(32);

const EdgeInsets paddingDefault = EdgeInsets.all(20);

const EdgeInsets secondPaddingMedium = EdgeInsets.all(14);

const EdgeInsets secondPaddingSmall = EdgeInsets.all(10);

const EdgeInsets secondPaddingTiny = EdgeInsets.all(2);

// padding horizontal
const EdgeInsets paddingHorizontalTiny = EdgeInsets.symmetric(horizontal: 8);

const EdgeInsets paddingHorizontalSmall = EdgeInsets.symmetric(horizontal: 12);

const EdgeInsets paddingHorizontalMedium = EdgeInsets.symmetric(horizontal: 16);

const EdgeInsets paddingHorizontalLarge = EdgeInsets.symmetric(horizontal: 24);

const EdgeInsets paddingHorizontalExtraLarge = EdgeInsets.symmetric(
  horizontal: 32,
);

const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(horizontal: 20);

const EdgeInsets secondPaddingHorizontalTiny = EdgeInsets.symmetric(
  horizontal: 2,
);

const EdgeInsets secondPaddingHorizontalSmall = EdgeInsets.symmetric(
  horizontal: 10,
);

// padding vertical
const EdgeInsets paddingVerticalTiny = EdgeInsets.symmetric(vertical: 8);

const EdgeInsets paddingVerticalSmall = EdgeInsets.symmetric(vertical: 12);

const EdgeInsets paddingVerticalMedium = EdgeInsets.symmetric(vertical: 16);

const EdgeInsets paddingVerticalLarge = EdgeInsets.symmetric(vertical: 24);

const EdgeInsets paddingVerticalExtraLarge = EdgeInsets.symmetric(vertical: 32);

const EdgeInsets paddingVertical = EdgeInsets.symmetric(vertical: 20);

const EdgeInsets secondPaddingVerticalTiny = EdgeInsets.symmetric(vertical: 2);

const EdgeInsets secondPaddingVerticalSmall = EdgeInsets.symmetric(
  vertical: 10,
);

const BorderRadius borderRadius = BorderRadius.all(Radius.circular(8));
const BorderRadius borderRadiusTiny = BorderRadius.all(Radius.circular(4));
const BorderRadius borderRadiusMedium = BorderRadius.all(Radius.circular(10));
const BorderRadius borderRadiusExtraMedium = BorderRadius.all(
  Radius.circular(16),
);
const BorderRadius borderRadiusLarge = BorderRadius.all(Radius.circular(20));
const BorderRadius borderRadiusExtraLarge = BorderRadius.all(
  Radius.circular(28),
);

const BorderRadius borderRadiusBottomSheet = BorderRadius.only(
  topLeft: Radius.circular(20),
  topRight: Radius.circular(20),
);

const BorderRadius borderRadiusBottomSmall = BorderRadius.only(
  topLeft: Radius.circular(12),
  topRight: Radius.circular(12),
);

const BorderRadius borderRadiusBottomSheetLarge = BorderRadius.only(
  topLeft: Radius.circular(36),
  topRight: Radius.circular(36),
);

const BorderRadius borderRadiusCard = BorderRadius.only(
  bottomLeft: Radius.circular(15),
  bottomRight: Radius.circular(15),
);

final initBoxShadow = [
  BoxShadow(
    color: const Color(0xff080F34).withOpacity(0.226),
    offset: const Offset(0, 5),
    blurRadius: 17,
    spreadRadius: 0,
  ),
];

final itemBoxShadow = [
  BoxShadow(
    color: const Color(0xff00001a).withOpacity(0.25),
    blurRadius: 6,
    spreadRadius: 0,
  ),
];

const topBoxShadow = [
  BoxShadow(
    color: Color.fromRGBO(205, 204, 204, 0.219),
    offset: Offset(0, 0),
    blurRadius: 20,
    spreadRadius: 0,
  ),
];

const secondBoxShadow = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.08),
    spreadRadius: 2,
    blurRadius: 8,
    offset: Offset(0, 3),
  ),
];

const primaryGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFF711B), Color(0xFFFF961A)],
);

const secondaryGradient = LinearGradient(
  colors: [Color(0xff1F316A), Color(0xff2648B5)],
  begin: Alignment.bottomLeft,
  end: Alignment.topRight,
);

const secondaryFlatGradient = LinearGradient(
  colors: [Color(0xff1F316A), Color(0xff2648B5)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

final boldTextStyle = GoogleFonts.poppins(fontWeight: FontWeight.bold);

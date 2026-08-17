import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xFF2E8FC9); // azul principal (headers, botões)
  static const primaryDark = Color(0xFF1B5E82); // contraste, textos sobre azul
  static const primaryLight = Color(0xFF6FC3E8); // gradiente, ícones ativos
  static const accent = Color(0xFFBFE9F7); // fundos suaves, chips

  static const background = Color(0xFFF6FAFC); // fundo geral das telas
  static const surface = Color(0xFFFFFFFF); // cards

  static const textPrimary = Color(0xFF1B2B3A);
  static const textSecondary = Color(0xFF6B7C8C);
  static const textMuted = Color(0xFF9AAAB8);

  static const danger = Color(0xFFE0645C); // Sair / Excluir conta
  static const dangerBg = Color(0xFFFDEDEC);

  static const divider = Color(0xFFE7EEF2);

  static const gradientHeader = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF3AA0D8), Color(0xFF1F6FA0)],
  );
}

class AppShadows{
  AppShadows._();

  static List<BoxShadow> card = [
    BoxShadow(
      color: AppColors.primaryDark.withOpacity(0.06),
      blurRadius: 20,
      offset: const Offset(0, 8)
    ),
  ];

  static List<BoxShadow> soft = [
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 10,
      offset: const Offset(0, 3),
    ),
  ];
}

class AppRadius{
  AppRadius._();
  static const card = 20.0;
  static const button = 14.0;
  static const chip = 12.0;
}

ThemeData buildAppTheme(){
  final base = ThemeData.light();

  final textTheme = TextTheme(
    //titulos
    headlineSmall: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
      height: 1.2,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),
    // corpo
    bodyLarge: GoogleFonts.inter(
      fontSize: 15,
      color: AppColors.textPrimary,
      height: 1.4,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 13.5,
      color: AppColors.textSecondary,
      height: 1.4,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 11.5,
      color: AppColors.textMuted,
      fontWeight: FontWeight.w500,
    ),
  );

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.primary,
      secondary: AppColors.primaryLight,
      error: AppColors.danger,
    ),
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,  
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    dividerColor: AppColors.divider,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 14.5,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.danger,
        side: const BorderSide(color: AppColors.danger, width: 1.2),
        padding: const EdgeInsets.symmetric(vertical: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
        textStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
  );
}
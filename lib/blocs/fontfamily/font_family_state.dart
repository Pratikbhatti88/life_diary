part of 'font_family_bloc.dart';

@immutable
abstract class FontFamilyState {}

class FontFamilyInitial extends FontFamilyState {}

class FontFamilyGet extends FontFamilyState {
  final String fontFamily;

  FontFamilyGet({required this.fontFamily});
}

class ErrorForFetch extends FontFamilyState {
  final String error;

  ErrorForFetch({required this.error});
}

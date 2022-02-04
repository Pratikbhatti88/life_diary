part of 'font_family_bloc.dart';

@immutable
abstract class FontFamilyEvent {}

class FetchFontFamily extends FontFamilyEvent {
  final String fontFamily;

  FetchFontFamily({required this.fontFamily});
}

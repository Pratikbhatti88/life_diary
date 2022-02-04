import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'font_family_event.dart';

part 'font_family_state.dart';

class FontFamilyBloc extends Bloc<FontFamilyEvent, FontFamilyState> {
  FontFamilyBloc() : super(FontFamilyInitial()) {
    on<FetchFontFamily>((event, emit) {
      try {
        emit(FontFamilyGet(fontFamily: event.fontFamily));
      } catch (e) {
        emit(ErrorForFetch(error: e.toString()));
      }
    });


  }
}

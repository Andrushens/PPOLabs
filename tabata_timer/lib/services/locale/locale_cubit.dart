import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tabata_timer/services/locale/en.dart';
import 'package:tabata_timer/services/locale/ru.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState(consts: enConsts));

  void changeLocale() {
    emit(
      LocaleState(
        consts: state.consts == enConsts ? ruConsts : enConsts,
      ),
    );
  }
}

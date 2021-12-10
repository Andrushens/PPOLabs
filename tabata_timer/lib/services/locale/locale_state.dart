part of 'locale_cubit.dart';

class LocaleState extends Equatable {
  final Map<String, String> consts;

  const LocaleState({
    this.consts = const {},
  });

  @override
  List<Object?> get props {
    return [consts];
  }
}

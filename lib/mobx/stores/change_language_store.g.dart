// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_language_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChangeLanguageStore on ChangeLanguageStoreBase, Store {
  late final _$localeAtom =
      Atom(name: 'ChangeLanguageStoreBase.locale', context: context);

  @override
  Locale? get locale {
    _$localeAtom.reportRead();
    return super.locale;
  }

  @override
  set locale(Locale? value) {
    _$localeAtom.reportWrite(value, super.locale, () {
      super.locale = value;
    });
  }

  late final _$ChangeLanguageStoreBaseActionController =
      ActionController(name: 'ChangeLanguageStoreBase', context: context);

  @override
  Locale setLocale() {
    final _$actionInfo = _$ChangeLanguageStoreBaseActionController.startAction(
        name: 'ChangeLanguageStoreBase.setLocale');
    try {
      return super.setLocale();
    } finally {
      _$ChangeLanguageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locale: ${locale}
    ''';
  }
}

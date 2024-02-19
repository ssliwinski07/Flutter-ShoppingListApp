// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainScreenStore on MainScreenStoreBase, Store {
  late final _$iconsDirectoryAtom =
      Atom(name: 'MainScreenStoreBase.iconsDirectory', context: context);

  @override
  List<String> get iconsDirectory {
    _$iconsDirectoryAtom.reportRead();
    return super.iconsDirectory;
  }

  @override
  set iconsDirectory(List<String> value) {
    _$iconsDirectoryAtom.reportWrite(value, super.iconsDirectory, () {
      super.iconsDirectory = value;
    });
  }

  late final _$localeAtom =
      Atom(name: 'MainScreenStoreBase.locale', context: context);

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

  late final _$MainScreenStoreBaseActionController =
      ActionController(name: 'MainScreenStoreBase', context: context);

  @override
  Locale setLocale() {
    final _$actionInfo = _$MainScreenStoreBaseActionController.startAction(
        name: 'MainScreenStoreBase.setLocale');
    try {
      return super.setLocale();
    } finally {
      _$MainScreenStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  int pickRandomIcon(int range) {
    final _$actionInfo = _$MainScreenStoreBaseActionController.startAction(
        name: 'MainScreenStoreBase.pickRandomIcon');
    try {
      return super.pickRandomIcon(range);
    } finally {
      _$MainScreenStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
iconsDirectory: ${iconsDirectory},
locale: ${locale}
    ''';
  }
}

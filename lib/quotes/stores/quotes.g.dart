// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QuotesStore on _QuotesStoreBase, Store {
  Computed<StoreState>? _$stateComputed;

  @override
  StoreState get state =>
      (_$stateComputed ??= Computed<StoreState>(() => super.state,
              name: '_QuotesStoreBase.state'))
          .value;

  late final _$quoteAtom =
      Atom(name: '_QuotesStoreBase.quote', context: context);

  @override
  Quote? get quote {
    _$quoteAtom.reportRead();
    return super.quote;
  }

  @override
  set quote(Quote? value) {
    _$quoteAtom.reportWrite(value, super.quote, () {
      super.quote = value;
    });
  }

  late final _$errorAtom =
      Atom(name: '_QuotesStoreBase.error', context: context);

  @override
  Failure? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Failure? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$getRandomAsyncAction =
      AsyncAction('_QuotesStoreBase.getRandom', context: context);

  @override
  Future<dynamic> getRandom() {
    return _$getRandomAsyncAction.run(() => super.getRandom());
  }

  @override
  String toString() {
    return '''
quote: ${quote},
error: ${error},
state: ${state}
    ''';
  }
}

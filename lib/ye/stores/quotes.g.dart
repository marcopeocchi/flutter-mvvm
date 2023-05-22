// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Counter on CounterBase, Store {
  late final _$quoteAtom = Atom(name: 'CounterBase.quote', context: context);

  @override
  Quote get quote {
    _$quoteAtom.reportRead();
    return super.quote;
  }

  @override
  set quote(Quote value) {
    _$quoteAtom.reportWrite(value, super.quote, () {
      super.quote = value;
    });
  }

  late final _$CounterBaseActionController =
      ActionController(name: 'CounterBase', context: context);

  @override
  void getRandom() {
    final _$actionInfo = _$CounterBaseActionController.startAction(
        name: 'CounterBase.getRandom');
    try {
      return super.getRandom();
    } finally {
      _$CounterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
quote: ${quote}
    ''';
  }
}

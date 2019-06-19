// from https://flutter.dev/docs/development/data-and-backend/json#manual-encoding
// and from https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
// and some of my own stuff, too

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

// one-time build: $ flutter pub run build_runner build
// any-time build: $ flutter pub run build_runner watch
part 'family_model.g.dart';

// container of a custom collection type
// needs to use the toJson/fromJson directly
@JsonSerializable()
class Family extends ChangeNotifier {
  String _name;
  final People _people;

  String get name => _name;
  set name(String name) {
    _name = name;
    notifyListeners();
  }

  // NOTE: uses List<Person> instead of People for json serializer
  List<Person> get people => _people;
  set people(List<Person> people) {
    _people.clear();
    _people.addAll(people);
    notifyListeners();
  }

  // NOTE: uses List<Person> instead of People for json serializer
  Family(String name, List<Person> people)
      : _name = name,
        _people = People(people);

  factory Family.fromJson(Map<String, dynamic> json) => _$FamilyFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyToJson(this);

  String toString() => "$name Family: $people";
}

class People extends ListBase<Person> with ChangeNotifier {
  final List<Person> _items;

  People(List<Person> items) : _items = items;

  @override
  int get length => _items.length;
  set length(int value) => _items.length = value;

  @override
  Person operator [](int index) => _items[index];

  @override
  void operator []=(int index, Person value) {
    _items[index] = value;
    notifyListeners();
  }

  String toString() => '${_items.toString()}';
}

// simple type
// can be simple
@JsonSerializable()
class Person extends ChangeNotifier {
  String _name;
  int _age;

  String get name => _name;
  set name(String name) {
    _name = name;
    notifyListeners();
  }

  int get age => _age;
  set age(int age) {
    _age = age;
    notifyListeners();
  }

  Person(String name, int age)
      : _name = name,
        _age = age;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);

  String toString() => '$name is $age years old';
}

// ignore: file_names
import 'dart:collection';

import 'package:frontend/features/customers/index.dart';
import 'package:darq/darq.dart';
import 'package:flutter/material.dart';

class CustomersRepository {
  CustomersRepository._();

  static final List<Customer> _backend = [];

  static void generate(CustomersCubit bloc) {
    _backend.clear();
    if (bloc.allCustmomers == null) {
      bloc.getAllCustomersLogic().then((data) {
        if (!data.hasError) {
          _backend.addAll(data.customers ?? []);
        }
      });
    } else {
      _backend.addAll((bloc.allCustmomers ?? []) as Iterable<Customer>);
    }
  }

  static Future<PaginatedList<Customer>> getCustomers({
    required int pageSize,
    required String? pageToken,
    Gender? gender,
    DateTimeRange? createdAtBetween,
    DateTimeRange? dateOfBirthBetween,
    String? name,
    String? searchQuery,
    String? sortBy,
    bool sortDescending = false,
    required CustomersCubit bloc,
  }) async {
    // Decode page token
    // ignore: unused_local_variable
    int nextId = pageToken == null ? 0 : int.tryParse(pageToken) ?? 1;

    if (_backend.isEmpty) {
      await bloc.getAllCustomersLogic().then((data) {
        if (!data.hasError) {
          _backend.addAll(data.customers ?? []);
        }
      });
    }

    Iterable<Customer> query = _backend;

    if (sortBy == null) {
      query = query.orderBy((element) => element.id);
    } else {
      switch (sortBy) {
        case "dateOfBirth":
          query = sortDescending
              ? query.orderByDescending(
                  (element) => element.dateOfBirth?.millisecondsSinceEpoch)
              : query.orderBy(
                  (element) => element.dateOfBirth?.millisecondsSinceEpoch);
          break;

        case "createdAt":
          query = sortDescending
              ? query.orderByDescending(
                  (element) => element.createdAt?.millisecondsSinceEpoch)
              : query.orderBy(
                  (element) => element.createdAt?.millisecondsSinceEpoch);
          break;
      }
    }

    // query = query.where((element) => element.id >= nextId);

    if (gender != null) {
      query = query.where((element) => element.gender == gender);
    }

    if (createdAtBetween != null) {
      query = query.where((element) =>
          createdAtBetween.start.isBefore(element.createdAt!) &&
          createdAtBetween.end.isAfter(element.createdAt!));
    }

    if (dateOfBirthBetween != null) {
      query = query.where((element) =>
          dateOfBirthBetween.start.isBefore(element.dateOfBirth!) &&
          dateOfBirthBetween.end.isAfter(element.dateOfBirth!));
    }

    if (name != null) {
      query = query.where((element) =>
          element.firstName!.toLowerCase().contains(name.toLowerCase()) ||
          element.lastName!.toLowerCase().contains(name.toLowerCase()));
    }

    if (searchQuery != null) {
      final pattern = RegExp.escape(searchQuery.toLowerCase());
      query = query.where((element) =>
          element.firstName!.toLowerCase().startsWith(pattern) ||
          element.lastName!.toLowerCase().contains(pattern) ||
          element.email!.toLowerCase().contains(pattern) ||
          element.phoneNumber!.toLowerCase().contains(pattern));
    }

    var resultSet = query.take(pageSize + 1).toList();
    String? nextPageToken;
    if (resultSet.length == pageSize + 1) {
      Customer lastCustomer = resultSet.removeLast();
      nextPageToken = lastCustomer.id.toString();
    }

    return PaginatedList(items: resultSet, nextPageToken: nextPageToken);
  }
}

class PaginatedList<T> {
  final Iterable<T> _items;
  final String? _nextPageToken;

  List<T> get items => UnmodifiableListView(_items);
  String? get nextPageToken => _nextPageToken;

  PaginatedList({required Iterable<T> items, String? nextPageToken})
      : _items = items,
        _nextPageToken = nextPageToken;
}

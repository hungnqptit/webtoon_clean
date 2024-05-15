// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Extension methods on common collection types.
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';

extension ListWidgetExt on List<Widget> {
  List<Widget> separator(Widget Function(int index) creator) {
    if (this.length < 2) return this;
    final List<Widget> newList = List.from(this);
    final int length = this.length;
    for (var i = length - 2; i >= 0; i--) {
      newList.insert(i + 1, creator.call(i));
    }

    return newList;
  }
}

/// Various extensions on lists of arbitrary elements.
extension ListExtensions<E> on List<E> {
  /// Takes an action for each element.
  ///
  /// Calls [action] for each element along with the index in the
  /// iteration order.
  void forEachIndexed(void Function(int index, E element) action) {
    for (var index = 0; index < length; index++) {
      action(index, this[index]);
    }
  }

  /// Takes an action for each element as long as desired.
  ///
  /// Calls [action] for each element.
  /// Stops iteration if [action] returns `false`.
  void forEachWhile(bool Function(E element) action) {
    for (var index = 0; index < length; index++) {
      if (!action(this[index])) break;
    }
  }

  /// Takes an action for each element and index as long as desired.
  ///
  /// Calls [action] for each element along with the index in the
  /// iteration order.
  /// Stops iteration if [action] returns `false`.
  void forEachIndexedWhile(bool Function(int index, E element) action) {
    for (var index = 0; index < length; index++) {
      if (!action(index, this[index])) break;
    }
  }

  /// Maps each element and its index to a new value.
  Iterable<R> mapIndexed<R>(R Function(int index, E element) convert) sync* {
    for (var index = 0; index < length; index++) {
      yield convert(index, this[index]);
    }
  }

  /// The elements whose value and index satisfies [test].
  Iterable<E> whereIndexed(bool Function(int index, E element) test) sync* {
    for (var index = 0; index < length; index++) {
      var element = this[index];
      if (test(index, element)) yield element;
    }
  }

  /// The elements whose value and index do not satisfy [test].
  Iterable<E> whereNotIndexed(bool Function(int index, E element) test) sync* {
    for (var index = 0; index < length; index++) {
      var element = this[index];
      if (!test(index, element)) yield element;
    }
  }

  /// Expands each element and index to a number of elements in a new iterable.
  ///
  /// Like [Iterable.expand] except that the callback function is supplied with
  /// both the index and the element.
  Iterable<R> expandIndexed<R>(
      Iterable<R> Function(int index, E element) expand) sync* {
    for (var index = 0; index < length; index++) {
      yield* expand(index, this[index]);
    }
  }

  /// Reverses the elements in a range of the list.
  void reverseRange(int start, int end) {
    RangeError.checkValidRange(start, end, length);
    while (start < --end) {
      var tmp = this[start];
      this[start] = this[end];
      this[end] = tmp;
      start += 1;
    }
  }

  /// Swaps two elements of this list.
  void swap(int index1, int index2) {
    RangeError.checkValidIndex(index1, this, 'index1');
    RangeError.checkValidIndex(index2, this, 'index2');
    var tmp = this[index1];
    this[index1] = this[index2];
    this[index2] = tmp;
  }

  /// A fixed length view of a range of this list.
  ///
  /// The view is backed by this list, which must not change its length while
  /// the view is being used.
  ///
  /// The view can be used to perform specific whole-list
  /// actions on a part of the list.
  /// For example, to see if a list contains more than one
  /// "marker" element, you can do:
  /// ```dart
  /// someList.slice(someList.indexOf(marker) + 1).contains(marker)
  /// ```
  ListSlice<E> slice(int start, [int? end]) {
    end = RangeError.checkValidRange(start, end, length);
    var self = this;
    if (self is ListSlice<E>) return self.slice(start, end);
    return ListSlice<E>(this, start, end);
  }

  /// The [index]th element, or `null` if there is no such element.
  ///
  /// Returns the element at position [index] of this list,
  /// just like [elementAt], if this list has such an element.
  /// If this list does not have enough elements to have one with the given
  /// [index], the `null` value is returned, unlike [elementAt] which throws
  /// instead.
  ///
  /// The [index] must not be negative.
  E? elementAtOrNull(int index) => (index < length) ? this[index] : null;

  /// Contiguous [slice]s of `this` with the given [length].
  ///
  /// Each slice is a view of this list [length] elements long, except for the
  /// last one which may be shorter if `this` contains too few elements. Each
  /// slice begins after the last one ends.
  ///
  /// As with [slice], these slices are backed by this list, which must not
  /// change its length while the views are being used.
  ///
  /// For example, `[1, 2, 3, 4, 5].slices(2)` returns `[[1, 2], [3, 4], [5]]`.
  Iterable<List<E>> slices(int length) sync* {
    if (length < 1) throw RangeError.range(length, 1, null, 'length');
    for (var i = 0; i < this.length; i += length) {
      yield slice(i, min(i + length, this.length));
    }
  }
}

/// A list view of a range of another list.
///
/// Wraps the range of the [source] list from [start] to [end]
/// and acts like a fixed-length list view of that range.
/// The source list must not change length while a list slice is being used.
class ListSlice<E> extends ListBase<E> {
  /// Original length of [source].
  ///
  /// Used to detect modifications to [source] which may invalidate
  /// the slice.
  final int _initialSize;

  /// The original list backing this slice.
  final List<E> source;

  /// The start index of the slice.
  final int start;

  @override
  final int length;

  /// Creates a slice of [source] from [start] to [end].
  ListSlice(this.source, this.start, int end)
      : length = end - start,
        _initialSize = source.length {
    RangeError.checkValidRange(start, end, source.length);
  }

  // No argument checking, for internal use.
  ListSlice._(this._initialSize, this.source, this.start, this.length);

  /// The end index of the slice.
  int get end => start + length;

  @override
  E operator [](int index) {
    if (source.length != _initialSize) {
      throw ConcurrentModificationError(source);
    }
    RangeError.checkValidIndex(index, this, null, length);
    return source[start + index];
  }

  @override
  void operator []=(int index, E value) {
    if (source.length != _initialSize) {
      throw ConcurrentModificationError(source);
    }
    RangeError.checkValidIndex(index, this, null, length);
    source[start + index] = value;
  }

  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    if (source.length != _initialSize) {
      throw ConcurrentModificationError(source);
    }
    RangeError.checkValidRange(start, end, length);
    source.setRange(start + start, start + end, iterable, skipCount);
  }

  /// A fixed length view of a range of this list.
  ///
  /// The view is backed by this list, which must not change its length while
  /// the view is being used.
  ///
  /// The view can be used to perform specific whole-list
  /// actions on a part of the list.
  /// For example, to see if a list contains more than one
  /// "marker" element, you can do:
  /// ```dart
  /// someList.slice(someList.indexOf(marker) + 1).contains(marker)
  /// ```
  ListSlice<E> slice(int start, [int? end]) {
    end = RangeError.checkValidRange(start, end, length);
    return ListSlice._(_initialSize, source, this.start + start, end - start);
  }

  /// Reverses a range of elements.
  void reverseRange(int start, int end) {
    RangeError.checkValidRange(start, end, length);
    source.reverseRange(this.start + start, this.start + end);
  }

  // Act like a fixed-length list.

  @override
  set length(int newLength) {
    throw UnsupportedError('Cannot change the length of a fixed-length list');
  }

  @override
  void add(E element) {
    throw UnsupportedError('Cannot add to a fixed-length list');
  }

  @override
  void insert(int index, E element) {
    throw UnsupportedError('Cannot add to a fixed-length list');
  }

  @override
  void insertAll(int index, Iterable<E> iterable) {
    throw UnsupportedError('Cannot add to a fixed-length list');
  }

  @override
  void addAll(Iterable<E> iterable) {
    throw UnsupportedError('Cannot add to a fixed-length list');
  }

  @override
  bool remove(Object? element) {
    throw UnsupportedError('Cannot remove from a fixed-length list');
  }

  @override
  void removeWhere(bool Function(E element) test) {
    throw UnsupportedError('Cannot remove from a fixed-length list');
  }

  @override
  void retainWhere(bool Function(E element) test) {
    throw UnsupportedError('Cannot remove from a fixed-length list');
  }

  @override
  void clear() {
    throw UnsupportedError('Cannot clear a fixed-length list');
  }

  @override
  E removeAt(int index) {
    throw UnsupportedError('Cannot remove from a fixed-length list');
  }

  @override
  E removeLast() {
    throw UnsupportedError('Cannot remove from a fixed-length list');
  }

  @override
  void removeRange(int start, int end) {
    throw UnsupportedError('Cannot remove from a fixed-length list');
  }

  @override
  void replaceRange(int start, int end, Iterable<E> newContents) {
    throw UnsupportedError('Cannot remove from a fixed-length list');
  }
}

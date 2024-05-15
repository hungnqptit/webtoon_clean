// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';

class ASkeleton extends StatefulWidget {
  final ASkeletonConfigs configs;

  const ASkeleton({
    super.key,
    required this.configs,
  });

  @override
  State<ASkeleton> createState() => _ASkeletonPrivateState();
}

class _ASkeletonPrivateState extends State<ASkeleton> {
  double _opacity = ShimmerManager.shared.currentOpacity;
  StreamSubscription<bool>? _streamSubscription;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = ShimmerManager.shared.isAnimationForward
            ? ShimmerManager.shared.minOpacity
            : ShimmerManager.shared.maxOpacity;
      });
    });

    _streamSubscription =
        ShimmerManager.shared.stream.listen((isAnimationForward) {
      setState(() {
        _opacity = isAnimationForward
            ? ShimmerManager.shared.minOpacity
            : ShimmerManager.shared.maxOpacity;
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: Duration(milliseconds: ShimmerManager.shared.duration),
      child: Container(
        width: widget.configs.width,
        height: widget.configs.height,
        decoration: BoxDecoration(
          color: widget.configs.color,
          borderRadius: widget.configs.borderRadius,
        ),
      ),
    );
  }
}

class ASkeletonConfigs {
  double? width;
  double? height;
  Color? color;
  BorderRadiusGeometry? borderRadius;

  ASkeletonConfigs({
    this.width,
    this.height,
    this.color,
    this.borderRadius,
  });

  ASkeletonConfigs copyWith({
    double? width,
    double? height,
    Color? color,
    BorderRadiusGeometry? borderRadius,
  }) {
    return ASkeletonConfigs(
      width: width ?? this.width,
      height: height ?? this.height,
      color: color ?? this.color,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}

class ShimmerManager {
  static ShimmerManager? _instance;

  static ShimmerManager get shared {
    _instance ??= ShimmerManager._internal();

    return _instance!;
  }

  ShimmerManager._internal() {
    if (_timer != null) return;

    _timer = Timer.periodic(Duration(milliseconds: _intervalValue), (_) {
      _currentCount += _intervalValue;
      if (_currentCount >= duration * 10) _currentCount = 0;

      final oldIsAnimationForward = _isAnimationForward;
      _isAnimationForward = (_currentCount ~/ duration) % 2 == 0;

      if (oldIsAnimationForward != _isAnimationForward) {
        _sink.add(_isAnimationForward);
      }
    });
  }

  // Configs
  final int _speed = 2;
  final _step = 7;
  final _intervalValue = 100;
  int get duration => _intervalValue * _step * _speed;

  // Stream
  final StreamController<bool> _streamController = StreamController.broadcast();
  Stream<bool> get stream => _streamController.stream;
  StreamSink<bool> get _sink => _streamController.sink;

  // Opacity values
  double get maxOpacity => 1;
  double get minOpacity {
    double min = 1 - (0.1 * _step);
    if (min < 0) min = 0;
    if (min > maxOpacity) min = maxOpacity;

    return min;
  }

  double get currentOpacity {
    final offset = (_currentCount % duration) / _speed / _intervalValue;
    double result = _isAnimationForward
        ? maxOpacity - (0.1 * offset)
        : maxOpacity - (0.1 * _step) + (0.1 * offset);
    if (result < minOpacity) result = minOpacity;
    if (result > maxOpacity) result = maxOpacity;

    return result;
  }

  // Variables
  Timer? _timer;
  int _currentCount = 0;

  bool _isAnimationForward = true;
  bool get isAnimationForward => _isAnimationForward;
}

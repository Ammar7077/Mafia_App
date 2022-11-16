import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mafia_app/providers/provider.dart';
import 'package:provider/provider.dart';

class MafiaCard extends StatelessWidget {
  final String name;
  const MafiaCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<MyProvider>(
      builder: (context, provider, child) => Scaffold(
        body: Container(
          color: const Color.fromRGBO(52, 58, 64, 1),
          child: Center(
            child: SizedBox(
              width: width * 0.85,
              height: height * 0.6,
              child: FlipCard(
                toggler: provider.toggler,
                frontCard: AppCard(
                    title: Image.asset(
                  'assets/Mafia_Logo.png',
                  height: height * 0.2,
                )),
                backCard: AppCard(
                  title: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AppCard extends StatelessWidget {
  Widget title;

  AppCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
      builder: (context, provider, child) => DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.black,
        ),
        child: InkWell(
          onTap: () => provider.onFlipCardPressed(),
          child: Center(
            child: title,
          ),
        ),
      ),
    );
  }
}

class FlipCard extends StatelessWidget {
  final bool toggler;
  final Widget frontCard;
  final Widget backCard;

  const FlipCard({
    super.key,
    required this.toggler,
    required this.backCard,
    required this.frontCard,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: _transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease.flipped,
        child: toggler
            ? SizedBox(key: const ValueKey('front'), child: frontCard)
            : SizedBox(key: const ValueKey('back'), child: backCard),
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnimation = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnimation,
      child: widget,
      builder: (context, widget) {
        final isFront = ValueKey(toggler) == widget!.key;
        final rotationY = isFront
            ? rotateAnimation.value
            : min(rotateAnimation.value, pi * 0.5);
        return Transform(
          transform: Matrix4.rotationY(rotationY)..setEntry(3, 0, 0),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}

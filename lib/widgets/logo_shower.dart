import 'package:flutter/material.dart';

class AssetLogoShower extends StatelessWidget {
  const AssetLogoShower({
    Key? key,
    required this.logo,
    required this.size,
  }) : super(key: key);

  final String logo;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(logo),
        ),
      ),
    );
  }
}

class LogoShower extends StatelessWidget {
  const LogoShower({
    Key? key,
    required this.logo,
    required this.size,
  }) : super(key: key);

  final ImageProvider<Object> logo;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: logo,
        ),
      ),
    );
  }
}

class ImageShower extends StatelessWidget {
  const ImageShower({
    Key? key,
    required this.logo,
    required this.size,
  }) : super(key: key);

  final String logo;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(logo),
          fit: BoxFit.fitHeight
        ),
      ),
    );
  }
}

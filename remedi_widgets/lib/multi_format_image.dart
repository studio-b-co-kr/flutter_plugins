import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MultiFormatImage extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String resource;
  final Color? color;
  final ResourceType resourceType;
  final ImageFormat format;

  MultiFormatImage._(
      {Key? key,
      this.width,
      this.height,
      this.fit,
      this.color,
      required this.resource,
      required this.format,
      required this.resourceType})
      : assert(format == ImageFormat.svg && fit != null),
        super(key: key);

  factory MultiFormatImage.asset(
    String asset, {
    required ImageFormat format,
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return MultiFormatImage._(
      resource: asset,
      format: format,
      width: width,
      height: height,
      fit: fit,
      resourceType: ResourceType.asset,
    );
  }

  factory MultiFormatImage.network(
    String url, {
    required ImageFormat format,
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return MultiFormatImage._(
      resource: url,
      format: format,
      width: width,
      height: height,
      fit: fit,
      resourceType: ResourceType.network,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (resourceType) {
      case ResourceType.asset:
        return _buildAsset(context);
      case ResourceType.network:
        return _buildNetwork(context);
    }
  }

  Widget _buildAsset(BuildContext context) {
    switch (format) {
      case ImageFormat.svg:
        return _buildAssetSvg(context);
      case ImageFormat.others:
        return _buildAssetOthers(context);
    }
  }

  Widget _buildNetwork(BuildContext context) {
    switch (format) {
      case ImageFormat.svg:
        return _buildNetworkSvg(context);
      case ImageFormat.others:
        return _buildNetworkOthers(context);
    }
  }

  Widget _buildNetworkSvg(BuildContext context) {
    return SvgPicture.network(
      resource,
      fit: fit!,
      width: width,
      height: height,
      color: color,
    );
  }

  Widget _buildAssetSvg(BuildContext context) {
    return SvgPicture.asset(
      resource,
      fit: fit!,
      width: width,
      height: height,
      color: color,
    );
  }

  Widget _buildNetworkOthers(BuildContext context) {
    return ExtendedImage.network(
      resource,
      fit: fit,
      width: width,
      height: height,
    );
  }

  Widget _buildAssetOthers(BuildContext context) {
    return ExtendedImage.asset(
      resource,
      fit: fit,
      width: width,
      height: height,
    );
  }
}

enum ImageFormat {
  svg,
  // animatedGif,
  others,
}

enum ResourceType {
  asset,
  network,
}

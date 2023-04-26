import 'package:flutter/material.dart';
import 'package:ticket_module/ui/shared/colors.dart';

/// Collection of IconButtons that are using in this app

class RemoveIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final double? size;

  const RemoveIcon({Key? key, this.onTap, this.color, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.highlight_remove,
        size: size ?? width * 0.0446,
        color: color ?? removeIconColor,
      ),
    );
  }
}

class KeyboardArrowDownIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;

  const KeyboardArrowDownIcon({Key? key, this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.keyboard_arrow_down_sharp,
        color: color ?? primaryDark,
        size: width * 0.0426,
      ),
    );
  }
}

class ArrowBackIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;

  const ArrowBackIcon({Key? key, this.onTap, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.arrow_back_ios_new,
        color: color ?? primaryDark,
        size: width * 0.0426,
      ),
    );
  }
}

class CloseIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;

  const CloseIcon({Key? key, this.onTap, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.close,
        color: color ?? primaryDark,
        size: width * 0.0426,
      ),
    );
  }
}

class CameraIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final double? size;

  const CameraIcon({Key? key, this.onTap, this.color, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.camera_alt,
        color: color ?? primaryDark,
        size: size ?? width * 0.048,
      ),
    );
  }
}

class GalleryIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final double? size;

  const GalleryIcon({Key? key, this.onTap, this.color, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.image,
        color: color ?? primaryDark,
        size: size ?? width * 0.048,
      ),
    );
  }
}

class AttachmentIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final double? size;

  const AttachmentIcon({Key? key, this.onTap, this.color, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.attach_file,
        color: color ?? primaryDark,
        size: size ?? width * 0.048,
      ),
    );
  }
}

class ReplayIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isFill;
  final Color? color;
  final double? size;

  const ReplayIcon(
      {Key? key, this.onTap, this.isFill = true, this.color, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        isFill ? Icons.replay_circle_filled : Icons.replay,
        size: size ?? width * 0.0533,
        color: color ?? brandMainColor,
      ),
    );
  }
}

class DeleteIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final double? size;
  final Color? color;
  final bool isFill;

  const DeleteIcon(
      {Key? key, this.onTap, this.size, this.isFill = false, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        isFill ? Icons.delete : Icons.delete_outline,
        color: color ?? primaryErrorColor,
        size: size ?? width * 0.0533,
      ),
    );
  }
}

class KeyboardArrowUpIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;

  const KeyboardArrowUpIcon({Key? key, this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.keyboard_arrow_up_sharp,
        color: color ?? primaryDark,
        size: width * 0.0426,
      ),
    );
  }
}

class SupporterIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final double? size;

  const SupporterIcon({Key? key, this.onTap, this.color, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.support_agent,
        color: color ?? primaryDark,
        size: size ?? width * 0.048,
      ),
    );
  }
}

class ClientIcon extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final double? size;

  const ClientIcon({Key? key, this.onTap, this.color, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Icon(
        Icons.person_outline,
        color: color ?? primaryDark,
        size: size ?? width * 0.048,
      ),
    );
  }
}

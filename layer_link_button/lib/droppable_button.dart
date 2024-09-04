import 'package:flutter/material.dart';

class DroppableDestination<T> {
  T value;
  Widget child;
  DroppableDestination({
    required this.value,
    required this.child,
  });
}

class DroppableButton<T> extends StatefulWidget {
  const DroppableButton(
      {super.key,
      required this.selection,
      required this.destinations,
      required this.onDestinationSelected});

  final Widget selection;
  final List<DroppableDestination<T>> destinations;

  final void Function(T value) onDestinationSelected;

  @override
  State<DroppableButton> createState() => _DroppableButtonState();
}

class _DroppableButtonState extends State<DroppableButton>
    with _DestinationsApiMixin, _DestinationsOverlayMixin {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.red.withOpacity(0.3)),
      child: widget.selection,
    );
  }

}

mixin _DestinationsApiMixin on State<DroppableButton> {
  void show() {}
  void hide() {}
}

mixin _DestinationsOverlayMixin on _DestinationsApiMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  @override
  void hide() {
    super.hide();
    if (_overlayEntry == null) return;

    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void show() {
    super.show();
    hide();

    Overlay.of(context).insert(_overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        height: 40,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(-2, 0),
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          showWhenUnlinked: false,
          child: _DestinationsLayout(
            destinations: widget.destinations,
            onSelectDestination: widget.onDestinationSelected,
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: super.build(context),
    );
  }
}

class _DestinationsLayout<T> extends StatelessWidget {
  const _DestinationsLayout({
    super.key,
    required this.destinations,
    required this.onSelectDestination,
  });

  final List<DroppableDestination> destinations;

  final void Function(T value) onSelectDestination;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 130,
        child: ListView(
          children: destinations.map((e) => e.child).toList(),
        ),
      ),
    );
  }
}

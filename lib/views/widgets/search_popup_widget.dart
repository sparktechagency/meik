import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/views/widgets/custom_container.dart';
import 'package:danceattix/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ── Model ────────────────────────────────────────────────────────────────────

class SearchItem {
  final String id;
  final String name;
  final String? image;
  final String? subtitle;
  final dynamic raw;

  const SearchItem({
    required this.id,
    required this.name,
    this.image,
    this.subtitle,
    this.raw,
  });
}

// ── Widget ───────────────────────────────────────────────────────────────────

/// Usage:
/// ```dart
/// GlobalSearchField(
///   hintText: 'Search products...',
///   onSearch: (term) async {
///     await _productController.productsGet(term: term);
///     return _productController.productsData
///         .map((e) => SearchItem(
///               id: e.id?.toString() ?? '',
///               name: e.productName ?? '',
///               image: e.image,
///               subtitle: '৳${e.price}',
///               raw: e,
///             ))
///         .toList();
///   },
///   cardBuilder: (item, onTap) => MyProductCard(item: item, onTap: onTap),
/// )
/// ```
class GlobalSearchField extends StatefulWidget {
  final Future<List<SearchItem>> Function(String term) onSearch;
  final Widget Function(SearchItem item, VoidCallback onTap) cardBuilder;

  final String hintText;
  final Color? primaryColor;
  final Duration debounceDuration;
  final double maxOverlayHeight;

  const GlobalSearchField({
    super.key,
    required this.onSearch,
    required this.cardBuilder,
    this.hintText = 'Search...',
    this.primaryColor,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.maxOverlayHeight = 300,
  });

  @override
  State<GlobalSearchField> createState() => _GlobalSearchFieldState();
}

class _GlobalSearchFieldState extends State<GlobalSearchField> {
  final _ctrl = TextEditingController();
  final _layerLink = LayerLink();
  OverlayEntry? _overlay;

  bool _loading = false;
  List<SearchItem> _results = [];
  String _currentTerm = '';

  Color get _primary => widget.primaryColor ?? const Color(0xFF6C63FF);

  void _onChanged(String value) {
    final term = value.trim();
    _currentTerm = term;

    if (term.isEmpty) {
      _removeOverlay();
      return;
    }

    _showOverlay();
    Future.delayed(widget.debounceDuration, () => _hit(term));
  }

  Future<void> _hit(String term) async {
    if (term != _currentTerm || !mounted) return;

    setState(() => _loading = true);
    _overlay?.markNeedsBuild();

    try {
      final res = await widget.onSearch(term);
      if (term != _currentTerm || !mounted) return;
      setState(() { _results = res; _loading = false; });
    } catch (_) {
      if (!mounted) return;
      setState(() { _results = []; _loading = false; });
    }
    _overlay?.markNeedsBuild();
  }

  void _showOverlay() {
    if (_overlay != null) { _overlay!.markNeedsBuild(); return; }
    _overlay = OverlayEntry(builder: _buildOverlay);
    Overlay.of(context).insert(_overlay!);
  }

  void _removeOverlay() {
    _overlay?.remove();
    _overlay = null;
    if (mounted) setState(() { _results = []; _loading = false; });
  }

  Widget _buildOverlay(BuildContext _) => Positioned(
    width: MediaQuery.of(context).size.width - 32.w,
    child: CompositedTransformFollower(
      link: _layerLink,
      showWhenUnlinked: false,
      offset: Offset(0, 58.h),
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(maxHeight: widget.maxOverlayHeight.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.09),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: _loading
                ? _Loader(color: _primary)
                : _results.isEmpty
                ? const _Empty()
                : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              shrinkWrap: true,
              itemCount: _results.length,
              itemBuilder: (_, i) {
                final item = _results[i];
                return widget.cardBuilder(item, () {
                  _ctrl.text = item.name;
                  _removeOverlay();
                });
              },
            ),
          ),
        ),
      ),
    ),
  );

  @override
  void dispose() {
    _ctrl.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: CompositedTransformTarget(
        link: _layerLink,
        child:  CustomTextField(
          onChanged: _onChanged,
          hintextSize: 16.sp,
          borderRadio: 50.r,
          contentPaddingVertical: 0,
          borderColor: Colors.transparent,
          validator: (_) => null,
          hintText: widget.hintText ??  'Search...',
          suffixIcon: CustomContainer(
            marginAll: 2.r,
            paddingAll: 8.r,
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          controller: _ctrl,
        ),
      ),
    );
  }
}

// ── Helpers ──────────────────────────────────────────────────────────────────

class _Loader extends StatelessWidget {
  final Color color;
  const _Loader({required this.color});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 24.h),
    child: Center(
      child: SizedBox(
        width: 22.w,
        height: 22.w,
        child: CircularProgressIndicator(strokeWidth: 2, color: color),
      ),
    ),
  );
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
    child: Row(children: [
      Icon(Icons.search_off_rounded, color: Colors.grey[400], size: 18.sp),
      SizedBox(width: 8.w),
      Text(
        'No results found',
        style: TextStyle(fontSize: 13.sp, color: Colors.grey[500]),
      ),
    ]),
  );
}
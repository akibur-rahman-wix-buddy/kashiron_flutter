import 'package:flutter/material.dart';
import 'package:kashirons_flutter/common_widgets/shimmerClipOverImageWidget.dart';
import 'package:kashirons_flutter/feature/create_spark_and_self/model/get_all_vip_data_model.dart';
import 'package:kashirons_flutter/networks/api_acess.dart';
import 'package:kashirons_flutter/networks/endpoints.dart';

class VipDropdown {
  static void show({
    required BuildContext context,
    required TextEditingController controller,
    required GlobalKey textFieldKey,
    double width = 280,
    Function(String vipId, String vipName)? onVipSelected,
    VoidCallback? onValueChanged,
  }) {
    final RenderBox renderBox =
        textFieldKey.currentContext!.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    final OverlayState overlayState = Overlay.of(context);

    late OverlayEntry dropdownOverlayEntry;

    dropdownOverlayEntry = OverlayEntry(
      builder: (context) => _VipDropdownContent(
        position: Offset(offset.dx, offset.dy + size.height + 5),
        width: width,
        controller: controller,
        onVipSelected: onVipSelected,
        onClose: () => dropdownOverlayEntry.remove(),
      ),
    );

    overlayState.insert(dropdownOverlayEntry);
  }
}

class _VipDropdownContent extends StatefulWidget {
  final Offset position;
  final double width;
  final TextEditingController controller;
  final Function(String vipId, String vipName)? onVipSelected;
  final VoidCallback onClose;

  const _VipDropdownContent({
    required this.position,
    required this.width,
    required this.controller,
    this.onVipSelected,
    required this.onClose,
  });

  @override
  State<_VipDropdownContent> createState() => _VipDropdownContentState();
}

class _VipDropdownContentState extends State<_VipDropdownContent> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onClose,
            child: Container(color: Colors.transparent),
          ),
        ),
        Positioned(
          left: widget.position.dx,
          right: widget.position.dx,
          top: widget.position.dy,
          child: Material(
            color: const Color(0xFF1C1F2E),
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: widget.width,
              constraints: const BoxConstraints(maxHeight: 420),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Column(
                children: [
                  TextField(
                    autofocus: true,
                    onChanged: (value) => setState(() => searchQuery = value),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search,
                          color: Colors.white60, size: 20),
                      hintText: "Search VIP name...",
                      hintStyle:
                          const TextStyle(color: Colors.white54, fontSize: 14),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.08),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: StreamBuilder<GetAllVipModelData>(
                      stream: getAllVipRx.dataFetcher,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              "Failed to load data",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data?.data == null ||
                            snapshot.data!.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              "No VIP data available",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else {
                          final List<Data> categories = snapshot.data!.data!;

                          return SingleChildScrollView(
                            child: Column(
                              children: categories.map((categoryData) {
                                // Filter relations based on search query
                                final filteredRelations = categoryData
                                    .relations!
                                    .where((relation) => relation.name!
                                        .toLowerCase()
                                        .contains(searchQuery.toLowerCase()))
                                    .toList();

                                // Don't show category if no relations match the search
                                if (filteredRelations.isEmpty)
                                  return const SizedBox();

                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    dividerColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                  ),
                                  child: ExpansionTile(
                                    initiallyExpanded: true,
                                    collapsedIconColor: Colors.white,
                                    iconColor: Colors.white,
                                    title: Row(
                                      children: [
                                        Icon(
                                          _getCategoryIcon(
                                              categoryData.category?.name ??
                                                  ""),
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          categoryData.category?.name ??
                                              "Unknown Category",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    children: filteredRelations
                                        .map<Widget>((relation) {
                                      return ListTile(
                                        leading: shimmerClipOvalWidget(
                                          height: 35,
                                          weight: 35,
                                          networkImageLink: personImageUrl,
                                        ),
                                        title: Text(
                                          relation.name ?? "Unknown Name",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        subtitle: Text(
                                          relation.name ?? "",
                                          style: const TextStyle(
                                              color: Colors.white54,
                                              fontSize: 12),
                                        ),
                                        onTap: () {
                                          // Pass both ID and name back to parent
                                          widget.onVipSelected?.call(
                                            relation.id.toString(),
                                            relation.name ?? "Unknown",
                                          );
                                          widget.onClose();
                                        },
                                      );
                                    }).toList(),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName) {
      case "Family":
        return Icons.home;
      case "Personal / Close":
        return Icons.favorite;
      case "Relatives":
        return Icons.group;
      case "Professional":
        return Icons.work;
      case "Others":
        return Icons.star;
      default:
        return Icons.category;
    }
  }
}

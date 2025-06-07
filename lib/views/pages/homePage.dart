import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphview/GraphView.dart';
import 'package:my_family_mobile_app/controllers/homeController.dart';
import 'package:my_family_mobile_app/views/components/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<Homecontroller>();

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Text('family_tree.title'.tr),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => homeController.onRefresh(),
            tooltip: 'Actualiser l\'arbre',
          ),
          IconButton(
            icon: const Icon(Icons.center_focus_strong),
            onPressed: () => homeController.centerOnUserNode(),
            tooltip: 'Recentrer la vue',
          ),
        ],
      ),
      body: Column(
        children: [
          // En-tête informatif
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.1),
                  Theme.of(context).primaryColor.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.account_tree,
                  color: Theme.of(context).primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'family_tree.title'.tr,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                GetBuilder<Homecontroller>(
                  builder: (controller) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                         '',                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Zone principale de l'arbre
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => homeController.onRefresh(),
              child: GetBuilder<Homecontroller>(
                builder: (controller) {
                  if (controller.relations.isEmpty) {
                    return _buildEmptyState();
                  }

                  if (controller.graph.nodes.isEmpty) {
                    return _buildLoadingState(controller.relations.length);
                  }

                  // Arbre généalogique principal
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.grey.withOpacity(0.05),
                    child: InteractiveViewer(
                      constrained: false,
                      boundaryMargin: const EdgeInsets.all(300),
                      minScale: 0.1,
                      maxScale: 2.5,
                      transformationController: controller.transformationController,
                      child: GraphView(
                        graph: controller.graph,
                        algorithm: controller.algorithm,
                        paint: Paint()
                          ..color = Colors.grey
                          ..strokeWidth = 1
                          ..style = PaintingStyle.stroke,
                        builder: (node) {
                          // Le `data` est le widget que nous avons assigné dans le contrôleur
                          var widget = node.data as Widget?;
                          return widget ?? Container();
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Contrôles et légende améliorés
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Contrôles de navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlButton(
                      icon: Icons.zoom_in,
                      label: 'Zoom +',
                      onPressed: () => _zoomIn(homeController),
                    ),
                    _buildControlButton(
                      icon: Icons.zoom_out,
                      label: 'Zoom -',
                      onPressed: () => _zoomOut(homeController),
                    ),
                    _buildControlButton(
                      icon: Icons.center_focus_strong,
                      label: 'Centrer',
                      // MODIFICATION: Appeler la nouvelle fonction de centrage
                      onPressed: () => homeController.centerOnUserNode(),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                const Divider(height: 1),
                const SizedBox(height: 16),
                
                // Légende
                const Text(
                  'Légende',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                // MODIFICATION: Mise à jour de la légende
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _LegendItem(
                      color: Colors.blue.shade700,
                      label: 'Union',
                      isRectangle: true,
                    ),
                     _LegendItem(
                      color: Colors.grey.shade400,
                      label: 'Lien familial',
                      isLine: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.family_restroom,
            size: 80,
            color: Colors.grey.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          Text(
            'family_tree.no_data'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'family_tree.add_member'.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(int relationsCount) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(strokeWidth: 3),
          const SizedBox(height: 24),
          Text(
            'family_tree.loading'.tr,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'family_tree.found_relations'.trParams({'count': relationsCount.toString()}),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: Colors.grey.shade700),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _zoomIn(Homecontroller controller) {
    final currentScale = controller.transformationController.value.getMaxScaleOnAxis();
    final newScale = (currentScale * 1.2).clamp(0.1, 2.5);
    final transformation = Matrix4.identity()..scale(newScale, newScale);
    controller.transformationController.value = transformation;
  }

  void _zoomOut(Homecontroller controller) {
    final currentScale = controller.transformationController.value.getMaxScaleOnAxis();
    final newScale = (currentScale * 0.8).clamp(0.1, 2.5);
    final transformation = Matrix4.identity()..scale(newScale, newScale);
    controller.transformationController.value = transformation;
  }
}

// MODIFICATION: Ajout de 'isRectangle' pour la légende
class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final bool isCircle;
  final bool isLine;
  final bool isRectangle;

  const _LegendItem({
    required this.color,
    required this.label,
    this.isCircle = false,
    this.isLine = false,
    this.isRectangle = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget shapeWidget;
    if (isCircle) {
      shapeWidget = Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
    } else if (isLine) {
      shapeWidget = Container(
        width: 20,
        height: 2,
        color: color,
      );
    } else if (isRectangle) {
      shapeWidget = Container(
        width: 20,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2)
        ),
      );
    } else {
      shapeWidget = const SizedBox.shrink();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        shapeWidget,
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

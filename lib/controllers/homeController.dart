import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';
import 'package:my_family_mobile_app/domain/models/account.dart';
import 'package:my_family_mobile_app/domain/models/mock.dart';
import 'package:my_family_mobile_app/domain/models/node.dart';
import 'package:my_family_mobile_app/domain/models/node_relation.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';
import 'package:my_family_mobile_app/services/nodeService.dart';
import 'package:my_family_mobile_app/services/utils/AuthManager.dart';
import 'package:my_family_mobile_app/utils/storageConstant.dart';
import 'package:graphview/GraphView.dart' as gv;
import 'package:my_family_mobile_app/views/components/family_tree/family_node_widget.dart';

class Homecontroller extends GetxController {
  var hasConnection = true.obs;
  var previousConnection = false.obs;
  var currentBackPressTime = Rxn<DateTime>();
  var selectedNavIndex = 0.obs;
  var isOnline = true.obs;
  bool isChanged = false;
  final connectivity = Connectivity();
  late Timer _connectivityTimer;

  var account = Account(
    username: '',
    email: '',
    baseNode: BaseNode(
      id: 0,
      title: '',
      firstName: '',
      lastName: '',
      birthDate: DateTime.now(),
      gender: '',
      address: '',
      phone: '',
      interests: [],
      userId: 0,
      baseNode: false,
    ),
  ).obs;

  final gv.Graph graph = gv.Graph();
  late gv.SugiyamaAlgorithm algorithm;
  // final relations = [].obs;
  final relations = familyTreeRelations.obs;
  final Map<int, gv.Node> nodeMap = {};
  final transformationController = TransformationController();

  @override
  void onInit() {
    super.onInit();
    _initConnectivityChecks();
    _checkInitialConnectivity();
    _initializeAccount();
    ever(account, (_) => buildFamilyGraph());
  }

  Future<void> _initializeAccount() async {
    final storage = GetStorage();
    final accountData = storage.read('account');
    // final relationTemp = await NodeService.getFamilyRelations();
    // relations.value = relationTemp;
    if (accountData != null) {
      account.value = Account.fromJson(accountData);
      buildFamilyGraph();
    } else {
      logoutUser('');
    }
  }

  void buildFamilyGraph() {
    graph.nodes.clear();
    graph.edges.clear();
    nodeMap.clear();

    _setupAlgorithm();

    if (relations.isEmpty) {
        update();
        return;
    }

    final allPeople = <int, BaseNode>{};
    final spouseMap = <int, int>{};
    final parentToChildrenMap = <int, List<int>>{};

    for (var relation in relations) {
      allPeople.putIfAbsent(relation.node1.id, () => relation.node1);
      allPeople.putIfAbsent(relation.node2.id, () => relation.node2);

      switch (relation.relationType) {
        case RelationType.SPOUSE:
          spouseMap[relation.node1.id] = relation.node2.id;
          spouseMap[relation.node2.id] = relation.node1.id;
          break;
        case RelationType.PARENT:
          parentToChildrenMap
              .putIfAbsent(relation.node1.id, () => [])
              .add(relation.node2.id);
          break;
        case RelationType.CHILD:
          parentToChildrenMap
              .putIfAbsent(relation.node2.id, () => [])
              .add(relation.node1.id);
          break;
        case RelationType.SIBLING:
          break;
      }
    }

    allPeople.forEach((id, personData) {
      final nodeWidget = FamilyNodeWidget(
        node: personData,
        relation: personData.title ?? 'N/A',
      );
      final node = gv.Node.Id(id) ..data = nodeWidget;
      nodeMap[id] = node;
      graph.addNode(node);
    });

    int unionIdCounter = -1; 
    final processedPeople = <int>{};

    for (final personId in allPeople.keys) {
      if (processedPeople.contains(personId)) {
        continue;
      }

      final spouseId = spouseMap[personId];
      final childrenIds = parentToChildrenMap[personId] ?? [];

      if (spouseId != null) {
        final parent1Node = nodeMap[personId]!;
        final parent2Node = nodeMap[spouseId]!;

        processedPeople.add(personId);
        processedPeople.add(spouseId);

        final unionNode = gv.Node.Id(unionIdCounter--);
        // MODIFICATION: Apparence du nœud d'union (rectangle bleu)
        unionNode.data = Container(
          width: 50,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            borderRadius: BorderRadius.circular(8),
             boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 4,
                offset: const Offset(0, 2),
              )
            ]
          ),
        );
        graph.addNode(unionNode);

        // NOTE: En connectant les deux parents à ce nœud d'union, l'algorithme
        // les placera au même niveau (profondeur) juste au-dessus.
        graph.addEdge(parent1Node, unionNode, paint: Paint()..color = Colors.grey.shade400..strokeWidth = 2);
        graph.addEdge(parent2Node, unionNode, paint: Paint()..color = Colors.grey.shade400..strokeWidth = 2);

        final spouseChildrenIds = parentToChildrenMap[spouseId] ?? [];
        final allChildrenForCouple = (childrenIds.toSet()..addAll(spouseChildrenIds)).toList();

        if (allChildrenForCouple.isNotEmpty) {
          for (final childId in allChildrenForCouple) {
            final childNode = nodeMap[childId]!;
            graph.addEdge(unionNode, childNode, paint: Paint()..color = Colors.grey.shade400..strokeWidth = 2);
          }
        }
      } 
      else if (childrenIds.isNotEmpty) {
        processedPeople.add(personId);
        final parentNode = nodeMap[personId]!;
        for (final childId in childrenIds) {
          final childNode = nodeMap[childId]!;
          graph.addEdge(parentNode, childNode, paint: Paint()..color = Colors.grey.shade400..strokeWidth = 2);
        }
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshFamilyTree();
    });

    update();
  }

  /// ===================================================================
  /// === NOUVELLE MÉTHODE DE CENTRAGE SUR L'UTILISATEUR ===
  /// ===================================================================
  void centerOnUserNode() {
    return;
    final userNodeId = account.value.baseNode.id;

    if (!nodeMap.containsKey(userNodeId)) {
      print("Erreur : Nœud utilisateur avec ID $userNodeId non trouvé.");
      transformationController.value = Matrix4.identity();
      return;
    }

    final targetNode = nodeMap[userNodeId]!;
    
    // Les propriétés x, y, width, et height sont calculées par l'algorithme.
    final nodeX = targetNode.x;
    final nodeY = targetNode.y;
    final nodeWidth = targetNode.width;
    final nodeHeight = targetNode.height;

    final viewWidth = Get.width;
    final viewHeight = Get.height;

    // Calcul pour centrer le nœud dans la vue
    final targetCenterX = nodeX + (nodeWidth / 2);
    final targetCenterY = nodeY + (nodeHeight / 2);

    final xTranslate = -targetCenterX + (viewWidth / 2);
    final yTranslate = -targetCenterY + (viewHeight / 3); // Positionne un peu plus haut

    final matrix = Matrix4.identity()
      ..translate(xTranslate, yTranslate)
      ..scale(1.2); // Zoom léger pour la visibilité

    transformationController.value = matrix;
  }

  void _setupAlgorithm() {
    final configuration = gv.SugiyamaConfiguration()
      ..nodeSeparation = 30
      ..levelSeparation = 50
      ..orientation = gv.SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM;
    
    algorithm = gv.SugiyamaAlgorithm(configuration);
  }

  void refreshFamilyTree() {
    buildFamilyGraph();
    Future.delayed(const Duration(milliseconds: 200), () {
        centerOnUserNode();
    });
  }

  // --- Le reste des méthodes reste inchangé ---

  void _initConnectivityChecks() {
    _connectivityTimer = Timer.periodic(
        const Duration(seconds: 30), (_) => _checkConnectivityAndPing());
  }

  Future<void> _checkConnectivityAndPing() async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      final hasNetworkConnection = connectivityResult != ConnectivityResult.none;
      // hasConnection.value = hasNetworkConnection;
      // isOnline.value = hasNetworkConnection ? await _pingGoogle() : false;
    } catch (_) {
      // isOnline.value = false;
    }
  }

  Future<bool> _pingGoogle() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void _handleConnectivityChange(ConnectivityResult result) {
    // previousConnection(hasConnection.value);
    // _checkConnectivityAndPing();
    // if (!previousConnection.value && hasConnection.value) {
    //   selectedNavIndex.value = 0;
    //   _refreshHomePage();
    // }
  }

  Future<void> _checkInitialConnectivity() async {
    await _checkConnectivityAndPing();
  }

  void logoutUser(String logoutMessage) {
    final isLoggedIn = GetStorage().read(StorageConstants.loggedIn) ?? false;
    if (isLoggedIn) {
      final formattedDate =
          DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
      GetStorage().write(StorageConstants.lastLoginTime, formattedDate);
      GetStorage().remove(StorageConstants.loggedIn);
      Get.find<AuthManager>().logout();
      if(logoutMessage.isNotEmpty) {
        ToastController(
              title: 'Info', message: logoutMessage, type: ToastType.info)
          .showToast();
      }
      Get.offAllNamed(AppRoutes.login);
    }
  }

  Future<void> _refreshHomePage() async {
    final isLoggedIn = GetStorage().read(StorageConstants.loggedIn) ?? false;
    if (!isLoggedIn) logoutUser('logout_session_expired'.tr);
  }

  Future<void> onRefresh() async {
    await resetState();
    await _checkInitialConnectivity();

    _initConnectivityChecks();
    _initializeAccount();
    ever(account, (_) => buildFamilyGraph());
    
  update();
  }

  @override
  Future<void> resetState() async {
    selectedNavIndex.value = 0;
    isChanged = false;
    // hasConnection.value = true;
    previousConnection.value = false;
    currentBackPressTime.value = null;
    // isOnline.value = true;
  }

  @override
  void onClose() {
    _connectivityTimer.cancel();
    transformationController.dispose();
    super.onClose();
  }
}

import 'package:my_family_mobile_app/domain/models/node.dart';
import 'package:my_family_mobile_app/domain/models/node_relation.dart';

final node1 = BaseNode(
  id: 1,
  title: "Mr.",
  firstName: "John",
  lastName: "Smith",
  birthDate: DateTime(1940, 1, 1),
  gender: "Male",
  address: "123 Main St",
  phone: "555-1234",
  interests: ["reading", "sports"],
  userId: 1,
  baseNode: true,
);

final node2 = BaseNode(
  id: 2,
  title: "Ms.",
  firstName: "Mary",
  lastName: "Smith",
  birthDate: DateTime(1942, 1, 1),
  gender: "Female",
  address: "123 Main St",
  phone: "555-1234",
  interests: ["reading", "sports"],
  userId: 1,
  baseNode: true,
);

final node3 = BaseNode(
  id: 3,
  title: "Mr.",
  firstName: "David",
  lastName: "Smith",
  birthDate: DateTime(1965, 1, 1),
  gender: "Male",
  address: "123 Main St",
  phone: "555-1234",
  interests: ["reading", "sports"],
  userId: 1,
  baseNode: true,
);

final node4 = BaseNode(
  id: 4,
  title: "Ms.",
  firstName: "Susan",
  lastName: "Smith",
  birthDate: DateTime(1967, 1, 1),
  gender: "Female",
  address: "123 Main St",
  phone: "555-1234",
  interests: ["reading", "sports"],
  userId: 1,
  baseNode: true,
);

final node5 = BaseNode(
  id: 5,
  title: "Mr.",
  firstName: "Michael",
  lastName: "Smith",
  birthDate: DateTime(1990, 1, 1),
  gender: "Male",
  address: "123 Main St",
  phone: "555-1234",
  interests: ["reading", "sports"],
  userId: 1,
  baseNode: true,
);

final node6 = BaseNode(
  id: 6,
  title: "Ms.",
  firstName: "Emily",
  lastName: "Smith",
  birthDate: DateTime(1992, 1, 1),
  gender: "Female",
  address: "123 Main St",
  phone: "555-1234",
  interests: ["reading", "sports"],
  userId: 1,
  baseNode: true,
);

final node7 = BaseNode(
  id: 7,
  title: "Mr.",
  firstName: "James",
  lastName: "Smith",
  birthDate: DateTime(1995, 1, 1),
  gender: "Male",
  address: "123 Main St",
  phone: "555-1234",
  interests: ["reading", "sports"],
  userId: 1,
  baseNode: true,
);

final node8 = BaseNode(
  id: 8,
  title: "Ms.",
  firstName: "Laura",
  lastName: "Smith",
  birthDate: DateTime(1991, 1, 1),
  gender: "Female",
  address: "123 Main St",
  phone: "555-1234",
  interests: ["reading", "sports"],
  userId: 1,
  baseNode: true,
);

final node9 = BaseNode(
  id: 9,
  title: "Mr.",
  firstName: "Ethan",
  lastName: "Smith",
  birthDate: DateTime(2015, 1, 1),
  gender: "Male",
  address: "123 Main St",
  phone: "555-1234",
  interests: ["reading", "sports"],
  userId: 1,
  baseNode: true,
);

final node10 = BaseNode(
  id: 10,
  title: "Ms.",
  firstName: "Olivia",
  lastName: "Smith",
  birthDate: DateTime(2017, 1, 1),
  gender: "Female",
  address: "123 Main St",
  phone: "555-1234",
  interests: ["reading", "sports"],
  userId: 1,
  baseNode: true,
);

final node11 = BaseNode(
  id: 11,
  title: "Mr.",
  firstName: "Robert",
  lastName: "Smith",
  birthDate: DateTime(1965, 1, 1),
  gender: "Male",
  address: "123 Main St",
  phone: "555-1234",
  interests: ["reading", "sports"],
  userId: 1,
  baseNode: true,
);

final node12 = BaseNode(
  id: 12,
  title: "Ms.",
  firstName: "Karen",
  lastName: "Smith",
  birthDate: DateTime(1968, 1, 1),
  gender: "Female",
  address: "123 Main St",
  phone: "555-1234",
  interests: ["reading", "sports"],
  userId: 1,
  baseNode: true,
);

final node13 = BaseNode(
  id: 13,
  title: "Mr.",
  firstName: "Daniel",
  lastName: "Smith",
  birthDate: DateTime(1993, 1, 1),
  gender: "Male",
  address: "123 Main St",
  phone: "555-1234",
  interests: ["reading", "sports"],
  userId: 1,
  baseNode: true,
);

final node14 = BaseNode(
  id: 14,
  title: "Ms.",
  firstName: "Sophia",
  lastName: "Smith",
  birthDate: DateTime(1996, 1, 1),
  gender: "Female",
  address: "123 Main St",
  phone: "555-1234",
  interests: ["reading", "sports"],
  userId: 1,
  baseNode: true,
);

List<NodeRelation> familyTreeRelations = [
  // 1. John et Mary sont mariés (grands-parents)
  NodeRelation(
    node1: node1, // John
    node2: node2, // Mary
    relationType: RelationType.SPOUSE,
  ),
  // 2. David est enfant de John
  NodeRelation(
    node1: node3, // David
    node2: node1, // John
    relationType: RelationType.CHILD,
  ),
  // 3. David est enfant de Mary
  NodeRelation(
    node1: node3, // David
    node2: node2, // Mary
    relationType: RelationType.CHILD,
  ),
  // 4. David et Susan sont mariés
  NodeRelation(
    node1: node3, // David
    node2: node4, // Susan
    relationType: RelationType.SPOUSE,
  ),
  // 5. Michael est enfant de David
  NodeRelation(
    node1: node5, // Michael
    node2: node3, // David
    relationType: RelationType.CHILD,
  ),
  // 6. Michael est enfant de Susan
  NodeRelation(
    node1: node5, // Michael
    node2: node4, // Susan
    relationType: RelationType.CHILD,
  ),
  // 7. Emily est enfant de David
  NodeRelation(
    node1: node6, // Emily
    node2: node3, // David
    relationType: RelationType.CHILD,
  ),
  // 8. Emily est enfant de Susan
  NodeRelation(
    node1: node6, // Emily
    node2: node4, // Susan
    relationType: RelationType.CHILD,
  ),
  // 9. James est enfant de David
  NodeRelation(
    node1: node7, // James
    node2: node3, // David
    relationType: RelationType.CHILD,
  ),
  // 10. James est enfant de Susan
  NodeRelation(
    node1: node7, // James
    node2: node4, // Susan
    relationType: RelationType.CHILD,
  ),
  // 11. Michael et Laura sont mariés
  NodeRelation(
    node1: node5, // Michael
    node2: node8, // Laura
    relationType: RelationType.SPOUSE,
  ),
  // 12. Ethan est enfant de Michael
  NodeRelation(
    node1: node9, // Ethan
    node2: node5, // Michael
    relationType: RelationType.CHILD,
  ),
  // 13. Ethan est enfant de Laura
  NodeRelation(
    node1: node9, // Ethan
    node2: node8, // Laura
    relationType: RelationType.CHILD,
  ),
  // 14. Olivia est enfant de Michael
  NodeRelation(
    node1: node10, // Olivia
    node2: node5, // Michael
    relationType: RelationType.CHILD,
  ),
  // 15. Robert est frère de David
  NodeRelation(
    node1: node11, // Robert
    node2: node3, // David
    relationType: RelationType.SIBLING,
  ),
  // 16. Robert et Karen sont mariés
  NodeRelation(
    node1: node11, // Robert
    node2: node12, // Karen
    relationType: RelationType.SPOUSE,
  ),
  // 17. Daniel est enfant de Robert
  NodeRelation(
    node1: node13, // Daniel
    node2: node11, // Robert
    relationType: RelationType.CHILD,
  ),
  // 18. Daniel est enfant de Karen
  NodeRelation(
    node1: node13, // Daniel
    node2: node12, // Karen
    relationType: RelationType.CHILD,
  ),
  // 19. Sophia est enfant de Robert
  NodeRelation(
    node1: node14, // Sophia
    node2: node11, // Robert
    relationType: RelationType.CHILD,
  ),
  // 20. Sophia est enfant de Karen
  NodeRelation(
    node1: node14, // Sophia
    node2: node12, // Karen
    relationType: RelationType.CHILD,
  ),
];
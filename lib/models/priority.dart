/// Here is [Priority] class model

class Priority {
  int? id;
  String? name;

  Priority.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

/// These data are Mock and you can change them or use
/// the model according your priority name in the server
var priorityMock = [
  {
    "id": 1,
    "name": "Critical",
  },
  {
    "id": 2,
    "name": "Very much",
  },
  {
    "id": 3,
    "name": "Much",
  },
  {
    "id": 4,
    "name": "Medium",
  },
  {
    "id": 5,
    "name": "Little",
  },
  {
    "id": 6,
    "name": "Very little",
  }
];

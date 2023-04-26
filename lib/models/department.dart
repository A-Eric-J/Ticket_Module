/// Here is [Department] class model
class Department {
  int? id;
  String? title;

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }
}

/// These data are Mock and you can change them or use
/// the model according your departments name in the server
var departmentMock = [
  {'id': 1, 'title': 'Technical Department'},
  {'id': 2, 'title': 'Sales Department'},
  {'id': 3, 'title': 'Goods delivery Department'},
];

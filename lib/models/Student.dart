class Student {
  int id;
  String name;
  String surname;
  int grade;
  String status;

  Student.withoutInfo() {
    // empty student
  }

  Student.withId({int id, String name, String surname, int grade}) {
    this.id = id;
    this.name = name;
    this.surname = surname;
    this.grade = grade;
  }

  Student({String name, String surname, int grade}) {
    this.name = name;
    this.surname = surname;
    this.grade = grade;
  }

  String get getStudentName {
    return this.name + " " + this.surname;
  }

  String get getStatus {
    if (this.grade <= 45) {
      return "Kaldıniz";
    } else {
      return "Geçtiniz";
    }
  }
}

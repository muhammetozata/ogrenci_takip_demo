import 'package:flutter/material.dart';
import 'package:ogrenci_takip_demo/screens/StudentAdd.dart';
import 'package:ogrenci_takip_demo/screens/StudentEdit.dart';

import 'models/Student.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'ÖĞRENCİ TAKİP SİSTEMİ DEMO',
    theme: ThemeData.dark(),
    home: OgrenciTakipDemo(),
  ));
}

class OgrenciTakipDemo extends StatefulWidget {
  @override
  _OgrenciTakipDemoState createState() => _OgrenciTakipDemoState();
}

class _OgrenciTakipDemoState extends State<OgrenciTakipDemo> {
  List<Student> students;

  Student selectedStudent = Student(name: "", surname: "", grade: 0);

  void initState() {
    super.initState();
    students = [
      new Student(name: "Muhammet", surname: "Test", grade: 95),
      new Student(name: "Ahmet", surname: "Test", grade: 45),
      new Student(name: "Deniz", surname: "Deneme", grade: 50),
      new Student(name: "Adem", surname: "Deneme", grade: 30),
      new Student(name: "Ali", surname: "Test", grade: 95),
    ];
  }

  void _addStudent(Student student) {
    setState(() {
      this.students.add(student);
    });
  }

  void _removeStudent(Student student) {
    this.students.remove(student);
  }

  void _updateStudent(Student student) {
    setState(() {
      selectedStudent.name = student.name;
      selectedStudent.surname = student.surname;
      selectedStudent.grade = student.grade;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Takip Sistemi"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: students.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 60,
                  color: Colors.blue[300],
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://miro.medium.com/max/600/1*PiHoomzwh9Plr9_GA26JcA.png"),
                    ),
                    title: Text(students[index].getStudentName),
                    subtitle: Text("Durum :" + students[index].getStatus),
                    trailing: studentStatusIcon(students[index].getStatus),
                    onTap: () {
                      setState(() {
                        selectedStudent = students[index];
                      });
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
          Text("Seçili Öğrenci:" + this.selectedStudent.getStudentName),
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: buildActionButton(
                  name: "Öğrenci Ekle",
                  icon: Icon(Icons.add),
                  color: Colors.green[300],
                  onpress: addStudentButton,
                ),
                flex: 1,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: buildActionButton(
                  name: "Güncelle",
                  icon: Icon(Icons.edit),
                  color: Colors.amber[500],
                  onpress: updateStudentButton,
                ),
                flex: 1,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: buildActionButton(
                  name: "Siil",
                  icon: Icon(Icons.delete),
                  color: Colors.deepOrange[300],
                  onpress: removeStudentButton,
                ),
                flex: 1,
              ),
            ],
          )
        ],
      ),
    );
  }

  void addStudentButton() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StudentAdd(
                  students: students,
                  addStudent: _addStudent,
                )));
  }

  void updateStudentButton() {
    var materialPageRoute = MaterialPageRoute(
        builder: (context) => StudentEdit(
              selectedStudent: selectedStudent,
              updateStudent: _updateStudent,
            ));
    Navigator.push(context, materialPageRoute);
  }

  void removeStudentButton() {
    setState(() {
      _removeStudent(selectedStudent);
    });

    showAlertMessage(
        context, "İşlem Sonucu", "Silindi:" + selectedStudent.getStudentName);
  }

  Widget buildActionButton(
      {String name, Icon icon, Color color, VoidCallback onpress}) {
    return RaisedButton(
      padding: EdgeInsets.all(10),
      color: color,
      child: Row(
        children: [
          icon,
          SizedBox(width: 1),
          Text(name),
        ],
      ),
      onPressed: onpress,
    );
  }

  Widget studentStatusIcon(String status) {
    if (status == "Geçtiniz") {
      return Icon(
        Icons.done,
        color: Colors.greenAccent,
      );
    } else {
      return Icon(
        Icons.cancel,
        color: Colors.redAccent,
      );
    }
  }

  void showAlertMessage(BuildContext context, String title, String message) {
    var alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}

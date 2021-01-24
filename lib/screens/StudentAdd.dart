import 'package:flutter/material.dart';
import 'package:ogrenci_takip_demo/models/Student.dart';
import 'package:ogrenci_takip_demo/validations/FormValidation.dart';

// ignore: must_be_immutable
class StudentAdd extends StatefulWidget {
  final List<Student> students;
  final ValueChanged<Student> addStudent;

  StudentAdd({Key key, this.students, this.addStudent}) : super(key: key);

  @override
  _StudentAddState createState() => _StudentAddState();
}

class _StudentAddState extends State<StudentAdd> with FormValidation {
  var _formKey = GlobalKey<FormState>();
  var student = Student.withoutInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Ekle"),
      ),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildNameTextField(),
              buildSurnameTextField(),
              buildGradeTextField(),
              buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Muhammet",
      ),
      onSaved: (String value) {
        student.name = value;
      },
      validator: (String value) {
        return textFieldIsEmpty("Name", value);
      },
    );
  }

  Widget buildSurnameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Surname",
        hintText: "ÖZATA",
      ),
      onSaved: (String value) {
        student.surname = value;
      },
      validator: (String value) {
        return textFieldIsEmpty("Surname", value);
      },
    );
  }

  Widget buildGradeTextField() {
    return TextFormField(
        decoration: InputDecoration(
          labelText: "Grade",
          hintText: "99",
        ),
        onSaved: (String value) {
          student.grade = int.parse(value);
        },
        validator: (String value) {
          return textFieldIsInt("Grade", value);
        });
  }

  Widget buildSaveButton() {
    return RaisedButton(
      child: Text("Save"),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();

          widget.addStudent(student);
          Navigator.pop(context);
        }
      },
    );
  }

  void saveStudent() {
    print(student.name);
    print(student.surname);
    print(student.grade);
  }
}

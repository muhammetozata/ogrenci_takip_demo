import 'package:flutter/material.dart';
import 'package:ogrenci_takip_demo/models/Student.dart';
import 'package:ogrenci_takip_demo/validations/FormValidation.dart';

// ignore: must_be_immutable
class StudentEdit extends StatefulWidget {
  final Student selectedStudent;
  final ValueChanged<Student> updateStudent;
  StudentEdit({Key key, this.selectedStudent, this.updateStudent})
      : super(key: key);

  @override
  _StudentEditState createState() => _StudentEditState();
}

class _StudentEditState extends State<StudentEdit> with FormValidation {
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Güncelle"),
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
      initialValue: widget.selectedStudent.name,
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Muhammet",
      ),
      onSaved: (String value) {
        widget.selectedStudent.name = value;
      },
      validator: (String value) {
        return textFieldIsEmpty("Name", value);
      },
    );
  }

  Widget buildSurnameTextField() {
    return TextFormField(
      initialValue: widget.selectedStudent.surname,
      decoration: InputDecoration(
        labelText: "Surname",
        hintText: "ÖZATA",
      ),
      onSaved: (String value) {
        widget.selectedStudent.surname = value;
      },
      validator: (String value) {
        return textFieldIsEmpty("Surname", value);
      },
    );
  }

  Widget buildGradeTextField() {
    return TextFormField(
        initialValue: widget.selectedStudent.grade.toString(),
        decoration: InputDecoration(
          labelText: "Grade",
          hintText: "99",
        ),
        onSaved: (String value) {
          widget.selectedStudent.grade = int.parse(value);
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
          widget.updateStudent(widget.selectedStudent);
          Navigator.pop(context);
        }
      },
    );
  }

  void saveStudent() {
    print(widget.selectedStudent.name);
    print(widget.selectedStudent.surname);
    print(widget.selectedStudent.grade);
  }
}

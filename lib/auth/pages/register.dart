import 'package:flutter/material.dart';
import '../widgets/custom_forgotpassword.dart';
import '../widgets/custom_question.dart';
import '../widgets/custom_subtitlepage.dart';
import '../widgets/custom_titlepage.dart';
import '../widgets/custom_buttonauth.dart';
import '../widgets/custom_textform.dart';
import '../widgets/custom_title.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _Registertate();
}

class _Registertate extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const CustomTitlePage(title: "Register"),
              const SizedBox(height: 10),
              const CustomSubtitlePage(
                  subtitle: "Register To Continue Using The App"),
              const SizedBox(height: 20),
              const CustomTitle(text: "Username"),
              const SizedBox(height: 10),
              CustomTextForm(
                  hinttext: "ُEnter Your username", mycontroller: username),
              const SizedBox(height: 20),
              const CustomTitle(text: "Email"),
              const SizedBox(height: 10),
              CustomTextForm(
                  hinttext: "ُEnter Your Email", mycontroller: email),
              const SizedBox(height: 10),
              const CustomTitle(text: "Password"),
              const SizedBox(height: 10),
              CustomTextForm(
                  hinttext: "ُEnter Your Password", mycontroller: email),
              CustomForgotPassword(onTap: () {}),
            ],
          ),
          CustomButtonAuth(title: "SignUp", onPressed: () {}),
          const SizedBox(height: 20),
          CustomQuestion(
              question: "Have An Account ? ",
              answer: "Login",
              onTap: () {
                Navigator.of(context).pushNamed("login");
              }),
        ]),
      ),
    );
  }
}

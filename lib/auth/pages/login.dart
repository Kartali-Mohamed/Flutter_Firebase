import 'package:flutter/material.dart';
import '../widgets/custom_buttonauth.dart';
import '../widgets/custom_buttongoogle.dart';
import '../widgets/custom_forgotpassword.dart';
import '../widgets/custom_question.dart';
import '../widgets/custom_subtitlepage.dart';
import '../widgets/custom_textform.dart';
import '../widgets/custom_title.dart';
import '../widgets/custom_titlepage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              const CustomTitlePage(title: "Login"),
              const SizedBox(height: 10),
              const CustomSubtitlePage(
                  subtitle: "Login To Continue Using The App"),
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
          CustomButtonAuth(title: "login", onPressed: () {}),
          const SizedBox(height: 20),
          CustomButtonGoogle(onPressed: () {}),
          const SizedBox(height: 20),
          CustomQuestion(
              question: "Don't Have An Account ? ",
              answer: "Register",
              onTap: () {
                Navigator.of(context).pushNamed("register");
              }),
        ]),
      ),
    );
  }
}

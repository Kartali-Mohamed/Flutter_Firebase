import 'package:firebase_auth/firebase_auth.dart';
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
  /* ========= Business Logic ========= */
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formStateKey = GlobalKey<FormState>();

  void login(String email, String password) async {
    if (formStateKey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No user found for that email.")));
          // print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Wrong password provided for that user.")));
          // print('Wrong password provided for that user.');
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message!)));
        }
      }
    }
  }

  /* ========= Presentation ========= */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Form(
            key: formStateKey,
            child: Column(
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
                  hinttext: "ُEnter Your Email",
                  mycontroller: emailController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "please enter your email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const CustomTitle(text: "Password"),
                const SizedBox(height: 10),
                CustomTextForm(
                  hinttext: "ُEnter Your Password",
                  mycontroller: passwordController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "please enter your password";
                    }
                    return null;
                  },
                ),
                CustomForgotPassword(onTap: () {}),
              ],
            ),
          ),
          CustomButtonAuth(
              title: "login",
              onPressed: () {
                login(emailController.text, passwordController.text);
              }),
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  /* ========= Business Logic ========= */
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formStateKey;
  bool isLoading = false;
  bool isObscureText = true;

  @override
  void initState() {
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formStateKey = GlobalKey<FormState>();
    super.initState();
  }

  void signUp(String email, String password) async {
    if (formStateKey.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
        if (!mounted) return;
        Navigator.of(context)
            .pushNamedAndRemoveUntil("login", (route) => false);
      } on FirebaseAuthException catch (e) {
        isLoading = false;
        setState(() {});
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("The password provided is too weak.")));
          // print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("The account already exists for that email.")));
          // print('The account already exists for that email.');
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message!)));
        }
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /* ========= Presentation ========= */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.orange,
                ),
              )
            : ListView(children: [
                Form(
                  key: formStateKey,
                  child: Column(
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
                        hinttext: "ُEnter Your Username",
                        mycontroller: usernameController,
                        suffixIcon: Icon(
                          Icons.person_outlined,
                          color: Colors.orange,
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "please enter your username";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const CustomTitle(text: "Email"),
                      const SizedBox(height: 10),
                      CustomTextForm(
                        hinttext: "ُEnter Your Email",
                        mycontroller: emailController,
                        suffixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.orange,
                        ),
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
                        obscureText: isObscureText,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              isObscureText = !isObscureText;
                              setState(() {});
                            },
                            child: Icon(
                              isObscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.orange,
                            )),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "please enter your password";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                CustomButtonAuth(
                    title: "SignUp",
                    onPressed: () {
                      signUp(emailController.text, passwordController.text);
                    }),
                const SizedBox(height: 20),
                CustomQuestion(
                    question: "Have An Account ? ",
                    answer: "Login",
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("login");
                    }),
              ]),
      ),
    );
  }
}

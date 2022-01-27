import 'package:flutter/material.dart';
import 'package:flutter_firebase/block/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/screens/info_screen.dart';
import 'package:flutter_firebase/screens/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String id = "sign_up_screen";

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = "";
  String _username = "";
  String _password = "";

  late final FocusNode _passwordFocusNode;
  late final FocusNode _usernameFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    _usernameFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      //Invalid
      return;
    }
    _formKey.currentState!.save();
    context
        .read<AuthCubit>()
        .signUp(email: _email, username: _username, password: _password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (prevState, currentState) {
          if (currentState is AuthSignedUp) {
            Navigator.of(context).pushReplacementNamed(InfoScreen.id,
                arguments: {"email": _email, "password": _password});
          }
          if (currentState is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(seconds: 2),
                content: Text(currentState.message)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, -1),
                    child: Image.network(
                      'https://picsum.photos/seed/484/300',
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Container(
                            width: 0,
                            height: 0,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 20),
                                        child: Container(
                                          width: 300,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE0E0E0),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 20, 0),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: const InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft: Radius.circular(4.0),
                                                    topRight:
                                                        Radius.circular(4.0),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0x00000000),
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft: Radius.circular(4.0),
                                                    topRight:
                                                        Radius.circular(4.0),
                                                  ),
                                                ),
                                                hintText: "Enter your email",
                                                hintStyle: TextStyle(
                                                    color: Color(0xFF455A64),
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              style: TextStyle(
                                                color: Color(0xFF455A64),
                                                fontWeight: FontWeight.normal,
                                              ),
                                              textInputAction:
                                                  TextInputAction.next,
                                              onFieldSubmitted: (_) {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _usernameFocusNode);
                                              },
                                              onSaved: (value) {
                                                _email = value!.trim();
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter your email";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 4, 20),
                                        child: Container(
                                          width: 300,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE0E0E0),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 20, 0),
                                            child: TextFormField(
                                              focusNode: _usernameFocusNode,
                                              decoration: const InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(4.0),
                                                      topRight:
                                                          Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(4.0),
                                                      topRight:
                                                          Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  hintStyle: TextStyle(
                                                      color: Color(0xFF455A64),
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  hintText:
                                                      "Enter your username"),
                                              style: TextStyle(
                                                color: Color(0xFF455A64),
                                                fontWeight: FontWeight.normal,
                                              ),
                                              textInputAction:
                                                  TextInputAction.next,
                                              onFieldSubmitted: (_) {
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        _passwordFocusNode);
                                              },
                                              onSaved: (value) {
                                                _username = value!.trim();
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter your username";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 4, 20),
                                        child: Container(
                                          width: 300,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE0E0E0),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 0, 20, 0),
                                            child: TextFormField(
                                              focusNode: _passwordFocusNode,
                                              obscureText: true,
                                              textInputAction:
                                                  TextInputAction.done,
                                              decoration: const InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(4.0),
                                                      topRight:
                                                          Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(4.0),
                                                      topRight:
                                                          Radius.circular(4.0),
                                                    ),
                                                  ),
                                                  hintStyle: TextStyle(
                                                      color: Color(0xFF455A64),
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  hintText:
                                                      "Enter your password"),
                                              style: TextStyle(
                                                color: Color(0xFF455A64),
                                                fontWeight: FontWeight.normal,
                                              ),
                                              onFieldSubmitted: (_) {
                                                _submit(context);
                                              },
                                              onSaved: (value) {
                                                _password = value!.trim();
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter your password";
                                                }
                                                if (value.length < 5) {
                                                  return "Please enter longest password";
                                                }

                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 20),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _submit(context);
                                          },
                                          child: Text("Registration"),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  SignInScreen.id);
                                        },
                                        child: Text("Go to login"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

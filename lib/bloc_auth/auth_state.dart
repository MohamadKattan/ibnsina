import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AuthStates extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class  InitialState extends AuthStates{}

class Loading extends AuthStates{}

class SetData extends AuthStates{}

class GetData extends AuthStates{}

class ErrorState extends AuthStates{

  String msg;
  ErrorState({ this.msg});
}
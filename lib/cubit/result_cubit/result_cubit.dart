import 'dart:html';

import 'package:demo/cubit/result_cubit/result_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class resultCubit extends Cubit <resultStates>{
  resultCubit(super.initialState);

void getImage({required  File image}) async {

emit(resultLoadingState());
try {
   //code
  emit(resultSuccessState());
} on Exception catch(e) {
  emit(resultFailedState());
}
}

}
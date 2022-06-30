import 'package:imovie/data/response/status.dart';

class ApiResponst<T> {
  Status? status;
  T? data;
  String? message;

  ApiResponst(this.status, this.data, this.message);

  ApiResponst.loading() : status = Status.LOADING;

  ApiResponst.completed() : status = Status.COMPLETED;

  ApiResponst.error() : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status \n Message: $message \n Data: $data";
  }
}

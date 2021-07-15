import 'TypeDecodable.dart';

///A function that creates an object of type [T]

typedef Create<T> = T Function();

///Construct to get object from generic class

abstract class GenericObject<T> {

  Create<Decodable>? create;

  GenericObject({ this.create });

  T genericObject(Map<String, dynamic> data) {
    if (create == null) {
      return data as T;
    } else {
      final item = create!();
      return item.decode(data);
    }
  }

}

///Construct to wrap response from API.
///
///Used it as return object of APIController to handle any kind of response.

class ResponseWrapper<T> extends GenericObject<T> {
  late T response;
  ErrorResponse? error;

  ResponseWrapper({ Create<Decodable>? create, this.error })
      : super(create: create);

  factory ResponseWrapper.init({
    Create<Decodable>? create, int? statusCode,
    required Map<String, dynamic> json })
  {
    final wrapper = ResponseWrapper<T>(create: create);
    wrapper.response = wrapper.genericObject(json);
    return wrapper;
  }
}

class APIResponse<T> extends GenericObject<T>
    implements Decodable<APIResponse<T>> {
  String? message;
  String? status;
  T? data;

  APIResponse({ Create<Decodable>? create }) : super(create: create);


  factory APIResponse.init({
    Create<Decodable>? create, int? statusCode,
    required Map<String, dynamic> json })
  {
    final response = APIResponse<T>(create: create);
    response.data = response.genericObject(json);
    return response;
  }

  @override
  APIResponse<T> decode(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['results'] == null)  {
      data = null;
    } else {
      data = genericObject(json['results']);
    }
    return this;
  }
}

class APIListResponse<T> extends GenericObject<T>
    implements Decodable<APIListResponse<T>> {
  int? totalPages;
  int? totalResults;
  List<T>? data;

  APIListResponse({ required Create<Decodable> create }) : super(create: create);

  @override
  APIListResponse<T> decode(dynamic json) {
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
    data = [];
    json['results'].forEach((item) {
      data?.add(genericObject(item));
    });
    return this;
  }
}

class APIListTrailerResponse<T> extends GenericObject<T>
    implements Decodable<APIListTrailerResponse<T>> {
  int? id;
  List<T>? data;

  APIListTrailerResponse({ required Create<Decodable> create }) : super(create: create);

  @override
  APIListTrailerResponse<T> decode(dynamic json) {
    id = json['id'];
    data = [];
    json['results'].forEach((item) {
      data?.add(genericObject(item));
    });
    return this;
  }
}

class ErrorResponse implements Exception {
  int statusCode;
  String? message;

  ErrorResponse({ this.message, required this.statusCode });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(message: json['message'] ?? 'Something went wrong.', statusCode: json['status']);
  }

  @override
  String toString() {
    return message ?? "";
  }
}
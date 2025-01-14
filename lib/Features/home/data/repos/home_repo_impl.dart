import 'package:bookly/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/api_service.dart';
import '../models/book_model/book_model.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);

  @override
  Future<Either<Failuer, List<BookModel>>> fetchNewestBooks() async {
    try {
      final data = await apiService.getbooks(
          endPoint: 'volumes?Filtering=free-ebooks&q=subject:computer');
      List<BookModel> books = [];
      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailuer.fromDioException(e));
      }
      return left(
        ServerFailuer(e.toString()),
      );
    }
  }

  @override
  fetchFeaturedBooks() async {
    try {
      final data = await apiService.getbooks(
          endPoint: 'volumes?Filtering=free-ebooks&q=subject:programming');
      List<BookModel> books = [];
      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailuer.fromDioException(e));
      }
      return left(
        ServerFailuer(e.toString()),
      );
    }
  }

  @override
  Future<Either<Failuer, List<BookModel>>> fetchSimilerBooks(
      {required String category}) async {
    try {
      final data = await apiService.getbooks(
          endPoint:
              'volumes?Filtering=free-ebooks&q=subject:programming&Sorting=relevance');
      List<BookModel> books = [];
      for (var item in data['items']) {
        books.add(BookModel.fromJson(item));
      }
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailuer.fromDioException(e));
      }
      return left(
        ServerFailuer(e.toString()),
      );
    }
  }
}

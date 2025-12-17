import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/quote.dart';

part 'quote_api_client.g.dart';

@RestApi(baseUrl: "https://zenquotes.io/api")
abstract class QuoteApiClient {
  factory QuoteApiClient(Dio dio, {String baseUrl}) = _QuoteApiClient;

  @GET("/quotes")
  Future<List<Quote>> getQuotes();

  @GET("/random")
  Future<List<Quote>> getRandomQuote();
}

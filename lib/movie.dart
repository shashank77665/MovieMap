import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieDetails extends StatefulWidget {
  final String imdbID;
  const MovieDetails({super.key, required this.imdbID});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Map<String, dynamic>? movieDetails;
  bool isLoading = true;

  void getMovieDetails(String imdbID) async {
    try {
      print(imdbID);
      http.Response response;
      response = await http.get(
          Uri.parse('https://www.omdbapi.com/?i=${imdbID}&apikey=a6040b08'));
      if (response.statusCode == 200) {
        print('response body is');
        print(response.body);
        setState(() {
          movieDetails = jsonDecode(response.body);
          isLoading = false;
        });
        print(movieDetails);
      }
    } catch (e) {
      print('Failed');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMovieDetails(widget.imdbID);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Text(isLoading ? 'Loading' : movieDetails!['Title']),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Card(
                          elevation: 4,
                          child: Column(
                            children: [
                              Image.network(
                                movieDetails!['Poster'],
                                height: screenHeight * 0.3,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 8),
                              Text(
                                movieDetails!['Title'],
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 8),
                              Divider(),
                              // Movie details
                              _buildDetailRow('Year', movieDetails!['Year']),
                              _buildDetailRow(
                                  'Rating', movieDetails!['imdbRating']),
                              _buildDetailRow(
                                  'Released', movieDetails!['Released']),
                              _buildDetailRow(
                                  'Runtime', movieDetails!['Runtime']),
                              _buildDetailRow('Genre', movieDetails!['Genre']),
                              _buildDetailRow(
                                  'Director', movieDetails!['Director']),
                              _buildDetailRow(
                                  'Writer', movieDetails!['Writer']),
                              _buildDetailRow(
                                  'Actors', movieDetails!['Actors']),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                      // Plot section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              movieDetails!['Plot'] ?? 'No plot available',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

Widget _buildDetailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

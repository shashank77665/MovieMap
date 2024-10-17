import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sixteenoct/movie.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController movie = TextEditingController();
  bool firstLoad = true;
  var product = [];
  bool isLoading = false;

  void fetchProduct(String movie) async {
    setState(() {
      isLoading = true;
    });
    http.Response response;
    response = await http
        .get(Uri.parse('https://www.omdbapi.com/?s=${movie}&apikey=a6040b08'));
    if (response.statusCode == 200) {
      setState(() {
        product = jsonDecode(response.body)['Search'] ?? [];
        isLoading = false;
      });
      print(product);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Text('Movie Browse'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade200,
              Colors.blue.shade300,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: movie,
                        decoration: InputDecoration(
                            hintText: "Type to Search",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10)),
                      )),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            firstLoad = false;
                            fetchProduct(movie.text);
                          });
                          movie.clear();
                        },
                        child: Icon(
                          Icons.search,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: firstLoad
                    ? Center(
                        child: Text(
                          'Search a movie',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      )
                    : isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : product.isEmpty
                            ? Center(
                                child: Text('No movie found',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white)))
                            : ListView.builder(
                                itemCount: product.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MovieDetails(
                                                imdbID: product[index]
                                                    ['imdbID']),
                                          ));
                                    },
                                    child: Card(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8,
                                          horizontal: 16), // Card margin
                                      elevation:
                                          4, // Add elevation to create shadow
                                      child: ListTile(
                                        leading: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  product[index]['Poster']),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          product[index]['Title'],
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        subtitle: Text(
                                          product[index]['Type'],
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600]),
                                        ),
                                        trailing: Text(
                                          product[index]['Year'],
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600]),
                                        ),
                                      ),
                                    ),

                                    // ListTile(
                                    //   leading: Text((index + 1).toString()),
                                    //   title: Text(product[index]['Title']),
                                    //   trailing: CircleAvatar(
                                    //     backgroundImage: NetworkImage(
                                    //         product[index]['Poster']),
                                    //   ),
                                    // ),
                                  );
                                },
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

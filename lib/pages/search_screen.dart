import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth.dart';
import '../entities/shop.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_button/like_button.dart';

class SearchScreen extends StatefulWidget{
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

List<Shop> shops = [
    Shop(
      name: "Swapaholic",
      address: "#02 The Centrepoint, 04A, Singapore 238843",
      rating: 4.8,
      image: "assets/shops/swapaholic.jpg",
      lat: 1.30114,
      long: 103.8395
    ),

    Shop(
      name: "The Fashion Pulpit",
      address: "6A Shenton Way, Oue Downtown Gallery, #02-08 The Fashion Pulpit, Singapore 068815",
      rating: 4.9,
      image: "assets/shops/thefashionpulpit.jpg",
      lat: 1.278140,
      long: 103.849130
    ),

    Shop(
      name: "SSVP Shop",
      address: "501 Geylang Rd, Singapore 389459",
      rating: 4.7,
      image: "assets/shops/ssvpshop.jpg",
      lat: 1.313720,
      long: 103.884163
    ),

    Shop(
      name: "Nonmainstream",
      address: "462A Crawford Ln, #02-73, Singapore 191462",
      rating: 4.5,
      image: "assets/shops/nonmainstream.jpg",
      lat: 1.304890,
      long:  103.860771
    ),

    Shop(
      name: "Loop Garms",
      address: "635 Veerasamy Rd, #01-148, Singapore 200635",
      rating: 4.6,
      image: "assets/shops/loopgarms.jpg",
      lat: 1.306690,
      long:  103.860771
    ),  

    Shop(
      name: "Retro Gate",
      address: "5001 Beach Rd, #04-16 Golden Mile Complex, Singapore 199588",
      rating: 4.7,
      image: "assets/shops/retrogate.jpg",
      lat: 1.30315, 
      long: 103.86503
    ),

    Shop(
      name: "Refash",
      address: "68 Orchard Rd, #03-41, Singapore 238839",
      rating: 2.5,
      image: "assets/shops/refash.jpg",
      lat: 1.30038, 
      long: 103.8452
    ),

    Shop(
      name: "Deja Vu Vintage",
      address: "9 Raffles Blvd, #01-70, Millenia Walk, Singapore 039596",
      rating: 3.9,
      image: "assets/shops/dejavuvintage.jpg",
      lat: 1.29139, 
      long: 103.859497
    ),

    Shop(
      name: "New2U Thrift Shop",
      address: "96 Waterloo St, Singapore 187967",
      rating: 3.8,
      image: "assets/shops/new2u.jpg",
      lat: 1.29925, 
      long: 103.85195
    ),

    Shop(
      name: "Function Five Thrift Shop",
      address: "43 Arab St, Singapore 199742",
      rating: 4.9,
      image: "assets/shops/functionfive.png",
      lat: 1.30072,
      long: 103.85956
    ),

    Shop(
      name: "StyleTribute",
      address: "102F Pasir Panjang Rd, #04-07 Citilink Warehouse Complex, Singapore 118530",
      rating: 4.1,
      image: "assets/shops/styletribute.jpg",
      lat: 1.27545,
      long: 103.79461
    ),

    Shop(
      name: "Nightingale Thrift Shop",
      address: "1 Queensway Queensway Shopping Centre, #03-05, Singapore 149053",
      rating: 4.8,
      image: "assets/shops/nightingale.jpg",
      lat: 1.28806,
      long: 103.80383
    )
  ];

class _SearchScreen extends State<SearchScreen> {

  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar:
      AppBar(
          title: const Text(
            "Search",
          ),
          actions: [
            IconButton(
              onPressed: () {
                // method to show the search bar
                showSearch(
                    context: context,
                    // delegate to customize the search bar
                    delegate: CustomSearchDelegate()
                );
              },
              icon: const Icon(Icons.search),
            )
          ],
      ),
    body: ListView.builder(
      itemBuilder: (context, index) {
        return _listItem(index);
      },
      itemCount: shops.length,
    ),
  );


  Widget _likeButton() {

    if(user == null) {
      return const SizedBox(height: 0);
    }

    return LikeButton(
              size: 30.0,
              circleColor:
                const CircleColor(
                  start: Color.fromARGB(255, 241, 121, 161),
                  end: Color.fromARGB(255, 241, 121, 161)
                ),
                bubblesColor: const BubblesColor(
                  dotPrimaryColor: Color.fromARGB(255, 241, 121, 161),
                  dotSecondaryColor: Color.fromARGB(255, 241, 121, 161),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite,
                    color: isLiked ? Color.fromARGB(255, 241, 121, 161) : Colors.grey,
                    size: 30.0,
                  );
              },
    );
    
  }


  _listItem(index){
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(shops[index].image),
            const SizedBox(height: 10),

            Row(
              children: <Widget>[
              Text(
                  shops[index].name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
              ),
              const Spacer(), 
              _likeButton(),
            ]
            ),
            Row(
              children: <Widget>[
                RatingBarIndicator(
                  itemSize: 20,
                  rating: shops[index].rating,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  )
                ),
                const SizedBox(width: 5),
                Text(
                  shops[index].rating.toString(),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 189, 189, 189),
                  ),
                ),
              ],
            ),
            Text(
              shops[index].address,
              style: const TextStyle(
                color: Color.fromARGB(255, 117, 117, 117)
              ),
            ),
          ],
        ),
      ),
      );
  }

}


class CustomSearchDelegate extends SearchDelegate {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Shop> matchQuery = [];
    for (var shop in shops) {
      if (shop.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(shop);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(result.image),
                const SizedBox(height: 10),
                Text(
                      result.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),    
                Row(
                  children: <Widget>[
                    RatingBarIndicator(
                      itemSize: 20,
                      rating: result.rating,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    ),
                    const SizedBox(width: 5),
                    Text(
                      result.rating.toString(),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 189, 189, 189),
                      ),
                    ),
                  ],
                ),
                Text(
                  result.address,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 117, 117, 117)
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) { // same as buildResults
    List<Shop> matchQuery = [];
    for (var shop in shops) {
      if (shop.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(shop);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(result.image),
                const SizedBox(height: 10),
                Text(
                      result.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),    
                Row(
                  children: <Widget>[
                    RatingBarIndicator(
                      itemSize: 20,
                      rating: result.rating,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    ),
                    const SizedBox(width: 5),
                    Text(
                      result.rating.toString(),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 189, 189, 189),
                      ),
                    ),
                  ],
                ),
                Text(
                  result.address,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 117, 117, 117)
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
}
}
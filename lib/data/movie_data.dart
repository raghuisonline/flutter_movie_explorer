import '../models/movie.dart';

const List<Movie> movies = [
  Movie(
    id: 1,
    title: 'Interstellar',
    genre: 'Sci-Fi',
    year: '2014',
    rating: 8.7,
    description: 'A team of explorers travels through a wormhole in space to save humanity.',
    imageUrl: 'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?w=800',
  ),
  Movie(
    id: 2,
    title: 'The Dark Knight',
    genre: 'Action',
    year: '2008',
    rating: 9.0,
    description: 'Batman faces the Joker, a criminal mastermind who creates chaos in Gotham.',
    imageUrl: 'https://images.unsplash.com/photo-1509347528160-9a9e33742cdb?w=800',
  ),
  Movie(
    id: 3,
    title: 'Inception',
    genre: 'Sci-Fi',
    year: '2010',
    rating: 8.8,
    description: 'A thief enters dreams to steal secrets and is offered a chance to erase his past.',
    imageUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=800',
  ),
  Movie(
    id: 4,
    title: 'Coco',
    genre: 'Animation',
    year: '2017',
    rating: 8.4,
    description: 'A young boy enters the Land of the Dead to discover his family history.',
    imageUrl: 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=800',
  ),
  Movie(
    id: 5,
    title: 'The Pursuit of Happyness',
    genre: 'Drama',
    year: '2006',
    rating: 8.0,
    description: 'A struggling salesman takes custody of his son while pursuing a better life.',
    imageUrl: 'https://images.unsplash.com/photo-1497366811353-6870744d04b2?w=800',
  ),
  Movie(
    id: 6,
    title: 'Avengers: Endgame',
    genre: 'Action',
    year: '2019',
    rating: 8.4,
    description: 'The Avengers assemble once more to reverse the damage caused by Thanos.',
    imageUrl: 'https://images.unsplash.com/photo-1535016120720-40c646be5580?w=800',
  ),
];

const List<String> genres = ['All', 'Action', 'Animation', 'Drama', 'Sci-Fi'];

class Meme {
  final int id;
  final String author;
  final String template;
  final String url;

  const Meme({this.id, this.author, this.template, this.url});
}

class MemeData {
  static final List<Meme> memes = [
    const Meme(
        id: 1,
        author: 'joesmith',
        template: 'template_1',
        url: 'https://i.imgur.com/5WqoEci.png'),
    const Meme(
        id: 2,
        author: 'janesmith',
        template: 'template_2',
        url: 'https://i.imgur.com/GIt4jee.png'),
    const Meme(
        id: 3,
        author: 'foobar',
        template: 'template_3',
        url: 'https://i.imgur.com/BgpSvRN.jpg'),
    const Meme(
        id: 4,
        author: 'hiya',
        template: 'template_4',
        url: 'https://i.imgur.com/X2eLp8w.gifv'),
    const Meme(
        id: 5,
        author: 'dumpling',
        template: 'template_5',
        url: 'https://i.imgur.com/yH25jLZ.gifv'),
    const Meme(
        id: 6,
        author: 'burgerwithfries',
        template: 'template_6',
        url: 'https://i.imgur.com/4F94VJ3.jpg'),
  ];

  static Meme getMemes() {
    return memes;
  }

  static Meme getMemeById(id) {
    return memes.where((m) => m.id == id).first;
  }
}

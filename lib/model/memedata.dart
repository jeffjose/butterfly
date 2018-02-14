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
        id: 6,
        author: 'burgerwithfries',
        template: 'template_6',
        url: 'https://flutter.github.io/assets-for-api-docs/videos/butterfly.mp4'),
    const Meme(
        id: 1,
        author: 'joesmith',
        template: 'template_1',
        url: 'https://i.imgur.com/5WqoEci.png'),
    const Meme(
        id: 3,
        author: 'foobar',
        template: 'template_3',
        url: 'https://i.imgur.com/BgpSvRN.jpg'),
    const Meme(
        id: 5,
        author: 'dumpling',
        template: 'template_5',
        url: 'https://giant.gfycat.com/WaryGorgeousCamel.webm'),
    const Meme(
        id: 6,
        author: 'burgerwithfries',
        template: 'template_6',
        url: 'https://flutter.github.io/assets-for-api-docs/videos/butterfly.mp4'),
    const Meme(
        id: 7,
        author: 'boston',
        template: 'template_7',
        url: 'https://thumbs.gfycat.com/LazyBraveGlowworm-max-14mb.gif'),
    const Meme(
        id: 8,
        author: 'dog',
        template: 'template_8',
        url: 'https://thumbs.gfycat.com/CriminalFickleIberianbarbel-max-14mb.gif'),
    const Meme(
        id: 9,
        author: 'upvote',
        template: 'template_9',
        url: 'https://thumbs.gfycat.com/JointRichCapeghostfrog-max-14mb.gif'),
    const Meme(
        id: 10,
        author: 'ball',
        template: 'template_10',
        url: 'https://giant.gfycat.com/oddballscrawnyadeliepenguin.webm'),
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
        id: 5,
        author: 'dumpling',
        template: 'template_5',
        url: 'https://giant.gfycat.com/WaryGorgeousCamel.webm'),
    const Meme(
        id: 6,
        author: 'burgerwithfries',
        template: 'template_6',
        url: 'https://flutter.github.io/assets-for-api-docs/videos/butterfly.mp4'),
    const Meme(
        id: 7,
        author: 'boston',
        template: 'template_7',
        url: 'https://thumbs.gfycat.com/LazyBraveGlowworm-max-14mb.gif'),
    const Meme(
        id: 8,
        author: 'dog',
        template: 'template_8',
        url: 'https://thumbs.gfycat.com/CriminalFickleIberianbarbel-max-14mb.gif'),
    const Meme(
        id: 9,
        author: 'upvote',
        template: 'template_9',
        url: 'https://thumbs.gfycat.com/JointRichCapeghostfrog-max-14mb.gif'),
    const Meme(
        id: 10,
        author: 'ball',
        template: 'template_10',
        url: 'https://giant.gfycat.com/oddballscrawnyadeliepenguin.webm'),
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
        id: 5,
        author: 'dumpling',
        template: 'template_5',
        url: 'https://giant.gfycat.com/WaryGorgeousCamel.webm'),
    const Meme(
        id: 6,
        author: 'burgerwithfries',
        template: 'template_6',
        url: 'https://flutter.github.io/assets-for-api-docs/videos/butterfly.mp4'),
    const Meme(
        id: 7,
        author: 'boston',
        template: 'template_7',
        url: 'https://thumbs.gfycat.com/LazyBraveGlowworm-max-14mb.gif'),
    const Meme(
        id: 8,
        author: 'dog',
        template: 'template_8',
        url: 'https://thumbs.gfycat.com/CriminalFickleIberianbarbel-max-14mb.gif'),
    const Meme(
        id: 9,
        author: 'upvote',
        template: 'template_9',
        url: 'https://thumbs.gfycat.com/JointRichCapeghostfrog-max-14mb.gif'),
    const Meme(
        id: 10,
        author: 'ball',
        template: 'template_10',
        url: 'https://giant.gfycat.com/oddballscrawnyadeliepenguin.webm'),
  ];

  static Meme getMemes() {
    return memes;
  }

  static Meme getMemeById(id) {
    return memes.where((m) => m.id == id).first;
  }
}

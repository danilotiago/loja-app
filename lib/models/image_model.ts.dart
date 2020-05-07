class ImageAlbum {

  final String name;
  final int pos;
  final int x;
  final int y;


  ImageAlbum({this.name, this.pos, this.x, this.y});

  factory ImageAlbum.fromJson(Map<String, dynamic> json) {
    return ImageAlbum(
      name: json['name'],
      pos: json['pos'],
      x: json['x'],
      y: json['y']
    );
  }

}
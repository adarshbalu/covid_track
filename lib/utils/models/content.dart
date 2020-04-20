class Content {
  String image, text;
  Content getContent(String text, String image) {
    Content content = Content();
    content.text = text;
    content.image = image;
    return content;
  }
}

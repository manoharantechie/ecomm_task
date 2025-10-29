enum AppRoute {
  splash(path: "/splash"),
  home(path: "/home"),
  dashboard(path: "/dashboard"),
  product(path: "/product"),
  productlist(path: "/productlist"),
  productdetails(path: "/productdetails"),
  cart(path: "/cart"),
  profile(path: "/profile");

  final String path;
  const AppRoute({required this.path});
}
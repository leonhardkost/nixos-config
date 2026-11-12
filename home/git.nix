{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    git-crypt
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Leonhard Kost";
      user.email = "leonhard.kost@gmail.com";
    };
  };
}

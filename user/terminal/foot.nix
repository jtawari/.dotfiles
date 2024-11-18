let
  # Font family
  font = "SauceCodePro Nerd Font";

  # Font size
  size = "9.4";
in {
  # Configure Foot
  programs.foot = {
    enable = true;
    settings = {
      main = {
        term = "xterm-256color";

        font = "${font}:size=${size}:style=SemiBold";
        font-bold = "${font}:size=${size}:style=Bold";
        font-italic = "${font}:size=${size}:style=Italic";
        font-bold-italic = "${font}:size=${size}:style=Bold,Italic";
        line-height = 17;
        underline-offset = 17;
      };
    };
  };
}

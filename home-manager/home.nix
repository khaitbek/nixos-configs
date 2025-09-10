{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "hayitbek";
  home.homeDirectory = "/home/hayitbek";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    pkgs.zed-editor
    pkgs.pnpm
    vscode

    # misc
    which
    gnupg

    # hyprland ecosystem
    pkgs.hyprpaper
    pkgs.waybar
    pkgs.rofi

    pkgs.oh-my-posh
    pkgs.geist-font
    pkgs.nerd-fonts.geist-mono

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor 
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "khaitbek";
    userEmail = "khaitbek2005@gmail.com";
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 14;
	normal = {	
	  family = "GeistMono Nerd Font Mono";
	};
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
      window = {
	opacity = 0.5;
	blur = true;
	dynamic_title = true;
      };
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true; 
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      eval "$(oh-my-posh init bash --config 'https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/atomic.omp.json')"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };
  
  programs.kitty = {
    enable = true;
  };
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
  };
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind = [
        "$mod, B, exec, zen"
	"$mod, Return, exec, alacritty"
	"$mod, R, exec, rofi"
    ];
    monitor = "eDP-1, preferred, auto, 1"; 
    exec-once = "hyprpaper, waybar";
  };
  wayland.windowManager.hyprland.plugins = [];
  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    ipc = "on";
    preload = ["~/Pictures/wallpapers/Kath.png"];
    wallpaper = [
	"eDP-1,~/Pictures/wallpapers/Kath.png"
    ];
  };
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";
}

{config, pkgs, lib, ...}:

let
  bg-path = "~/Pictures/background.jpg";

  pulseaudio = pkgs.pulseaudioFull;

in
{
   # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.username = "ryan";
  home.homeDirectory = "/home/ryan";
  home.packages = with pkgs; [
    #Browser
    brave firefox google-chrome
       
    #Editor
    vscode texstudio

    # lorri support
    direnv

    # desktop
    albert tilda etcher

    #Work
    slack teams spotify todoist-electron zoom-us 

    teamviewer discord mpv

    nix-prefetch-scripts
    lazygit
    tldr

    # command line
    htop ranger zathura xclip tree

    # IDE
    jetbrains.pycharm-professional
    jetbrains.clion
    jetbrains.webstorm
    jetbrains.idea-ultimate
    android-studio

    #Games
    multimc
  ];

  programs.git = {
    enable = true;
    userName = "Ryan Miles";
    userEmail = "ryanm1114@gmail.com";
    extraConfig = {
      core.editor = "vim";
      github.username = "ryanm14";
    };
    aliases = {
      l = "log --graph --pretty='%Cred%h%Creset - %C(bold blue)<%an>%Creset %s%C(yellow)%d%Creset %Cgreen(%cr)' --abbrev-commit --date=relative";
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
      last = "log -l HEAD";
    };
  };

  programs.bat = {
    enable = true;
    config.style = "numbers,changes,header";
  };

  programs.lsd = {
    enable = true;

    # ls, ll, la, lt ...
    enableAliases = true;
  };

  programs.bash = {
    enable = true;

    shellAliases = {
      cat = "bat";
    };

    shellOptions = [
      # defaults
      "histappend"
      "checkwinsize"
      "extglob"
      "globstar"
      "checkjobs"

      # save multi-line commands as single entries
      "cmdhist"
    ];

    initExtra = ''
      eval "$(${pkgs.direnv}/bin/direnv hook bash)"
    '';
  };

  programs.htop = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
  };

  programs.fish = {
     enable = true;
     shellAliases = {
        ".." = "cd ..";
        cat = "bat";
        untar = "tar -xvzf";
        lg = "lazygit";
        nixos-re = "nixos-rebuild switch";
        home-re = "home-manager switch";
        nixtrash = "nix-collect-garbage";
        nixtrash-all = "nix-collect-garbage -d ";
        c = "clear";
     };

     functions = {
        mcd =  ''
            mkdir -p $argv
            cd $argv
            '';

        cls =  ''
            cd $argv
            ls
            '';

        backup =  ''
            cp $argv $argv.bak
            '';
     };

     plugins = [
           {
             name = "z";
             src = pkgs.fetchFromGitHub {
               owner = "jethrokuan";
               repo = "z";
               rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
               sha256 = "0c5i7sdrsp0q3vbziqzdyqn4fmp235ax4mn4zslrswvn8g3fvdyh";
             };
           }
           {
             name = "fish-ssh-agent";
             src = pkgs.fetchFromGitHub {
               owner = "danhper";
               repo = "fish-ssh-agent";
               rev = "ce90d80aa9549c626f9c5fc5a964536de015a192";
               sha256 = "03zj5g7dxkhqpp9lijxxlnyx4cc7nqpapj5iqfv7swavyximicyi";
             };
           }
     ];

     interactiveShellInit = ''
         set fish_greeting
         set -U fish_escape_delay_ms 10
     '';

      loginShellInit = ''
            direnv hook fish | source
          '';
  };

  programs.starship.enable = true;
  programs.starship.enableFishIntegration = true;
  programs.starship.settings.add_newline = true;
#  programs.starship.settings.battery = {
#    full_symbol = "[➜](#c792ea)";
#    charging_symbol = "[ ](bold green)";
#    discharging_symbol = "[➜](bold red)";
#    display = {
#        threshold = 100;
#        style = "bold red";
#     };
#  };

  programs.starship.settings.directory = {
    style = "bold cyan";
  };

  programs.starship.settings.nix_shell = {
    disabled = false;
    symbol = " ";
  };

   programs.starship.settings.rust = {
      disabled = false;
      format = "via [⚙️$version](red bold)";
#      detect_files =
    };

  programs.alacritty = {
      enable = true;
      settings = {
      	font = {
            size = 12;
            use_thin_strokes = true;

            normal.family = "FuraCode Nerd Font";
            bold.family = "FuraCode Nerd Font";
            italic.family = "FuraCode Nerd Font";
          };

          env = {
              "TERM" = "xterm-256color";
            };

      };

    };

  # https://github.com/target/lorri
  services.lorri.enable = true;

  services.blueman-applet.enable = true;

  services.redshift = {
    enable = true;
    latitude = "33.748997";
    longitude = "-84.387985";
  };

  # services.polybar = {
  #   enable = true;
  #   package = pkgs.polybar.override {
  #     i3Support = true;
  #     pulseSupport = true;
  #   };
  #   extraConfig =
  #   let
  #     white = "#ECEFF4";
  #     gray = "#65737E";
  #     black = "#232423";
  #     blue = "#88C0D0";
  #     yellow = "#EBCB8B";
  #     orange = "#D08770";
  #     red = "#BF616A";
  #     green = "#A3BE8C";
  #     magenta = "#B48EAD";
  #     background = "#802E3440";

  #     overpass = "Overpass Mono:pixelsize=9;2";
  #     monofur = "Monofur Nerd Font:pixelsize=9;2";
  #   in
  #   # inspired by /ossix/dotfiles/dark-forest
  #   ''
  #   [global/wm]
  #   margin-top = 0
  #   margin-bottom = 0

  #   # Settings
  #   [settings]
  #   screenchange-reload = true

  #   #
  #   # Bars
  #   #

  #   [bar/top]
  #   dpi = 192
  #   radius = 0.0
  #   fixed-center = true
  #   bottom = false
  #   height = 40
  #   padding-left = 3
  #   padding-right = 4
  #   background = ${background}
  #   foreground = ${white}
  #   module-margin = 1
  #   underline-size = 1
  #   border-bottom-size = 2
  #   border-color = ${gray}
  #   separator = " "

  #   font-0 = "TerminessTTF Nerd Font:size=9;2"
  #   font-1 = Font Awesome 5 Free:style=Regular:pixelsize=9;2
  #   font-2 = Font Awesome 5 Free:style=Solid:pixelsize=9;2
  #   font-3 = Font Awesome 5 Brands:pixelsize=9;2
  #   font-4 = "TerminessTTF Nerd Font:style=Bold:size=9;2"
  #   font-5 = FontAwesome:size=8;2
  #   font-6 = fontawesome:size=9;2

  #   enable-ipc = true

  #   modules-right = cpu memory battery volume
  #   modules-center = date
  #   modules-left = i3 xwindow

  #   #
  #   # Modules
  #   #

  #   [module/cpu]
  #   type = internal/cpu
  #   interval = 0.5

  #   format-prefix = 
  #   format = <label> <ramp-coreload>

  #   label = %{A1:termite --exec=htop & disown:}%percentage:3%%%{A}

  #   ramp-coreload-0 = ▁
  #   ramp-coreload-1 = ▂
  #   ramp-coreload-2 = ▃
  #   ramp-coreload-3 = ▄
  #   ramp-coreload-4 = ▅
  #   ramp-coreload-5 = ▆
  #   ramp-coreload-6 = ▇
  #   ramp-coreload-7 = █
  #   ramp-coreload-0-foreground = ${gray}
  #   ramp-coreload-1-foreground = ${green}
  #   ramp-coreload-2-foreground = ${green}
  #   ramp-coreload-3-foreground = ${yellow}
  #   ramp-coreload-4-foreground = ${yellow}
  #   ramp-coreload-5-foreground = ${orange}
  #   ramp-coreload-6-foreground = ${orange}
  #   ramp-coreload-7-foreground = ${red}


  #   [module/memory]
  #   type = internal/memory
  #   interval = 0.2
  #   format-prefix = 
  #   format = <label> <ramp-used>
  #   label = %{A1:termite --exec=htop & disown:}%percentage_used:3%%%{A}

  #   ramp-used-0 = ▁
  #   ramp-used-1 = ▂
  #   ramp-used-2 = ▃
  #   ramp-used-3 = ▄
  #   ramp-used-4 = ▅
  #   ramp-used-5 = ▆
  #   ramp-used-6 = ▇
  #   ramp-used-7 = █
  #   ramp-used-0-foreground = ${gray}
  #   ramp-used-1-foreground = ${green}
  #   ramp-used-2-foreground = ${green}
  #   ramp-used-3-foreground = ${yellow}
  #   ramp-used-4-foreground = ${yellow}
  #   ramp-used-5-foreground = ${orange}
  #   ramp-used-6-foreground = ${orange}
  #   ramp-used-7-foreground = ${red}


  #   [module/battery]
  #   type = internal/battery
  #   battery = BAT0
  #   adapter = ADP1
  #   full-at = 100
  #   interval = 1

  #   format-charging-prefix = 
  #   format-charging = <label-charging>
  #   label-charging = %percentage:3%%

  #   format-discharging = <ramp-capacity><label-discharging>
  #   label-discharging = %percentage:3%%

  #   format-full-prefix = 
  #   format-full = <label-full>
  #   label-full = %percentage:3%%

  #   ramp-capacity-0 = 
  #   ramp-capacity-0-font = 7
  #   ramp-capacity-1 = 
  #   ramp-capacity-1-font = 7
  #   ramp-capacity-2 = 
  #   ramp-capacity-2-font = 7
  #   ramp-capacity-3 = 
  #   ramp-capacity-3-font = 7
  #   ramp-capacity-4 = 
  #   ramp-capacity-4-font = 7
  #   ramp-capacity-0-foreground = ${red}
  #   ramp-capacity-1-foreground = ${orange}
  #   ramp-capacity-2-foreground = ${yellow}
  #   ramp-capacity-foreground = ${white}


  #   [module/volume]
  #   type = internal/pulseaudio
  #   format-volume = <ramp-volume><label-volume>
  #   label-volume = %percentage:3%%
  #   label-volume-foreground = ${white}

  #   format-muted-prefix = 
  #   format-muted-foreground = ${gray}
  #   label-muted = %percentage:3%%

  #   ramp-volume-0 = 
  #   ramp-volume-0-foreground = ${gray}
  #   ramp-volume-1 = 
  #   ramp-volume-1-foreground = ${yellow}
  #   ramp-volume-2 = 
  #   ramp-volume-2-foreground = ${orange}
  #   ramp-volume-3 = 
  #   ramp-volume-3-foreground = ${red}


  #   [module/date]
  #   type = internal/date
  #   date-alt = "%a - %m/%d"
  #   date = "%{T5}%I:%M%{T-}"
  #   interval = 1
  #   format-padding = 1
  #   format-background = ${gray}


  #   [module/i3]
  #   type = internal/i3
  #   format = <label-state>
  #   index-sort = true
  #   wrapping-scroll = false
  #   format-padding-right = 1

  #   label-focused = %name%
  #   label-focused-background = ${gray}
  #   label-focused-foreground = ${white}
  #   label-focused-overline  = ${gray}
  #   label-focused-padding = 2
  #   label-focused-font = 5

  #   label-unfocused = %name%
  #   label-unfocused-padding = 1
  #   label-unfocused-foreground = ${gray}
  #   label-unfocused-overline = ${background}

  #   label-occupied = %name%
  #   label-occupied-padding = 1

  #   label-urgent = 
  #   label-urgent-background = ${red}
  #   label-urgent-overline  = ${red}
  #   label-urgent-padding = 2

  #   label-empty = %name%
  #   label-empty-foreground = ${gray}
  #   label-empty-overline = ${background}
  #   label-empty-padding = 1

  #   label-visible = %name%
  #   label-visible-overline = ${background}
  #   label-visible-padding = 2


  #   [module/xwindow]
  #   type = internal/xwindow
  #   label =   %title:0:40:...%
  #   label-empty = root-window
  #   label-empty-foreground = ${yellow}
  #   label-background = ${gray}
  #   label-padding = 1
  #   click-left = skippy-xd
  #   click-right = skippy-xd
  #   '';

  #   # necessary to include i3 path to start correctly
  #   script = ''
  #     PATH=$PATH:${pkgs.i3}/bin polybar top &
  #   '';
  # };
  home.stateVersion = "21.05";
}

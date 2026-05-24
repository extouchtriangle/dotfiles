{ config, lib, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      name = "GeistMono Nerd Font";
      size = 12;
    };
    settings = {
      scrollback_lines = 20000;
      touch_scroll_multiplier = 5.0;
      allow_remote_control = "yes";
      cursor_shape = "beam";
      cursor_trail = 3;
      confirm_os_window_close = 0;
      copy_on_select = "yes";
      background = "#1a1d21";
      foreground = "#e0dcd4";
      cursor = "#DBCDB3";

      selection_foreground = "#e0dcd4";
      selection_background = "#3d424a";

      color0 = "#1a1d21";
      color8 = "#515761";

      color1 = "#CDACAC";
      color9 = "#c8beb8";

      color2 = "#b8c4b8";
      color10 = "#b4beb4";

      color3 = "#DBCDB3";
      color11 = "#ccc4b0";

      color4 = "#b4bcc4";
      color12 = "#b4bcc4";

      color5 = "#c0b8bc";
      color13 = "#c4beb8";

      color6 = "#b0bcc8";
      color14 = "#b0c0b8";

      color7 = "#c0bdb8";
      color15 = "#e0dcd4";
      linux_display_server = "wayland";
    };
    extraConfig = ''
    mouse_hide_wait 2.0
    background_tint 0.9
    kitty_mod ctrl+shift
    background_opacity 0.92
    map ctrl+shift+l next_tab
    map ctrl+shift+h previous_tab

    map kitty_mod+t new_tab_with_cwd

    tab_bar_min_tabs 1
    tab_bar_edge bottom
    tab_bar_style powerline
    tab_powerline_style slanted

    map ctrl+c copy_or_interrupt

    map page_up scroll_page_up
    map page_down scroll_page_down

    map ctrl+plus change_font_size all +1
    map ctrl+equal change_font_size all +1
    map ctrl+kp_add change_font_size all +1
    map ctrl+minus change_font_size all -1
    map ctrl+underscore change_font_size all -1
    map ctrl+kp_subtract change_font_size all -1
    map ctrl+0 change_font_size all 0
    map ctrl+kp_0 change_font_size all 0
    '';
  };
}

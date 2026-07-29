{
    pkgs,
    config,
    ...
}: {
    programs.tmux = {
      enable = true;
      plugins = with pkgs.tmuxPlugins; [
        cpu
        vim-tmux-navigator
        {
          plugin = catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavor "mocha"
          '';
        }
      ];
      extraConfig = ''
# leader
set -g prefix C-Space

# start index at 1
set -g base-index 1
set -g pane-base-index 1
set-window-option -g pane-base-index 1
set-option -g renumber-windows on

# vim navigation
bind-key h previous-window
bind-key l next-window

# open panes in current dir and bind to non-defaults
unbind '"'
unbind %
bind k split-window -v -c "#{pane_current_path}"
bind j split-window -h -c "#{pane_current_path}"

# theme + color
set -g default-terminal "tmux-256color"
set -ag terminal-features ",xterm-256color:RGB"
set -g @catppuccin_flavor 'mocha'
set-option -g status-position bottom
set -g status-right-length 100
set -g status-left-length 100
set -g status-left ""
set -g status-right "#{E:@catppuccin_status_application}"
set -agF status-right "#{E:@catppuccin_status_cpu}"
set -ag status-right "#{E:@catppuccin_status_uptime}"
set -ag status-right "#{E:@catppuccin_status_session}"

# enable mouse resizing
set -g mouse on
      '';
    };
}

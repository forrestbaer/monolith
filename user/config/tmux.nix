{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    extraConfig = ''
      set -g default-terminal "screen-256color"
	    bind c new-window -c "#{pane_current_path}"
	    bind r source-file ~/.tmux.conf \; display "Config reloaded"

	    bind n select-pane -L
	    bind o select-pane -R
	    bind e select-pane -D
	    bind i select-pane -U
	    bind d detach-client
	    bind x kill-pane
	    bind | split-window -h
	    bind - split-window -v

      set -g mouse on
	    set -s set-clipboard off
	    set -g set-clipboard external
	    set -s copy-command "wl-copy --type text/plain"
	    set -g history-limit 50000
	    set -g escape-time 0
	    set -g status-interval 1
	    set -g visual-activity on
	    setw -g monitor-activity on
	    setw -g mode-keys vi
	    set -g status-keys vi
	    set -g bell-action none
	    set -g focus-events on
	    
	    set -g pane-border-style bg=colour0
	    set -g pane-border-style fg=colour8
	    set -g pane-active-border-style bg=colour0
	    set -g pane-active-border-style fg=colour8

	    set -g default-terminal "screen-256color"
	    set -ga terminal-overrides ",screen-256color:Tc"
	    set -sa terminal-overrides ",screen-256color:RGB"
	    
	    set -g status-position bottom
	    set -g status-bg colour234
	    set -g status-fg colour137
	    set -g status-right-length 240
	    set -g status-left-length 40
	    set -g status-left "#[fg=colour233,bg=colour234]#[fg=colour137,bg=colour234]"
	    set -g status-right "#[fg=colour243] #[fg=colour245,bg=colour234]"
	    set -ag status-right "#[fg=colour233,bg=colour241]#(tmux-mem-cpu-load --averages-count 0) #[fg=colour233,bg=colour245]  %r #[fg=colour233,bg=colour245] "
	    
	    setw -g window-status-current-style fg=colour82
	    setw -g window-status-current-style bg=colour238
	    setw -g window-status-current-style bold
	    setw -g window-status-current-format " #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F "
	    
	    setw -g window-status-style fg=colour135
	    setw -g window-status-style bg=colour235
	    setw -g window-status-format " #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F "
	    
	    set -g message-style bold
	    set -g message-style fg=colour232
	    set -g message-style bg=colour238
	    
	    setw -g window-status-activity-style bg=black
	    setw -g window-status-activity-style fg=green
    '';
    prefix = "C-a";
    terminal = "screen-256color";
  };
}

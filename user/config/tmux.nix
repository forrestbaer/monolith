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
	    set -g set-clipboard external
	    set -s set-clipboard off
	    set -s copy-command "wl-copy --type text/plain"
	    
	    set-option -g history-limit 50000
	    set-option -g escape-time 0
	    set-option -g status-interval 1
	    
	    set-option -g visual-activity on
	    set-window-option -g monitor-activity on
	    
	    set-window-option -g mode-keys vi
	    set-option -g status-keys vi
	    set-option -g bell-action none
	    set-option -g focus-events on
	    
	    set-option -g pane-border-style bg=colour0
	    set-option -g pane-border-style fg=colour8
	    set-option -g pane-active-border-style bg=colour0
	    set-option -g pane-active-border-style fg=colour8

	    set-option -g default-terminal "screen-256color"
	    set-option -ga terminal-overrides ",screen-256color:Tc"
	    set-option -sa terminal-overrides ",screen-256color:RGB"
	    
	    set-option -g status-position bottom
	    set-option -g status-bg colour234
	    set-option -g status-fg colour137
	    set-option -g status-right-length 240
	    set-option -g status-left-length 40
	    set-option -g status-left "#[fg=colour233,bg=colour234]#[fg=colour137,bg=colour234]"
	    set-option -g status-right "#[fg=colour243] #[fg=colour245,bg=colour234]"
	    set-option -ag status-right "#[fg=colour233,bg=colour241]#(tmux-mem-cpu-load --averages-count 0) #[fg=colour233,bg=colour245]  %r #[fg=colour233,bg=colour245] "
	    
	    set-window-option -g window-status-current-style fg=colour81
	    set-window-option -g window-status-current-style bg=colour238
	    set-window-option -g window-status-current-style bold
	    set-window-option -g window-status-current-format " #I#[fg=colour250]:#[fg=colour255]#W#[fg=colour50]#F "
	    
	    set-window-option -g window-status-style fg=colour135
	    set-window-option -g window-status-style bg=colour235
	    set-window-option -g window-status-format " #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F "
	    
	    set-option -g message-style bold
	    set-option -g message-style fg=colour232
	    set-option -g message-style bg=colour238
	    
	    set-window-option -g window-status-activity-style bg=black
	    set-window-option -g window-status-activity-style fg=green
    '';
    prefix = "C-a";
    terminal = "screen-256color";
  };
}

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PS1="$? [\[\e[0;97m\]\w\[\e[0m\]] \[\e[0;90m\]\$ \[\e[0m\]"
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      set -o noclobber
      set -o vi

      bind "set completion-ignore-case on"
      bind "set completion-map-case on"
      bind "set show-all-if-ambiguous on"
      bind "set mark-symlinked-directories on"
      '';
    historyControl = [ "erasedups" ];
    historyIgnore = ["[ ]*" "exit" "ls" "bg" "fg" "history" "clear"];
    shellAliases = {
      less = "less -RX";
      ls = "lsd";
      lsa = "ls -a";
      ll = "ls -l";
      lla = "ls -la";
      mv = "mv -i";
      md = "mkdir -p";
      more = "less";
      sudo = "sudo ";
      t = "task";
      gs = "git status";
      gc = "git commit";
      gd = "git diff";
      gp = "git push";
      gf = "git fetch";
      ga = "git add";
    };
    shellOptions = [
      "histappend"
      "cmdhist"
      "nocaseglob"
      "checkwinsize"
      "autocd"
      "dirspell"
      "cdspell"
    ];
  };
}

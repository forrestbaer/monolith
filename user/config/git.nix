{
  programs.git = {
    enable = true;
    userName = "Forrest Baer";
    userEmail = "forrest@forrestbaer.com";

    delta.enable = true;
    delta.options = {
      line-numbers = true;
      navigate = true;
      side-by-side = true;
    };

    extraConfig = {
      core.autocrlf = false;
      merge.conflictstyle = "diff3";
      mergetool = {
        keepBackup = false;
        prompt = false;
      };
      push.autoSetupRemote = true;
      credential."https://github.com" = {
	      helper = "!gh auth git-credential";
	      autoSetupRemote = true;
      };
    };
  };
}

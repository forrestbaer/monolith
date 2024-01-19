{
  programs.dircolors = {
    enable = true;
    settings = {
      COLOR = "all";
      TERM = "xterm*";
      NORMAL = "00";
      RESET = "0";
      FILE = "01;37";
      DIR = "33";
      LINK = "97";
      MULTIHARDLINK = "97";
      FIFO = "30;100";
      SOCK = "30;100";
      DOOR = "30;100";
      BLK = "30;100";
      CHR = "30;100";
      ORPHAN = "31";
      MISSING = "01;37;41";
      EXEC = "32";
      SETUID = "01;04;37;";
      SETGID = "01;04;37;";
      CAPABILITY = "01;37";
    };
  };
}

{
  programs.lsd = {
    enable = true;
    settings = {
      blocks = [ "user" "permission" "date" "size" "name" ];
      color.theme = "custom";
      date = "+%D";
      icons.when = "auto";
      icons.theme = "fancy";
      icons.separator = " ";
      indicators = true;
      permission = "octal";
      total-size = true;
      sorting.dir-grouping = "first";
    };
    colors = {
      user = 238;
      group = 238;
      permission = {
        read = 248;
        write = 248;
        exec = 248;
        exec-sticky = 248;
        no-access = 248;
        octal = 248;
        acl = 248;
        context = 248;
      };
      date = {
        hour-old = 248;
        day-old = 240;
        older = 234;
      };
      size = {
        none = 6;
        small = 6;
        medium = 6;
        large = 6;
      };
      inode = {
        valid = 13;
        invalid = 245;
      };
      links = {
        valid = 13;
        invalid = 245;
      };
      tree-edge = 245;
      git-status = {
        default = 245;
        unmodified = 245;
        ignored = 245;
        new-in-index = "dark_green";
        new-in-workdir = "dark_green";
        typechange = "dark_yellow";
        deleted = "dark_red";
        renamed = "dark_green";
        modified = "dark_yellow";
        conflicted = "dark_red";
      };
    };
  };
}

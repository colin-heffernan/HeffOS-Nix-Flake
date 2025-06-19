{
  inputs,
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.utility.no-tty.enable {
    programs.yazi = {
      enable = true;
      initLua = builtins.readFile ./init.lua;
      keymap = {
        manager.keymap = [
          {
            on = "<Esc>";
            run = "escape";
            desc = "Exit visual mode, clear selected, or cancel find or search";
          }
          {
            on = "q";
            run = "quit";
            desc = "Quit and change directory";
          }
          {
            on = "Q";
            run = "quit --no-cwd-file";
            desc = "Quit without changing directory";
          }
          {
            on = "<Up>";
            run = "arrow -1";
            desc = "Move cursor up";
          }
          {
            on = "<Down>";
            run = "arrow 1";
            desc = "Move cursor down";
          }
          {
            on = "<Left>";
            run = "leave";
            desc = "Exit to parent directory";
          }
          {
            on = "<Right>";
            run = "enter";
            desc = "Enter selected child directory";
          }
          {
            on = "<Space>";
            run = ["toggle" "arrow 1"];
            desc = "Toggle selection";
          }
          {
            on = "<Tab>";
            run = "spot";
            desc = "Spot file";
          }
          {
            on = "e";
            run = "open";
            desc = "Open file";
          }
          {
            on = "y";
            run = "yank";
            desc = "Yank selection";
          }
          {
            on = "x";
            run = "yank --cut";
            desc = "Cut selection";
          }
          {
            on = "p";
            run = "paste";
            desc = "Paste yanked selection";
          }
          {
            on = "P";
            run = "paste --force";
            desc = "Force paste yanked selection";
          }
          {
            on = "-";
            run = "link";
            desc = "Symlink to yanked selection";
          }
          {
            on = "d";
            run = "remove";
            desc = "Trash selection";
          }
          {
            on = "D";
            run = "remove --permanently";
            desc = "Permanently delete selection";
          }
          {
            on = "a";
            run = "create";
            desc = "Create file";
          }
          {
            on = "A";
            run = "create --dir";
            desc = "Create directory";
          }
          {
            on = "r";
            run = "rename --cursor=before_ext";
            desc = "Rename file/directory";
          }
          {
            on = "m";
            run = "plugin chmod";
            desc = "Change file permissions";
          }
          {
            on = ".";
            run = "hidden toggle";
            desc = "Toggle hidden files";
          }
          {
            on = "s";
            run = "search --via=fd";
            desc = "Search by name";
          }
          {
            on = "S";
            run = "search --via=rg";
            desc = "Search by content";
          }
          {
            on = "f";
            run = "filter --smart";
            desc = "Filter files";
          }
          {
            on = ["g" "h"];
            run = "cd ~";
            desc = "Go to Home";
          }
          {
            on = ["g" "d"];
            run = "cd ~/Downloads";
            desc = "Go to Downloads";
          }
          {
            on = ["g" "r"];
            run = "cd ~/Repos";
            desc = "Go to Repos";
          }
          {
            on = "w";
            run = "tasks_show";
            desc = "Show task manager";
          }
          {
            on = "~";
            run = "help";
            desc = "Open help";
          }
        ];
        tasks.keymap = [
          {
            on = "<Esc>";
            run = "close";
            desc = "Close task manager";
          }
          {
            on = "<Up>";
            run = "arrow -1";
            desc = "Move cursor up";
          }
          {
            on = "<Down>";
            run = "arrow 1";
            desc = "Move cursor down";
          }
          {
            on = "<Enter>";
            run = "inspect";
            desc = "Inspect the task";
          }
          {
            on = "d";
            run = "cancel";
            desc = "Cancel the task";
          }
          {
            on = "~";
            run = "help";
            desc = "Open help";
          }
        ];
        spot.keymap = [
          {
            on = "<Esc>";
            run = "close";
            desc = "Close the spot";
          }
          {
            on = "<Up>";
            run = "arrow -1";
            desc = "Move cursor up";
          }
          {
            on = "<Down>";
            run = "arrow 1";
            desc = "Move cursor down";
          }
          {
            on = "<Left>";
            run = "swipe -1";
            desc = "Swipe to previous file";
          }
          {
            on = "<Right>";
            run = "swipe 1";
            desc = "Swipe to next file";
          }
          {
            on = "~";
            run = "help";
            desc = "Open help";
          }
        ];
        pick.keymap = [
          {
            on = "<Esc>";
            run = "close";
            desc = "Close the spot";
          }
          {
            on = "<Up>";
            run = "arrow -1";
            desc = "Move cursor up";
          }
          {
            on = "<Down>";
            run = "arrow 1";
            desc = "Move cursor down";
          }
          {
            on = "~";
            run = "help";
            desc = "Open help";
          }
        ];
        input.keymap = [
          {
            on = "<Esc>";
            run = "escape";
            desc = "Go back to normal mode or cancel input";
          }
          {
            on = "<Enter>";
            run = "close --submit";
            desc = "Submit input";
          }
          {
            on = "i";
            run = "insert";
            desc = "Enter insert mode before cursor";
          }
          {
            on = "a";
            run = "insert --append";
            desc = "Enter insert mode after cursor";
          }
          {
            on = "I";
            run = ["move -999" "insert"];
            desc = "Enter insert mode at line start";
          }
          {
            on = "A";
            run = ["move 999" "insert --append"];
            desc = "Enter insert mode at line end";
          }
          {
            on = "v";
            run = "visual";
            desc = "Enter visual mode";
          }
          {
            on = "<Left>";
            run = "move -1";
            desc = "Move back a character";
          }
          {
            on = "<Right>";
            run = "move 1";
            desc = "Move forward a character";
          }
          {
            on = "<Backspace>";
            run = "backspace";
            desc = "Delete character before cursor";
          }
          {
            on = "<Delete>";
            run = "backspace --under";
            desc = "Delete character after cursor";
          }
          {
            on = "d";
            run = "delete --cut";
            desc = "Delete selected characters";
          }
          {
            on = "c";
            run = "delete --cut --insert";
            desc = "Delete selected characters and enter insert mode";
          }
          {
            on = "y";
            run = "yank";
            desc = "Yank selected characters";
          }
          {
            on = "p";
            run = "paste";
            desc = "Paste yanked characters after cursor";
          }
          {
            on = "P";
            run = "paste --before";
            desc = "Paste yanked characters before cursor";
          }
          {
            on = "u";
            run = "undo";
            desc = "Undo previous operation";
          }
          {
            on = "<C-r>";
            run = "redo";
            desc = "Redo operation";
          }
          {
            on = "~";
            run = "help";
            desc = "Open help";
          }
        ];
        confirm.keymap = [
          {
            on = "<Esc>";
            run = "close";
            desc = "Close confirmation";
          }
          {
            on = "<Enter>";
            run = "close --submit";
            desc = "Submit confirmation";
          }
          {
            on = "<Up>";
            run = "arrow -1";
            desc = "Move cursor up";
          }
          {
            on = "<Down>";
            run = "arrow 1";
            desc = "Move cursor down";
          }
          {
            on = "~";
            run = "help";
            desc = "Open help";
          }
        ];
        completion.keymap = [
          {
            on = "<Esc>";
            run = "close";
            desc = "Close completion";
          }
          {
            on = "<Enter>";
            run = ["close --submit" "close_input --submit"];
            desc = "Submit completion";
          }
          {
            on = "<Up>";
            run = "arrow -1";
            desc = "Move cursor up";
          }
          {
            on = "<Down>";
            run = "arrow 1";
            desc = "Move cursor down";
          }
          {
            on = "~";
            run = "help";
            desc = "Open help";
          }
        ];
        help.keymap = [
          {
            on = "<Esc>";
            run = "close";
            desc = "Close the spot";
          }
          {
            on = "<Up>";
            run = "arrow -1";
            desc = "Move cursor up";
          }
          {
            on = "<Down>";
            run = "arrow 1";
            desc = "Move cursor down";
          }
          {
            on = "f";
            run = "filter";
            desc = "Filter help items";
          }
        ];
      };
      plugins = {
        chmod = inputs.yazi-plugins + "/chmod.yazi";
        full-border = inputs.yazi-plugins + "/full-border.yazi";
      };
      settings = {
        manager = {
          sort_by = "natural";
          sort_sensitive = false;
          sort_dir_first = true;
          sort_translit = true;
          show_hidden = true;
          show_symlink = true;
          scrolloff = 3;
        };
        preview = {
          wrap = "no";
          tab_size = 2;
          image_delay = 0;
        };
        opener = {
          edit = [
            {
              run = "direnv exec . $EDITOR \"$@\"";
              block = true;
              for = "unix";
            }
          ];
        };
        input = {
          cursor_blink = false;
        };
      };
      shellWrapperName = "yz";
    };
  };
}

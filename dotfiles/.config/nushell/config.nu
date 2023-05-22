# Nushell Config File
#
# version = 0.79.0

let dark_theme = {
    separator: "#a9b1d6"
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: "#9ece6a" attr: "b" }
    empty: "#7aa2f7"
    bool: {|| if $in { "#7dcfff" } else { "light_gray" } }
    int: "#a9b1d6"
    filesize: {|e|
      if $e == 0b {
        "#a9b1d6"
      } else if $e < 1mb {
        "#7dcfff"
      } else {{ fg: "#7aa2f7" }}
    }
    duration: "#a9b1d6"
    date: {|| (date now) - $in |
      if $in < 1hr {
        { fg: "#f7768e" attr: "b" }
      } else if $in < 6hr {
        "#f7768e"
      } else if $in < 1day {
        "#e0af68"
      } else if $in < 3day {
        "#9ece6a"
      } else if $in < 1wk {
        { fg: "#9ece6a" attr: "b" }
      } else if $in < 6wk {
        "#7dcfff"
      } else if $in < 52wk {
        "#7aa2f7"
      } else { "dark_gray" }
    }
    range: "#a9b1d6"
    float: "#a9b1d6"
    string: "#a9b1d6"
    nothing: "#a9b1d6"
    binary: "#a9b1d6"
    cellpath: "#a9b1d6"
    row_index: { fg: "#9ece6a" attr: "b" }
    record: "#a9b1d6"
    list: "#a9b1d6"
    block: "#a9b1d6"
    hints: "dark_gray"

    shape_and: "#c0caf5"
    shape_binary: "#c0caf5"
    shape_block: "#c0caf5"
    shape_bool: "#c0caf5"
    shape_custom: "#c0caf5"
    shape_datetime: "#c0caf5"
    shape_directory: "#c0caf5"
    shape_external: { fg: "#9ece6a" attr: "b" }
    shape_externalarg: "#c0caf5"
    shape_filepath: "#c0caf5"
    shape_flag: "#c0caf5"
    shape_float: "#c0caf5"
    shape_garbage: { fg: "#c0caf5" bg: "#f7768e" attr: "b" }
    shape_globpattern: "#c0caf5"
    shape_int: "#c0caf5"
    shape_internalcall: { fg: "#9ece6a" attr: "b" }
    shape_list: "#c0caf5"
    shape_literal: "#c0caf5"
    shape_match_pattern: "#c0caf5"
    shape_matching_brackets: { attr: "n" }
    shape_nothing: "#c0caf5"
    shape_operator: "#c0caf5"
    shape_or: "#c0caf5"
    shape_pipe: "#c0caf5"
    shape_range: "#c0caf5"
    shape_record: "#c0caf5"
    shape_redirection: "#c0caf5"
    shape_signature: "#c0caf5"
    shape_string: "#c0caf5"
    shape_string_interpolation: "#c0caf5"
    shape_table: "#c0caf5"
    shape_variable: "#c0caf5"

    background: "#1a1b26"
    foreground: "#c0caf5"
    cursor: "#c0caf5"
}

let-env config = {
  show_banner: false
  ls: {
    use_ls_colors: true
    clickable_links: true
  }
  rm: {
    always_trash: false
  }
  cd: {
    abbreviations: false
  }
  table: {
    mode: rounded
    index_mode: always
    show_empty: true
    trim: {
      methodology: truncating
      wrapping_try_keep_words: true
      truncating_suffix: "..."
    }
  }

  explore: {
    help_banner: true
    exit_esc: true

    command_bar_text: '#C4C9C6'

    status_bar_background: {fg: '#1D1F21' bg: '#C4C9C6' }

    highlight: {bg: 'yellow' fg: 'black' }

    status: {
    }

    try: {
    }

    table: {
      split_line: '#404040'

      cursor: true

      line_index: true
      line_shift: true
      line_head_top: true
      line_head_bottom: true

      show_head: true
      show_index: true
    }

    config: {
      cursor_color: {bg: 'yellow' fg: 'black' }
    }
  }

  history: {
    max_size: 10000
    sync_on_enter: true
    file_format: "plaintext"
  }
  completions: {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: "prefix"
    external: {
      enable: true
      max_results: 100
      completer: null
    }
  }
  filesize: {
    metric: true
    format: "auto"
  }
  cursor_shape: {
    emacs: line
    vi_insert: line
    vi_normal: block
  }
  color_config: $dark_theme
  use_grid_icons: true
  footer_mode: "25"
  float_precision: 2
  # buffer_editor: "nvim"
  use_ansi_coloring: true
  edit_mode: vi
  shell_integration: true
  render_right_prompt_on_last_line: false

  hooks: {
    pre_prompt: [{||
      let direnv = (direnv export json | from json)
      let direnv = if ($direnv | length) == 1 { $direnv } else { {} }
      $direnv | load-env
    }]
    pre_execution: [{||
      null
    }]
    env_change: {
      PWD: [{|before, after|
        null
      }]
    }
    display_output: {||
      if (term size).columns >= 100 { table -e } else { table }
    }
    command_not_found: {||
      null
    }
  }
  menus: [
      {
        name: completion_menu
        only_buffer_difference: false
        marker: "| "
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: history_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: help_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: description
            columns: 4
            col_width: 20
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: commands_menu
        only_buffer_difference: false
        marker: "# "
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where name =~ $buffer
            | each { |it| {value: $it.name description: $it.usage} }
        }
      }
      {
        name: vars_menu
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.vars
            | where name =~ $buffer
            | sort-by name
            | each { |it| {value: $it.name description: $it.type} }
        }
      }
      {
        name: commands_with_description
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: description
            columns: 4
            col_width: 20
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where name =~ $buffer
            | each { |it| {value: $it.name description: $it.usage} }
        }
      }
  ]
  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: [emacs vi_normal vi_insert]
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: completion_previous
      modifier: shift
      keycode: backtab
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menuprevious }
    }
    {
      name: history_menu
      modifier: control
      keycode: char_r
      mode: emacs
      event: { send: menu name: history_menu }
    }
    {
      name: next_page
      modifier: control
      keycode: char_x
      mode: emacs
      event: { send: menupagenext }
    }
    {
      name: undo_or_previous_page
      modifier: control
      keycode: char_z
      mode: emacs
      event: {
        until: [
          { send: menupageprevious }
          { edit: undo }
        ]
       }
    }
    {
      name: yank
      modifier: control
      keycode: char_y
      mode: emacs
      event: {
        until: [
          {edit: pastecutbufferafter}
        ]
      }
    }
    {
      name: unix-line-discard
      modifier: control
      keycode: char_u
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cutfromlinestart}
        ]
      }
    }
    {
      name: kill-line
      modifier: control
      keycode: char_k
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cuttolineend}
        ]
      }
    }
    {
      name: commands_menu
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_menu }
    }
    {
      name: vars_menu
      modifier: alt
      keycode: char_o
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: vars_menu }
    }
    {
      name: commands_with_description
      modifier: control
      keycode: char_s
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_with_description }
    }
  ]
}

source ~/.zoxide.nu

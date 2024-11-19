{
  # Configure Fish
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Disable greeting
      set fish_greeting

      # Enable vi key bindings
      fish_vi_key_bindings
    '';
    functions = {
      __fish_command_not_found_handler = {
        body = "echo \"$argv[1]: command not found\"";
        onEvent = "fish_command_not_found";
      };
    };
  };
}

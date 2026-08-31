{ config, lib, ... }: {
  # Общий модуль Zsh для всех пользователей
  # Базовая конфигурация: oh-my-zsh, история, completion, autosuggestion, syntax highlighting
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
      theme = "agnoster";
    };
  };
}

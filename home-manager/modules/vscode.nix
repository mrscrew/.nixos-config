{ pkgs, ... }: {
  # Модуль VS Code расширений для пользователя master
  # Включает основные расширения для разработки и AI-ассистент SourceCraft
  
  # SourceCraft Code Assistant (расширение Yandex Cloud), официальный VSIX из хранилища Яндекса
  let
    sourcecraft-code-assist = pkgs.vscode-utils.buildVscodeExtensionFromVsix {
      name = "sourcecraft-code-assist";
      src = pkgs.fetchurl {
        url = "https://storage.yandexcloud.net/sourcecraft-code-assistant/plugins/vscode/stable/yandex-cloud-code-assist.vsix";
        sha256 = "8bf0218f5e880ad96b5f0f50f84873125be9a2f176804f0f789df3722271cb11";
      };
    };
  in
  home.packages = with pkgs; [
    # VS Code с текущим набором плагинов
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        davidanson.vscode-markdownlint    # Линтер Markdown
        jnoortheen.nix-ide                # Поддержка Nix
        ms-azuretools.vscode-docker       # Поддержка Docker
        ms-ceintl.vscode-language-pack-ru # Русский языковой пакет
        ms-python.python                  # Поддержка Python
        ms-vscode-remote.remote-ssh       # Удалённый SSH
        redhat.vscode-yaml                # Поддержка YAML
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        { name = "remote-ssh-edit"; publisher = "ms-vscode-remote"; version = "0.47.2"; sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g"; }
        { name = "koda"; publisher = "Koda"; version = "1.1.0"; sha256 = "b33cc64762a302c81e970ef7dbda138ed0acc6cadefef81bab431f310952d638"; }
      ] ++ [
        sourcecraft-code-assist           # SourceCraft Code Assistant (AI-ассистент)
      ];
    })
  ];
}

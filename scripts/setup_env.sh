echo "#################################################"

echo "开始设置运行环境..."

echo "#################################################"

if command -v brew >/dev/null 2>&1; then
  echo 'Homebrew已安装...'
else
  echo "开始安装macos包管理工具homebrew.."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "完成安装macos包管理工具homebrew..."
fi

echo "#################################################"

if command -v fvm >/dev/null 2>&1; then
  echo 'FVM已安装...'
else
  echo "开始安装Flutter SDK版本管理工具fvm..."
  brew install fvm --verbose
  echo "完成安装Flutter SDK版本管理工具fvm..."
fi

echo "#################################################"


if command -v flutter >/dev/null 2>&1; then
  echo 'Flutter已安装...'
else
  echo "开始安装Flutter环境..."
  fvm install --verbose
  echo "完成安装Flutter环境..."
fi

echo "#################################################"


if command -v melos >/dev/null 2>&1; then
  echo 'Melos已安装...'
else
  echo "开始安装模块化工具Melos..."
  dart pub global activate melos
  echo "完成安装模块化工具Melos..."
fi

echo "#################################################"

echo "完成设置运行环境!"

echo "#################################################"

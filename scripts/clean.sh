# 提升构建号
echo '执行打包前的清理工作 开始...'

echo '递增版本号...'
set -e
if [ -z "$1" ]
then
  perl -i -pe 's/^(version:\s+\d+\.\d+\.\d+\+)(\d+)$/$1.($2+1)/e' pubspec.yaml
else
  sed -i '' "s/^version.*/version: $1/g" pubspec.yaml
fi
# 提升web版本, 为了处理main.dart.js缓存问题
#dart scripts/bump_web_version.dart

latestGitMessage=$(git log --pretty=format:"%s" -1)
if [ "$latestGitMessage" != "chore: bump version." ]
then
  git commit pubspec.yaml -m "chore: bump version."
else
  git commit pubspec.yaml -m "chore: bump version." --amend
fi

#rm -r build/app/outputs/flutter-apk
#melos bootstrap --verbose

echo '执行打包前的清理工作 结束...'

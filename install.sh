# 自动获取最新版本号，如果失败则使用硬编码的备用版本
REPO="coder/code-server"
FALLBACK_VERSION=4.122.1

echo "正在获取 $REPO 最新版本..."
VERSION=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
  | grep '"tag_name":' \
  | cut -d'"' -f4 \
  | sed 's/^v//')

if [ -z "$VERSION" ]; then
  VERSION=$FALLBACK_VERSION
  echo "获取最新版本失败，使用备用版本 v$VERSION"
else
  echo "最新版本: v$VERSION"
fi

mkdir -p ~/.local/lib ~/.local/bin
curl -fL "https://github.com/$REPO/releases/download/v$VERSION/code-server-$VERSION-linux-amd64.tar.gz" \
  | tar -C ~/.local/lib -xz
mv ~/.local/lib/code-server-$VERSION-linux-amd64 ~/.local/lib/code-server-$VERSION
ln -s ~/.local/lib/code-server-$VERSION/bin/code-server ~/.local/bin/code-server
export PATH="~/.local/bin:$PATH"
echo "code-server v$VERSION 安装完成！"
# code-server
# Now visit http://127.0.0.1:8080. Your password is in ~/.config/code-server/config.yaml


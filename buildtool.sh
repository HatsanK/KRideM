#!/usr/bin/env bash

echo "* Firefox Buildtool: Packer Script"

DES=build/krpatch_idolmaster.sidem
rm -rf $DES
mkdir -p $DES

echo "* Firefox Buildtool: Copy Files"

cp    manifest.json                     $DES/


cp -R images                            $DES/images
cp -R css                               $DES/css

set +v
echo "* Firefox Buildtool: Creating package..."
pushd $DES/ > /dev/null
# zip ../krpatch.cinderella.girls.xpi -qr *

# https://github.com/mozilla/web-ext/issues/793
unset WEB_EXT_API_KEY
unset WEB_EXT_API_SECRET

web-ext lint -v

# https://github.com/mozilla/web-ext/issues/793
export WEB_EXT_API_KEY=$ENV_WEB_EXT_API_KEY
export WEB_EXT_API_SECRET=$ENV_WEB_EXT_API_SECRET

web-ext sign -v

zsh -c 'autoload zmv; zmv "web-ext-artifacts/sidem-(*)-an+fx.xpi" "../sidem_krpatch-$1-an+fx.xpi"'

popd > /dev/null

echo "* Firefox Buildtool: Done."
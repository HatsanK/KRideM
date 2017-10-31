#!/usr/bin/env bash

echo "* Firefox Buildtool: Packer Script"

DES=build/krpatch_idolmaster.sidem
rm -rf $DES
mkdir -p $DES

echo "* Firefox Buildtool: Copy Files"

cp    manifest.json                     $DES/

cp -R images                            $DES/images
cp -R css/custom.css                    $DES/css/custom.css


set +v
echo "* Firefox Buildtool: Creating package..."
pushd $DES/ > /dev/null
# zip ../krpatch.cinderella.girls.xpi -qr *
# web-ext lint
web-ext sign
zsh -c 'autoload zmv; zmv "web-ext-artifacts/(.*)-(.*)-an+fx.xpi" "../sidem_krpatch-$2-an+fx.xpi"'

popd > /dev/null

echo "* Firefox Buildtool: Done."
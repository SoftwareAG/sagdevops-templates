#!/bin/bash

if ! [ -x "$(command -v sagcc)" ]; then
  echo "Error: sagcc is not installed." >&2
  exit 1
fi

template=template.yaml;
for dir in */ ; do 
  if [[ -d "$dir" && ! -L "$dir" ]]; then
    template_path=$dir$template;
    echo "Importing $template_path";
    sagcc exec templates composite import -i $template_path overwrite=true
  fi; 
done

echo "Register layer definitions"
sagcc exec templates composite apply sag-cc-layer-defs --wait-for-cc 120 --sync-job -w 3600


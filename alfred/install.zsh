#!/bin/zsh

local base=${0:h}
source ${base}/../lib/utils

main() {
  print-header "alfred workflows"
  print-message "make sure you have alfred installed with the powerpack"

  local zeno_rocha="https://github.com/zenorocha/alfred-workflows/raw/master"
  local workflows
  workflows=(
    "${zeno_rocha}/package-managers/package-managers.alfredworkflow"
    "${zeno_rocha}/caniuse/caniuse.alfredworkflow"
    "${zeno_rocha}/colors/colors.alfredworkflow"
    "${zeno_rocha}/dash/dash.alfredworkflow"
    "${zeno_rocha}/stack-overflow/stack-overflow.alfredworkflow"
    "https://github.com/packal/repository/raw/master/com.vdesabou.spotify.mini.player/spotifyminiplayer.alfredworkflow"
    "https://github.com/packal/repository/raw/master/net.deanishe.alfred-convert/convert-2.5.alfredworkflow"
    "https://github.com/packal/repository/raw/master/com.eunjae.alfred.simpletimer/simple_timer.alfredworkflow"
    "https://raw.github.com/willfarrell/alfred-github-workflow/master/Github.alfredworkflow"
    "https://github.com/packal/repository/raw/master/com.groenewege.faker/faker.alfredworkflow"
  )

  for workflow in $workflows; do
    curl -L -o "$TMPDIR/${workflow:t}" "${workflow}"
    open "$TMPDIR/${workflow:t}"
    # time to accept the import in Alfred
    sleep 5
  done
}

main $@


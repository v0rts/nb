#!/usr/bin/env bats

load test_helper

# folders first ###############################################################

@test "'list --folders-first' prints folders first while preserving pinning." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    --content "Example content one."
    "${_NB}" folder add "Folder One"
    "${_NB}" add "File Two.md"    --content "Example content two."
    "${_NB}" add "File Three.md"  --content "Example content three."
    "${_NB}" folder add "Folder Two"
    "${_NB}" add "File Four.md"   --content "Example content four."
    "${_NB}" folder add "Folder Three"

    "${_NB}" pin "Folder Two"
    "${_NB}" pin "File Three.md"
  }

  run "${_NB}" list --with-pinned

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]
  [[ "${#lines[@]}" -eq 7 ]]

  [[ "${lines[0]}"  =~  \
.*[.*5.*].*\ 📌\ 📂\ Folder\ Two                                    ]]
  [[ "${lines[1]}"  =~  \
.*[.*4.*].*\ 📌\ File\ Three\.md\ \·\ \"Example\ content\ three\.\" ]]
  [[ "${lines[2]}"  =~  \
.*[.*7.*].*\ 📂\ Folder\ Three                                      ]]
  [[ "${lines[3]}"  =~  \
.*[.*6.*].*\ File\ Four\.md\ \·\ \"Example\ content\ four\.\"       ]]
  [[ "${lines[4]}"  =~  \
.*[.*3.*].*\ File\ Two\.md\ \·\ \"Example\ content\ two\.\"         ]]
  [[ "${lines[5]}"  =~  \
.*[.*2.*].*\ 📂\ Folder\ One                                        ]]
  [[ "${lines[6]}"  =~  \
.*[.*1.*].*\ File\ One\.md\ \·\ \"Example\ content\ one\.\"         ]]

  run "${_NB}" list --folders-first --with-pinned

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]
  [[ "${#lines[@]}" -eq 7 ]]

  [[ "${lines[0]}"  =~  \
.*[.*5.*].*\ 📌\ 📂\ Folder\ Two                                    ]]
  [[ "${lines[1]}"  =~  \
.*[.*4.*].*\ 📌\ File\ Three\.md\ \·\ \"Example\ content\ three\.\" ]]
  [[ "${lines[2]}"  =~  \
.*[.*7.*].*\ 📂\ Folder\ Three                                      ]]
  [[ "${lines[3]}"  =~  \
.*[.*2.*].*\ 📂\ Folder\ One                                        ]]
  [[ "${lines[4]}"  =~  \
.*[.*6.*].*\ File\ Four\.md\ \·\ \"Example\ content\ four\.\"       ]]
  [[ "${lines[5]}"  =~  \
.*[.*3.*].*\ File\ Two\.md\ \·\ \"Example\ content\ two\.\"         ]]

  [[ "${lines[6]}"  =~  \
.*[.*1.*].*\ File\ One\.md\ \·\ \"Example\ content\ one\.\"         ]]
}

@test "'list --folders-first' prints folders first." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    --content "Example content one."
    "${_NB}" folder add "Folder One"
    "${_NB}" add "File Two.md"    --content "Example content two."
    "${_NB}" add "File Three.md"  --content "Example content three."
    "${_NB}" folder add "Folder Two"
  }

  run "${_NB}" list

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]
  [[ "${#lines[@]}" -eq 5 ]]

  [[ "${lines[0]}"  =~  \
.*[.*5.*].*\ 📂\ Folder\ Two                                    ]]
  [[ "${lines[1]}"  =~  \
.*[.*4.*].*\ File\ Three\.md\ \·\ \"Example\ content\ three\.\" ]]
  [[ "${lines[2]}"  =~  \
.*[.*3.*].*\ File\ Two\.md\ \·\ \"Example\ content\ two\.\"     ]]
  [[ "${lines[3]}"  =~  \
.*[.*2.*].*\ 📂\ Folder\ One                                    ]]
  [[ "${lines[4]}"  =~  \
.*[.*1.*].*\ File\ One\.md\ \·\ \"Example\ content\ one\.\"     ]]

  run "${_NB}" list --folders-first

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]
  [[ "${#lines[@]}" -eq 5 ]]

  [[ "${lines[0]}"  =~  \
.*[.*5.*].*\ 📂\ Folder\ Two                                    ]]
  [[ "${lines[1]}"  =~  \
.*[.*2.*].*\ 📂\ Folder\ One                                    ]]
  [[ "${lines[2]}"  =~  \
.*[.*4.*].*\ File\ Three\.md\ \·\ \"Example\ content\ three\.\" ]]
  [[ "${lines[3]}"  =~  \
.*[.*3.*].*\ File\ Two\.md\ \·\ \"Example\ content\ two\.\"     ]]

  [[ "${lines[4]}"  =~  \
.*[.*1.*].*\ File\ One\.md\ \·\ \"Example\ content\ one\.\"     ]]
}

@test "'list --ff' prints folders first." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    --content "Example content one."
    "${_NB}" folder add "Folder One"
    "${_NB}" add "File Two.md"    --content "Example content two."
    "${_NB}" add "File Three.md"  --content "Example content three."
    "${_NB}" folder add "Folder Two"
  }

  run "${_NB}" list

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]
  [[ "${#lines[@]}" -eq 5 ]]

  [[ "${lines[0]}"  =~  \
.*[.*5.*].*\ 📂\ Folder\ Two                                    ]]
  [[ "${lines[1]}"  =~  \
.*[.*4.*].*\ File\ Three\.md\ \·\ \"Example\ content\ three\.\" ]]
  [[ "${lines[2]}"  =~  \
.*[.*3.*].*\ File\ Two\.md\ \·\ \"Example\ content\ two\.\"     ]]
  [[ "${lines[3]}"  =~  \
.*[.*2.*].*\ 📂\ Folder\ One                                    ]]
  [[ "${lines[4]}"  =~  \
.*[.*1.*].*\ File\ One\.md\ \·\ \"Example\ content\ one\.\"     ]]

  run "${_NB}" list --ff

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]
  [[ "${#lines[@]}" -eq 5 ]]

  [[ "${lines[0]}"  =~  \
.*[.*5.*].*\ 📂\ Folder\ Two                                    ]]
  [[ "${lines[1]}"  =~  \
.*[.*2.*].*\ 📂\ Folder\ One                                    ]]
  [[ "${lines[2]}"  =~  \
.*[.*4.*].*\ File\ Three\.md\ \·\ \"Example\ content\ three\.\" ]]
  [[ "${lines[3]}"  =~  \
.*[.*3.*].*\ File\ Two\.md\ \·\ \"Example\ content\ two\.\"     ]]

  [[ "${lines[4]}"  =~  \
.*[.*1.*].*\ File\ One\.md\ \·\ \"Example\ content\ one\.\"     ]]
}

@test "'NB_FOLDERS_FIRST=1 list' has no effect." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    --content "Example content one."
    "${_NB}" folder add "Folder One"
    "${_NB}" add "File Two.md"    --content "Example content two."
    "${_NB}" add "File Three.md"  --content "Example content three."
    "${_NB}" folder add "Folder Two"
  }

  run "${_NB}" list

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]
  [[ "${#lines[@]}" -eq 5 ]]

  [[ "${lines[0]}"  =~  \
.*[.*5.*].*\ 📂\ Folder\ Two                                    ]]
  [[ "${lines[1]}"  =~  \
.*[.*4.*].*\ File\ Three\.md\ \·\ \"Example\ content\ three\.\" ]]
  [[ "${lines[2]}"  =~  \
.*[.*3.*].*\ File\ Two\.md\ \·\ \"Example\ content\ two\.\"     ]]
  [[ "${lines[3]}"  =~  \
.*[.*2.*].*\ 📂\ Folder\ One                                    ]]
  [[ "${lines[4]}"  =~  \
.*[.*1.*].*\ File\ One\.md\ \·\ \"Example\ content\ one\.\"     ]]

  NB_FOLDERS_FIRST=1 run "${_NB}" list

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]
  [[ "${#lines[@]}" -eq 5 ]]

  [[ "${lines[0]}"  =~  \
.*[.*5.*].*\ 📂\ Folder\ Two                                    ]]
  [[ "${lines[1]}"  =~  \
.*[.*4.*].*\ File\ Three\.md\ \·\ \"Example\ content\ three\.\" ]]
  [[ "${lines[2]}"  =~  \
.*[.*3.*].*\ File\ Two\.md\ \·\ \"Example\ content\ two\.\"     ]]
  [[ "${lines[3]}"  =~  \
.*[.*2.*].*\ 📂\ Folder\ One                                    ]]
  [[ "${lines[4]}"  =~  \
.*[.*1.*].*\ File\ One\.md\ \·\ \"Example\ content\ one\.\"     ]]
}

# filename handling ###########################################################

@test "'list' prints normally with uncommon filenames." {
  {
    "${_NB}" init
    "${_NB}" add "File [] One.md"   --title "Title One"
    "${_NB}" add "File [Two].md"    --title "Title Two"
    "${_NB}" add "File [ Three.md"  --title "Title Three"
    "${_NB}" add "File ] Four.md"   --title "Title Four"
    "${_NB}" add "File () Five.md"  --title "Title Five"
    "${_NB}" add "File (Six).md"    --title "Title Six"
    "${_NB}" add "File ( Seven.md"  --title "Title Seven"
    "${_NB}" add "File ) Eight.md"  --title "Title Eight"
  }

  run "${_NB}" list

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                           ]]
  [[ "${#lines[@]}" -eq 8                           ]]

  [[ "${lines[0]}"  =~  \.*[.*8.*].*\ Title\ Eight  ]]
  [[ "${lines[1]}"  =~  \.*[.*7.*].*\ Title\ Seven  ]]
  [[ "${lines[2]}"  =~  \.*[.*6.*].*\ Title\ Six    ]]
  [[ "${lines[3]}"  =~  \.*[.*5.*].*\ Title\ Five   ]]
  [[ "${lines[4]}"  =~  \.*[.*4.*].*\ Title\ Four   ]]
  [[ "${lines[5]}"  =~  \.*[.*3.*].*\ Title\ Three  ]]
  [[ "${lines[6]}"  =~  \.*[.*2.*].*\ Title\ Two    ]]
  [[ "${lines[7]}"  =~  \.*[.*1.*].*\ Title\ One    ]]
}

# temporary files #############################################################

@test "'list' ignores common temporary files." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md" --content "Example content one."
    "${_NB}" add "File Two.md" --content "Example content two."

    "${_NB}" run touch "Example Temp One.md~"
    "${_NB}" run touch "#Example Temp Two.md#"
    "${_NB}" run touch "Example Temp Three.md.swp"
    "${_NB}" run touch "Example Temp Four.md.swap"
    "${_NB}" run touch ".#Example Temp Five.md"
    "${_NB}" run touch "Example Temp Six_ltex.json"

    "${_NB}" add "File Three.md" --content "Example content three."
  }

  run "${_NB}" list

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]
  [[ "${#lines[@]}" -eq 3 ]]

  [[ "${lines[0]}"  =~  \
.*[.*3.*].*\ File\ Three\.md\ \·\ \"Example\ content\ three\.\" ]]
  [[ "${lines[1]}"  =~  \
.*[.*2.*].*\ File\ Two\.md\ \·\ \"Example\ content\ two\.\"     ]]
  [[ "${lines[2]}"  =~  \
.*[.*1.*].*\ File\ One\.md\ \·\ \"Example\ content\ one\.\"     ]]
}

# list content (title, filename, first line) ##################################

@test "'list' includes titles when present, otherwise filenames with first lines." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    --content "$(cat <<HEREDOC
# Example Title One

Example first line one.

Example second line one.
HEREDOC
)"
    "${_NB}" add "File Two.md"    --content "$(cat <<HEREDOC
Example first line two.

Example second line two.
HEREDOC
)"
    "${_NB}" add "File Three.md"  --content "$(cat <<HEREDOC
${_BT}${_BT}${_BT}html
# Example Code Block Title Three
${_BT}${_BT}${_BT}

Example first line three.

Example second line three.
HEREDOC
)"
  }

  run "${_NB}" list

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]

  [[ "${lines[0]}"  =~  \
.*\[.*3.*\].*\ File\ Three\.md\ ·\ \"Example\ first\ line\ three\.\"  ]]
  [[ "${lines[1]}"  =~  \
.*\[.*2.*\].*\ File\ Two\.md\ ·\ \"Example\ first\ line\ two\.\"      ]]
  [[ "${lines[2]}"  =~  \
.*\[.*1.*\].*\ Example\ \Title\ One                                   ]]
}

# notebook: selectors #########################################################

@test "'list --notebook-selectors' includes notebook selectors when listing the root level of the current notebook." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    --title "Title One"
    "${_NB}" add "File Two.md"    --title "Title Two"
    "${_NB}" add "File Three.md"  --title "Title Three"
  }

  run "${_NB}" list --notebook-selectors

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                 ]]

  [[ "${lines[0]}"  =~  .*\[.*home:3.*\].*\ Title\ Three  ]]
  [[ "${lines[1]}"  =~  .*\[.*home:2.*\].*\ Title\ Two    ]]
  [[ "${lines[2]}"  =~  .*\[.*home:1.*\].*\ Title\ One    ]]
}

@test "'list --notebook-selectors' includes notebook selectors when listing a nested folder in the current notebook." {
  {
    "${_NB}" init

    "${_NB}" add "Example Folder/File One.md"    --title "Title One"
    "${_NB}" add "Example Folder/File Two.md"    --title "Title Two"
    "${_NB}" add "Example Folder/File Three.md"  --title "Title Three"
  }

  run "${_NB}" list Example\ Folder/ --notebook-selectors

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                           ]]

  [[ "${lines[0]}"  =~  .*\[.*Example\ Folder/3.*\].*\ Title\ Three ]]
  [[ "${lines[1]}"  =~  .*\[.*Example\ Folder/2.*\].*\ Title\ Two   ]]
  [[ "${lines[2]}"  =~  .*\[.*Example\ Folder/1.*\].*\ Title\ One   ]]
}

@test "'list --notebook-selectors' includes notebook selectors when listing root level of a selected notebook." {
  {
    "${_NB}" init

    "${_NB}" notebooks add "Example Notebook"

    "${_NB}" add "Example Notebook:File One.md"    --title "Title One"
    "${_NB}" add "Example Notebook:File Two.md"    --title "Title Two"
    "${_NB}" add "Example Notebook:File Three.md"  --title "Title Three"
  }

  run "${_NB}" list Example\ Notebook: --notebook-selectors

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                             ]]

  [[ "${lines[0]}"  =~  .*\[.*Example\ Notebook:3.*\].*\ Title\ Three ]]
  [[ "${lines[1]}"  =~  .*\[.*Example\ Notebook:2.*\].*\ Title\ Two   ]]
  [[ "${lines[2]}"  =~  .*\[.*Example\ Notebook:1.*\].*\ Title\ One   ]]
}

@test "'list --notebook-selectors' includes notebook selectors when listing a nested folder of a selected notebook." {
  {
    "${_NB}" init

    "${_NB}" notebooks add "Example Notebook"

    "${_NB}" add "Example Notebook:Sample Folder/File One.md"    --title "Title One"
    "${_NB}" add "Example Notebook:Sample Folder/File Two.md"    --title "Title Two"
    "${_NB}" add "Example Notebook:Sample Folder/File Three.md"  --title "Title Three"
  }

  run "${_NB}" list Example\ Notebook:Sample\ Folder/ --notebook-selectors

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                     ]]

  [[ "${lines[0]}"  =~  \
.*\[.*Example\ Notebook:Sample\ Folder/3.*\].*\ Title\ Three  ]]
  [[ "${lines[1]}"  =~  \
.*\[.*Example\ Notebook:Sample\ Folder/2.*\].*\ Title\ Two    ]]
  [[ "${lines[2]}"  =~  \
.*\[.*Example\ Notebook:Sample\ Folder/1.*\].*\ Title\ One    ]]
}

@test "'list' does not use notebook selectors when listing the root level of the current notebook by default." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    --title "Title One"
    "${_NB}" add "File Two.md"    --title "Title Two"
    "${_NB}" add "File Three.md"  --title "Title Three"
  }

  run "${_NB}" list

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                           ]]

  [[ "${lines[0]}"  =~  .*\[.*3.*\].*\ Title\ Three ]]
  [[ "${lines[1]}"  =~  .*\[.*2.*\].*\ Title\ Two   ]]
  [[ "${lines[2]}"  =~  .*\[.*1.*\].*\ Title\ One   ]]
}

@test "'list' does not use notebook selectors when listing a nested folder in the current notebook by default." {
  {
    "${_NB}" init

    "${_NB}" add "Example Folder/File One.md"    --title "Title One"
    "${_NB}" add "Example Folder/File Two.md"    --title "Title Two"
    "${_NB}" add "Example Folder/File Three.md"  --title "Title Three"
  }

  run "${_NB}" list Example\ Folder/

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                           ]]

  [[ "${lines[0]}"  =~  .*\[.*Example\ Folder/3.*\].*\ Title\ Three ]]
  [[ "${lines[1]}"  =~  .*\[.*Example\ Folder/2.*\].*\ Title\ Two   ]]
  [[ "${lines[2]}"  =~  .*\[.*Example\ Folder/1.*\].*\ Title\ One   ]]
}

@test "'list' includes notebook selectors when listing root level of a selected notebook by default." {
  {
    "${_NB}" init

    "${_NB}" notebooks add "Example Notebook"

    "${_NB}" add "Example Notebook:File One.md"    --title "Title One"
    "${_NB}" add "Example Notebook:File Two.md"    --title "Title Two"
    "${_NB}" add "Example Notebook:File Three.md"  --title "Title Three"
  }

  run "${_NB}" list Example\ Notebook:

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                             ]]

  [[ "${lines[0]}"  =~  .*\[.*Example\ Notebook:3.*\].*\ Title\ Three ]]
  [[ "${lines[1]}"  =~  .*\[.*Example\ Notebook:2.*\].*\ Title\ Two   ]]
  [[ "${lines[2]}"  =~  .*\[.*Example\ Notebook:1.*\].*\ Title\ One   ]]
}

@test "'list' includes notebook selectors when listing a nested folder of a selected notebook by default." {
  {
    "${_NB}" init

    "${_NB}" notebooks add "Example Notebook"

    "${_NB}" add "Example Notebook:Sample Folder/File One.md"    --title "Title One"
    "${_NB}" add "Example Notebook:Sample Folder/File Two.md"    --title "Title Two"
    "${_NB}" add "Example Notebook:Sample Folder/File Three.md"  --title "Title Three"
  }

  run "${_NB}" list Example\ Notebook:Sample\ Folder/

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                     ]]

  [[ "${lines[0]}"  =~  \
.*\[.*Example\ Notebook:Sample\ Folder/3.*\].*\ Title\ Three  ]]
  [[ "${lines[1]}"  =~  \
.*\[.*Example\ Notebook:Sample\ Folder/2.*\].*\ Title\ Two    ]]
  [[ "${lines[2]}"  =~  \
.*\[.*Example\ Notebook:Sample\ Folder/1.*\].*\ Title\ One    ]]
}

# .index ######################################################################

@test "'list' reconciles ancestor .index files with incomplete nested .index file." {
  {
    "${_NB}" init

    mkdir -p "${NB_DIR}/home/Example/Sample/Demo"

    printf "# Title" > "${NB_DIR}/home/Example/Sample/Demo/File.md"

    touch "${NB_DIR}/home/Example/Sample/Demo/.index"

    git -C "${NB_DIR}/home" add --all
    git -C "${NB_DIR}/home" commit -am "Example commit message."

    [[ !  -e "${NB_DIR}/home/Example/.index"              ]]
    [[ !  -e "${NB_DIR}/home/Example/Sample/.index"       ]]
    [[    -e "${NB_DIR}/home/Example/Sample/Demo/.index"  ]]
    [[    -e "${NB_DIR}/home/Example/Sample/Demo/File.md" ]]

    git -C "${NB_DIR}/home" status

    [[ -z "$(git -C "${NB_DIR}/home" status --porcelain)" ]]
  }

  run "${_NB}" list "Example/Sample/Demo/"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                       ]]
  [[ "${#lines[@]}" -eq 1                                       ]]

  [[ "${lines[0]}"  =~  \.*[.*Example/Sample/Demo/1.*].*\ Title ]]

  diff                                                  \
    <(cat "${NB_DIR}/home/Example/.index")              \
    <(printf "Sample\\n")

  diff                                                  \
    <(cat "${NB_DIR}/home/Example/Sample/.index")       \
    <(printf "Demo\\n")

  diff                                                  \
    <(cat "${NB_DIR}/home/Example/Sample/Demo/.index")  \
    <(printf "File.md\\n")

  cd "${NB_DIR}/home" || return 1

  git -C "${NB_DIR}/home" status
  git -C "${NB_DIR}/home" log

  while [[ -n "$(git -C "${NB_DIR}/home" status --porcelain)" ]]
  do
    sleep 1
  done

  git -C "${NB_DIR}/home" log | grep -q '\[nb\] Reconcile Index'
}

@test "'list' reconciles ancestor .index files with missing nested .index file." {
  {
    "${_NB}" init

    mkdir -p "${NB_DIR}/home/Example/Sample/Demo"

    printf "# Title" > "${NB_DIR}/home/Example/Sample/Demo/File.md"

    git -C "${NB_DIR}/home" add --all
    git -C "${NB_DIR}/home" commit -am "Example commit message."

    [[ !  -e "${NB_DIR}/home/Example/.index"              ]]
    [[ !  -e "${NB_DIR}/home/Example/Sample/.index"       ]]
    [[ !  -e "${NB_DIR}/home/Example/Sample/Demo/.index"  ]]
    [[    -e "${NB_DIR}/home/Example/Sample/Demo/File.md" ]]

    git -C "${NB_DIR}/home" status

    [[ -z "$(git -C "${NB_DIR}/home" status --porcelain)" ]]
  }

  run "${_NB}" list "Example/Sample/Demo/"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                       ]]
  [[ "${#lines[@]}" -eq 1                                       ]]

  [[ "${lines[0]}"  =~  \.*[.*Example/Sample/Demo/1.*].*\ Title ]]

  diff                                                  \
    <(cat "${NB_DIR}/home/Example/.index")              \
    <(printf "Sample\\n")

  diff                                                  \
    <(cat "${NB_DIR}/home/Example/Sample/.index")       \
    <(printf "Demo\\n")

  diff                                                  \
    <(cat "${NB_DIR}/home/Example/Sample/Demo/.index")  \
    <(printf "File.md\\n")

  cd "${NB_DIR}/home" || return 1

  git -C "${NB_DIR}/home" status
  git -C "${NB_DIR}/home" log

  while [[ -n "$(git -C "${NB_DIR}/home" status --porcelain)" ]]
  do
    sleep 1
  done

  git -C "${NB_DIR}/home" log | grep -q '\[nb\] Reconcile Index'
}

@test "'list' reconciles root-level .index." {
  {
    "${_NB}" init
    "${_NB}" add "File One.md"    --title "Title One"
    "${_NB}" add "File Two.md"    --title "Title Two"
    "${_NB}" add "File Three.md"  --title "Title Three"

    printf "# Title Four" > "${NB_DIR}/home/File Four.md"

    "${_NB}" git -C "${NB_DIR}/home" add --all
    "${_NB}" git -C "${NB_DIR}/home" commit -am "Example commit message."

    git -C "${NB_DIR}/home" status

    [[ -z "$(git -C "${NB_DIR}/home" status --porcelain)" ]]

    diff                              \
      <(cat "${NB_DIR}/home/.index")  \
      <(cat <<HEREDOC
File One.md
File Two.md
File Three.md
HEREDOC
)

    [[  -e "${NB_DIR}/home/File One.md"    ]]
    [[  -e "${NB_DIR}/home/File Two.md"    ]]
    [[  -e "${NB_DIR}/home/File Three.md"  ]]
    [[  -e "${NB_DIR}/home/File Four.md"   ]]
  }

  run "${_NB}" list

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                           ]]
  [[ "${#lines[@]}" -eq 4                           ]]

  [[ "${lines[0]}"  =~  \.*[.*4.*].*\ Title\ Four   ]]
  [[ "${lines[1]}"  =~  \.*[.*3.*].*\ Title\ Three  ]]
  [[ "${lines[2]}"  =~  \.*[.*2.*].*\ Title\ Two    ]]
  [[ "${lines[3]}"  =~  \.*[.*1.*].*\ Title\ One    ]]

  diff                              \
    <(cat "${NB_DIR}/home/.index")  \
    <(cat <<HEREDOC
File One.md
File Two.md
File Three.md
File Four.md
HEREDOC
)

  git -C "${NB_DIR}/home" log

  while [[ -n "$(git -C "${NB_DIR}/home" status --porcelain)" ]]
  do
    sleep 1
  done

  git -C "${NB_DIR}/home" log | grep -q '\[nb\] Reconcile Index'
}

@test "'list' reconciles nested .index." {
  {
    "${_NB}" init
    "${_NB}" add "Example Folder/File One.md"    --title "Title One"
    "${_NB}" add "Example Folder/File Two.md"    --title "Title Two"
    "${_NB}" add "Example Folder/File Three.md"  --title "Title Three"

    printf "# Title Four" > "${NB_DIR}/home/Example Folder/File Four.md"

    diff                                            \
      <(cat "${NB_DIR}/home/Example Folder/.index") \
      <(cat <<HEREDOC
File One.md
File Two.md
File Three.md
HEREDOC
)

    [[  -e "${NB_DIR}/home/Example Folder/File One.md"    ]]
    [[  -e "${NB_DIR}/home/Example Folder/File Two.md"    ]]
    [[  -e "${NB_DIR}/home/Example Folder/File Three.md"  ]]
    [[  -e "${NB_DIR}/home/Example Folder/File Four.md"   ]]
  }

  run "${_NB}" list Example\ Folder/

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                             ]]
  [[ "${#lines[@]}" -eq 4                                             ]]

  [[ "${lines[0]}"  =~  \.*[.*Example\ Folder/4.*].*\ Title\ Four     ]]
  [[ "${lines[1]}"  =~  \.*[.*Example\ Folder/3.*].*\ Title\ Three    ]]
  [[ "${lines[2]}"  =~  \.*[.*Example\ Folder/2.*].*\ Title\ Two      ]]
  [[ "${lines[3]}"  =~  \.*[.*Example\ Folder/1.*].*\ Title\ One      ]]

  diff                                            \
    <(cat "${NB_DIR}/home/Example Folder/.index") \
    <(cat <<HEREDOC
File One.md
File Two.md
File Three.md
File Four.md
HEREDOC
)

  git -C "${NB_DIR}/home" log

  while [[ -n "$(git -C "${NB_DIR}/home" status --porcelain)" ]]
  do
    sleep 1
  done

  git -C "${NB_DIR}/home" log | grep -q '\[nb\] Reconcile Index'
}

# pinning #####################################################################

@test "'list --with-pinned' reconciles .pindex when file is deleted and deletes .pindex when empty." {
  {
    "${_NB}" init
    "${_NB}" add "Example Folder/File One.md"    --title "Title One"
    "${_NB}" add "Example Folder/File Two.md"    --title "Title Two"
    "${_NB}" add "Example Folder/File Three.md"  --title "Title Three"
    "${_NB}" add "Example Folder/File Four.md"   --title "Title Four"

    "${_NB}" pin Example\ Folder/3

    diff                                          \
      <(printf "File Three.md\\n")                \
      <(cat "${NB_DIR}/home/Example Folder/.pindex")

    rm "${NB_DIR}/home/Example Folder/File Three.md"

    [[ ! -e "${NB_DIR}/home/Example Folder/File Three.md" ]]

    diff                                          \
      <(printf "File Three.md\\n")                \
      <(cat "${NB_DIR}/home/Example Folder/.pindex")
  }

  NB_PINNED_PATTERN="#pinned" run "${_NB}" list Example\ Folder/ --with-pinned

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                             ]]
  [[ "${#lines[@]}" -eq 3                                             ]]

  [[ "${lines[0]}"  =~  \.*[.*Example\ Folder/4.*].*\ Title\ Four     ]]
  [[ "${lines[1]}"  =~  \.*[.*Example\ Folder/2.*].*\ Title\ Two      ]]
  [[ "${lines[2]}"  =~  \.*[.*Example\ Folder/1.*].*\ Title\ One      ]]

  [[ ! -e "${NB_DIR}/home/Example Folder/.pindex"                     ]]
}

@test "'list --with-pinned' reconciles .pindex when folder is deleted." {
  {
    "${_NB}" init
    "${_NB}" add "Example Folder/File One.md"   --title "Title One"
    "${_NB}" add "Example Folder/File Two.md"   --title "Title Two"
    "${_NB}" add "Example Folder/Folder Three"  --type  folder
    "${_NB}" add "Example Folder/File Four.md"  --title "Title Four"

    "${_NB}" pin Example\ Folder/1
    "${_NB}" pin Example\ Folder/3

    diff                                          \
      <(printf "File One.md\\nFolder Three\\n")   \
      <(cat "${NB_DIR}/home/Example Folder/.pindex")

    rm -r "${NB_DIR}/home/Example Folder/Folder Three"

    [[ ! -e "${NB_DIR}/home/Example Folder/Folder Three" ]]

    diff                                          \
      <(printf "File One.md\\nFolder Three\\n")   \
      <(cat "${NB_DIR}/home/Example Folder/.pindex")
  }

  NB_PINNED_PATTERN="#pinned" run "${_NB}" list Example\ Folder/ --with-pinned

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                             ]]
  [[ "${#lines[@]}" -eq 3                                             ]]

  [[ "${lines[0]}"  =~  \.*[.*Example\ Folder/1.*].*\ 📌\ Title\ One  ]]
  [[ "${lines[1]}"  =~  \.*[.*Example\ Folder/4.*].*\ Title\ Four     ]]
  [[ "${lines[2]}"  =~  \.*[.*Example\ Folder/2.*].*\ Title\ Two      ]]

  diff                                            \
    <(printf "File One.md\\n")                    \
    <(cat "${NB_DIR}/home/Example Folder/.pindex")
}

@test "'list --with-pinned' reconciles .pindex when file is deleted." {
  {
    "${_NB}" init
    "${_NB}" add "Example Folder/File One.md"    --title "Title One"
    "${_NB}" add "Example Folder/File Two.md"    --title "Title Two"
    "${_NB}" add "Example Folder/File Three.md"  --title "Title Three"
    "${_NB}" add "Example Folder/File Four.md"   --title "Title Four"

    "${_NB}" pin Example\ Folder/1
    "${_NB}" pin Example\ Folder/3

    diff                                          \
      <(printf "File One.md\\nFile Three.md\\n")  \
      <(cat "${NB_DIR}/home/Example Folder/.pindex")

    rm "${NB_DIR}/home/Example Folder/File Three.md"

    [[ ! -e "${NB_DIR}/home/Example Folder/File Three.md" ]]

    diff                                          \
      <(printf "File One.md\\nFile Three.md\\n")  \
      <(cat "${NB_DIR}/home/Example Folder/.pindex")
  }

  NB_PINNED_PATTERN="#pinned" run "${_NB}" list Example\ Folder/ --with-pinned

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                             ]]
  [[ "${#lines[@]}" -eq 3                                             ]]

  [[ "${lines[0]}"  =~  \.*[.*Example\ Folder/1.*].*\ 📌\ Title\ One  ]]
  [[ "${lines[1]}"  =~  \.*[.*Example\ Folder/4.*].*\ Title\ Four     ]]
  [[ "${lines[2]}"  =~  \.*[.*Example\ Folder/2.*].*\ Title\ Two      ]]

  diff                                            \
    <(printf "File One.md\\n")  \
    <(cat "${NB_DIR}/home/Example Folder/.pindex")
}

@test "'list --with-pinned' prints list with items pinned." {
  {
    "${_NB}" init
    "${_NB}" add "File One.md"    --title "Title One"   --content "#pinned"
    "${_NB}" add "File Two.md"    --title "Title Two"
    "${_NB}" add "File Three.md"  --title "Title Three"
    "${_NB}" add "File Four.md"   --title "Title Four"

    "${_NB}" pin 1
    "${_NB}" pin 4

    diff                                          \
      <(printf "File One.md\\nFile Four.md\\n")   \
      <(cat "${NB_DIR}/home/.pindex")
  }

  NB_PINNED_PATTERN="#pinned" run "${_NB}" list --with-pinned

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                             ]]
  [[ "${#lines[@]}" -eq 4                             ]]

  [[ "${lines[0]}"  =~  \.*[.*1.*].*\ 📌\ Title\ One  ]]
  [[ "${lines[1]}"  =~  \.*[.*4.*].*\ 📌\ Title\ Four ]]
  [[ "${lines[2]}"  =~  \.*[.*3.*].*\ Title\ Three    ]]
  [[ "${lines[3]}"  =~  \.*[.*2.*].*\ Title\ Two      ]]
}

# `list` edge cases ###########################################################

@test "'list' ignores --ar, --archived, --unar, and --unarchived options." {
  {
    "${_NB}" init
    "${_NB}" add "File One.md"    --title "Title One"
    "${_NB}" add "File Two.md"    --title "Title Two"
    "${_NB}" add "File Three.md"  --title "Title Three"
  }

  run "${_NB}" list --ar

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0             ]]
  [[ "${#lines[@]}" -eq 3             ]]
  [[ "${lines[0]}"  =~  Title\ Three  ]]

  run "${_NB}" list --archived

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0             ]]
  [[ "${#lines[@]}" -eq 3             ]]
  [[ "${lines[0]}"  =~  Title\ Three  ]]

  run "${_NB}" list --unar

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0             ]]
  [[ "${#lines[@]}" -eq 3             ]]
  [[ "${lines[0]}"  =~  Title\ Three  ]]

  run "${_NB}" list --unarchived

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0             ]]
  [[ "${#lines[@]}" -eq 3             ]]
  [[ "${lines[0]}"  =~  Title\ Three  ]]
}

@test "'list <id> <no-match>' exits with 0 and lists matching file." {
  {
    "${_NB}" init
    "${_NB}" add "File One.md"    --title "Title One"
    "${_NB}" add "File Two.md"    --title "Title Two"
    "${_NB}" add "File Three.md"  --title "Title Three"
  }

  run "${_NB}" list not-valid 1

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0             ]]
  [[ "${lines[0]}"  =~  Title\ One    ]]

  run "${_NB}" list 2 -x

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0             ]]
  [[ "${lines[0]}"  =~  Title\ Two    ]]

  run "${_NB}" list 3 non-valid

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0             ]]
  [[ "${lines[0]}"  =~  Title\ Three  ]]
}

# `list` not found message ####################################################

@test "'list <no-match>' exits with 1 and prints message." {
  {
    "${_NB}" init
    "${_NB}" add "File One.md"    --title "Title One"
    "${_NB}" add "File Two.md"    --title "Title Two"
    "${_NB}" add "File Three.md"  --title "Title Three"
  }

  run "${_NB}" list no-match

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 1                       ]]
  [[ "${#lines[@]}" -eq 1                       ]]
  [[ "${lines[0]}"  =~  Not\ found:\ .*no-match ]]
}

@test "'list <not-valid> <no-match>' exits with 1 and prints message with both." {
  {
    "${_NB}" init
    "${_NB}" add "File One.md"    --title "Title One"
    "${_NB}" add "File Two.md"    --title "Title Two"
    "${_NB}" add "File Three.md"  --title "Title Three"
  }

  run "${_NB}" list not-valid no-match

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 1                                 ]]
  [[ "${#lines[@]}" -eq 1                                 ]]
  [[ "${lines[0]}"  =~  Not\ found:\ .*not-valid|no-match ]]
}

@test "'list <not-valid-selector> <no-match>' exits with 1 and prints message." {
  {
    "${_NB}" init
    "${_NB}" add "File One.md"    --title "Title One"
    "${_NB}" add "File Two.md"    --title "Title Two"
    "${_NB}" add "File Three.md"  --title "Title Three"
  }

  run "${_NB}" list 123:x\ y\ z/not-valid.md no-match

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"    -eq 1                                                ]]
  [[    "${#lines[@]}" -eq 1                                                ]]
  [[    "${lines[0]}"  =~  Not\ found:\ .*123:x\ y\ z/not-valid.md|no-match ]]
}

@test "'list <not-valid-selector> <match>' exits with 0 and prints match." {
  {
    "${_NB}" init
    "${_NB}" add "File One.md"    --title "Title One"
    "${_NB}" add "File Two.md"    --title "Title Two"
    "${_NB}" add "File Three.md"  --title "Title Three"
  }

  run "${_NB}" list 123:x\ y\ z/not-valid.md three

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"    -eq 0            ]]
  [[    "${#lines[@]}" -eq 1            ]]
  [[    "${lines[0]}"  =~  Title\ Three ]]
}

@test "'list <folder>/ <no-match>' (slash) exits with 1 and prints message." {
  {
    "${_NB}" init

    "${_NB}" add "Example Folder/File One.md"    --title "Title One"
    "${_NB}" add "Example Folder/File Two.md"    --title "Title Two"
    "${_NB}" add "Example Folder/File Three.md"  --title "Title Three"
  }

  run "${_NB}" list Example\ Folder/ no-match

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"    -eq 1                                              ]]
  [[    "${#lines[@]}" -eq 1                                              ]]
  [[    "${lines[0]}"  =~  Not\ found:\ .*Example\ Folder/.*\ .*no-match  ]]
}

@test "'list <folder> <no-match>' (no slash) exits with 0 and lists folder match." {
  {
    "${_NB}" init

    "${_NB}" add "Example Folder/File One.md"    --title "Title One"
    "${_NB}" add "Example Folder/File Two.md"    --title "Title Two"
    "${_NB}" add "Example Folder/File Three.md"  --title "Title Three"
  }

  run "${_NB}" list Example\ Folder no-match

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"    -eq 0                          ]]
  [[    "${#lines[@]}" -eq 1                          ]]
  [[    "${lines[0]}"  =~  1.*\ 📂\ .*Example\ Folder ]]
}

@test "'list <notebook>:<no-match>' (no space) exits with 1 and prints message." {
  {
    "${_NB}" init

    "${_NB}" add "Example Folder/File One.md"    --title "Title One"
    "${_NB}" add "Example Folder/File Two.md"    --title "Title Two"
    "${_NB}" add "Example Folder/File Three.md"  --title "Title Three"

    "${_NB}" notebooks add "one"
    "${_NB}" use "one"

    [[ "$("${_NB}" notebooks current)" == "one" ]]
  }

  run "${_NB}" list home:no-match

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"    -eq 1                                              ]]
  [[    "${#lines[@]}" -eq 1                                              ]]
  [[    "${lines[0]}"  =~  Not\ found:\ .*home:.*\ .*no-match  ]]
}

@test "'list <notebook>: <no-match>' (space) exits with 1 and prints message." {
  {
    "${_NB}" init

    "${_NB}" add "Example Folder/File One.md"    --title "Title One"
    "${_NB}" add "Example Folder/File Two.md"    --title "Title Two"
    "${_NB}" add "Example Folder/File Three.md"  --title "Title Three"

    "${_NB}" notebooks add "one"
    "${_NB}" use "one"

    [[ "$("${_NB}" notebooks current)" == "one" ]]
  }

  run "${_NB}" list home: no-match

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"    -eq 1                                              ]]
  [[    "${#lines[@]}" -eq 1                                              ]]
  [[    "${lines[0]}"  =~  Not\ found:\ .*home:.*\ .*no-match  ]]
}

@test "'list <notebook>:<not-valid-path> <match>' exits with 0 and lists match." {
  {
    "${_NB}" init

    "${_NB}" add "Root File One.md"    --title "Root Title One"
    "${_NB}" add "Root File Two.md"    --title "Root Title Two"
    "${_NB}" add "Root File Three.md"  --title "Root Title Three"

    "${_NB}" add "Example Folder/Nested File One.md"    --title "Nested Title One"
    "${_NB}" add "Example Folder/Nested File Two.md"    --title "Nested Title Two"
    "${_NB}" add "Example Folder/Nested File Three.md"  --title "Nested Title Three"

    "${_NB}" notebooks add "one"
    "${_NB}" use "one"

    [[ "$("${_NB}" notebooks current)" == "one" ]]
  }

  run "${_NB}" list home:Not Valid/not-valid.md three

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"    -eq 0                    ]]
  [[    "${#lines[@]}" -eq 1                    ]]
  [[    "${lines[0]}"  =~  Root\ Title\ Three   ]]
}

@test "'list <notebook>:<folder>/<not-valid-item> <match>' exits with 0 and lists nested match." {
  {
    "${_NB}" init

    "${_NB}" add "Root File One.md"    --title "Root Title One"
    "${_NB}" add "Root File Two.md"    --title "Root Title Two"
    "${_NB}" add "Root File Three.md"  --title "Root Title Three"

    "${_NB}" add "Example Folder/Nested File One.md"    --title "Nested Title One"
    "${_NB}" add "Example Folder/Nested File Two.md"    --title "Nested Title Two"
    "${_NB}" add "Example Folder/Nested File Three.md"  --title "Nested Title Three"

    "${_NB}" notebooks add "one"
    "${_NB}" use "one"

    [[ "$("${_NB}" notebooks current)" == "one" ]]
  }

  run "${_NB}" list home:Example\ Folder/not-valid.md three

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"    -eq 0                    ]]
  [[    "${#lines[@]}" -eq 1                    ]]
  [[    "${lines[0]}"  =~  Nested\ Title\ Three ]]
}

@test "'list <notebook>:<folder>/<no-match>' (slash, no space) exits with 1 and prints message." {
  {
    "${_NB}" init

    "${_NB}" add "Example Folder/File One.md"    --title "Title One"
    "${_NB}" add "Example Folder/File Two.md"    --title "Title Two"
    "${_NB}" add "Example Folder/File Three.md"  --title "Title Three"

    "${_NB}" notebooks add "one"
    "${_NB}" use "one"

    [[ "$("${_NB}" notebooks current)" == "one" ]]
  }

  run "${_NB}" list home:Example\ Folder/no-match

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"    -eq 1                                                    ]]
  [[    "${#lines[@]}" -eq 1                                                    ]]
  [[    "${lines[0]}"  =~  Not\ found:\ .*home:.*Example\ Folder/.*\ .*no-match ]]
}

@test "'list <notebook>:<folder>/ <no-match>' (slash, space) exits with 1 and prints message." {
  {
    "${_NB}" init

    "${_NB}" add "Example Folder/File One.md"    --title "Title One"
    "${_NB}" add "Example Folder/File Two.md"    --title "Title Two"
    "${_NB}" add "Example Folder/File Three.md"  --title "Title Three"

    "${_NB}" notebooks add "one"
    "${_NB}" use "one"

    [[ "$("${_NB}" notebooks current)" == "one" ]]
  }

  run "${_NB}" list home:Example\ Folder/ no-match

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"    -eq 1                                                    ]]
  [[    "${#lines[@]}" -eq 1                                                    ]]
  [[    "${lines[0]}"  =~  Not\ found:\ .*home:.*Example\ Folder/.*\ .*no-match ]]
}

@test "'list <notebook>:<folder> <no-match>' (no slash) exits with 0 and lists folder match." {
  {
    "${_NB}" init

    "${_NB}" add "Example Folder/File One.md"    --title "Title One"
    "${_NB}" add "Example Folder/File Two.md"    --title "Title Two"
    "${_NB}" add "Example Folder/File Three.md"  --title "Title Three"

    "${_NB}" notebooks add "one"
    "${_NB}" use "one"

    [[ "$("${_NB}" notebooks current)" == "one" ]]
  }

  run "${_NB}" list home:Example\ Folder no-match

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"    -eq 0                          ]]
  [[    "${#lines[@]}" -eq 1                          ]]
  [[    "${lines[0]}"  =~  1.*\ 📂\ .*Example\ Folder ]]
}

# `list` (empty) ##############################################################

@test "'list' (empty) exits with 0 and lists files." {
  {
    "${_NB}" init
  }

  run "${_NB}" list

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  _expected="0 items.

Add a note:
  $(_color_primary 'nb add')
Add a bookmark:
  $(_color_primary "nb <url>")
Add a todo:
  $(_color_primary "nb todo add <title>")
Import a file:
  $(_color_primary "nb import (<path> | <url>)")
Help information:
  $(_color_primary 'nb help')"

  [[ "${status}"    -eq 0           ]]
  [[ "${_expected}" ==  "${output}" ]]
}

# `list` ######################################################################

@test "'list' exits with 0 and lists files in reverse order." {
  {
    "${_NB}" init
    "${_NB}" add "one.md"   --title "one"
    "${_NB}" add "two.md"   --title "two"
    "${_NB}" add "three.md" --title "three"
  }

  run "${_NB}" list

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0     ]]

  [[ "${lines[0]}"  =~  three ]]
  [[ "${lines[1]}"  =~  two   ]]
  [[ "${lines[2]}"  =~  one   ]]
}

@test "'list' includes indicators." {
  {
    "${_NB}" init

    "${_NB}" add "one.bookmark.md"      \
      --content "<https://example.com>"

    "${_NB}" add "two.md"               \
      --content "Example Content."

    "${_NB}" add "three.md"             \
      --title "Three" --encrypt --password=example

    "${_NB}" add "four.todo.md"         \
      --content "# [ ] Example undone todo."

    "${_NB}" add "Five.todo.md"         \
      --content "# [x] Example done todo."
  }

  run "${_NB}" list

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                                     ]]

  [[ "${lines[0]}"  =~  \[.*5.*\].*\ ✅\ .*\[.*x.*\].*\ Example\ done\ todo\. ]]
  [[ "${lines[1]}"  =~  \[.*4.*\].*\ ✔️\ \ .*\[\ \].*\ Example\ undone\ todo\.  ]]
  [[ "${lines[2]}"  =~  \[.*3.*\].*\ 🔒\ three.md.enc                         ]]
  [[ "${lines[3]}"  =~  \[.*2.*\].*\ two.md                                   ]]
  [[ "${lines[4]}"  =~  \[.*1.*\].*\ 🔖\ one.bookmark.md                      ]]

  run "${_NB}" list --no-color

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                           ]]

  [[ "${lines[0]}"  =~  \[5\]\ ✅\ \[x\]\ Example\ done\ todo\.     ]]
  [[ "${lines[1]}"  =~  \[4\]\ ✔️\ \ \[\ \]\ Example\ undone\ todo\.  ]]
  [[ "${lines[2]}"  =~  \[3\]\ 🔒\ three.md.enc                     ]]
  [[ "${lines[3]}"  =~  \[2\]\ two.md                               ]]
  [[ "${lines[4]}"  =~  \[1\]\ 🔖\ one.bookmark.md                  ]]
}

@test "'list' indicators are configurable with environment variables." {
  {
    "${_NB}" init
    "${_NB}" add "one.bookmark.md" --content "<https://example.com>"
    "${_NB}" add "two.md" --content "Example Content."
    "${_NB}" add "three.md" --title "Three" --encrypt --password=example
  }

  NB_INDICATOR_ENCRYPTED=🔐 NB_INDICATOR_BOOKMARK=🏷 run "${_NB}" list

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                 ]]

  [[ "${lines[0]}"  =~  \[.*3.*\].*\ 🔐\ three.md.enc     ]]
  [[ "${lines[1]}"  =~  \[.*2.*\].*\ two.md               ]]
  [[ "${lines[2]}"  =~  \[.*1.*\].*\ 🏷\ one.bookmark.md  ]]

  NB_INDICATOR_ENCRYPTED=🔐 NB_INDICATOR_BOOKMARK=🏷 run "${_NB}" list --no-color

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                 ]]

  [[ "${lines[0]}"  =~  \[3\]\ 🔐\ three.md.enc           ]]
  [[ "${lines[1]}"  =~  \[2\]\ two.md                     ]]
  [[ "${lines[2]}"  =~  \[1\]\ 🏷\ one.bookmark.md        ]]
}

@test "'list' indicator padding is hidden when indicator icons are set to blank." {
  {
    "${_NB}" init
    "${_NB}" add "one.bookmark.md" --content "<https://example.com>"
    "${_NB}" add "two.md" --content "Example Content."
    "${_NB}" add "three.md" --title "Three" --encrypt --password=example
  }

  NB_INDICATOR_ENCRYPTED="" NB_INDICATOR_BOOKMARK="" run "${_NB}" list

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                 ]]

  [[ "${lines[0]}"  =~  \[.*3.*\].*\ three.md.enc         ]]
  [[ "${lines[1]}"  =~  \[.*2.*\].*\ two.md               ]]
  [[ "${lines[2]}"  =~  \[.*1.*\].*\ one.bookmark.md      ]]

  NB_INDICATOR_ENCRYPTED="" NB_INDICATOR_BOOKMARK="" run "${_NB}" list --no-color

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0                                 ]]

  [[ "${lines[0]}"  =~  \[3\]\ three.md.enc               ]]
  [[ "${lines[1]}"  =~  \[2\]\ two.md                     ]]
  [[ "${lines[2]}"  =~  \[1\]\ one.bookmark.md            ]]
}

@test "'list' includes ids." {
  {
    "${_NB}" init
    "${_NB}" add "one.md"   --title "one"
    "${_NB}" add "two.md"   --title "two"
    "${_NB}" add "three.md" --title "three"
    "${_NB}" add "four.md"  --title "four"
    "${_NB}" add "five.md"  --title "five"

    "${_NB}" delete "one.md"  --force
    "${_NB}" delete "four.md" --force
  }

  run "${_NB}" list

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"     -eq 0     ]]

  [[    "${lines[0]}"   =~ five   ]]
  [[    "${lines[0]}"   =~ 5      ]]
  [[    "${lines[1]}"   =~ three  ]]
  [[    "${lines[1]}"   =~ 3      ]]
  [[    "${lines[2]}"   =~ two    ]]
  [[    "${lines[2]}"   =~ 2      ]]
  [[ -z "${lines[3]:-}"           ]]
}

# `list --no-id` ##############################################################

@test "'list --no-id' exits with 0 and lists files in reverse order." {
  {
    "${_NB}" init
    "${_NB}" add "one.md"   --title "one"
    "${_NB}" add "two.md"   --title "two"
    "${_NB}" add "three.md" --title "three"
  }

  run "${_NB}" list --no-id

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0     ]]

  [[ "${lines[0]}"  =~  three ]]
  [[ "${lines[1]}"  =~  two   ]]
  [[ "${lines[2]}"  =~  one   ]]
}

# `list --no-color` ###########################################################

@test "'list --no-color' exits with 0 and lists files in reverse order." {
  {
    "${_NB}" init
    "${_NB}" add "one.md"   --title "one"
    "${_NB}" add "two.md"   --title "two"
    "${_NB}" add "three.md" --title "three"
  }

  run "${_NB}" list --no-color

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0     ]]
  [[ "${lines[0]}"  =~  three ]]
  [[ "${lines[1]}"  =~  two   ]]
  [[ "${lines[2]}"  =~  one   ]]
}

# `list (-e | --excerpt)` #####################################################

_setup_list_excerpt() {
  "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "one.md"
# one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "two.md"
# two
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "three.md"
# three
line two
line three
line four
HEREDOC
}

@test "'list -e' with todos prints line matching visible listing length." {
  {
    "${_NB}" init

    "${_NB}" todos add "Example todo one."
    "${_NB}" todos add "Example todo two."

    "${_NB}" "do" 2
  }

  run "${_NB}" list -e

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"
  printf "\${lines[2]}:   '%s'\\n" "${lines[2]}"

  [[ "${status}"    -eq 0 ]]
  [[ "${#lines[@]}" -eq 6 ]]

  [[ "${lines[0]}"  =~  \
.*[.*2.*].*\ ✅\ .*[.*x.*].*\ Example\ todo\ two\.  ]]
  [[ "${lines[1]}"  =~  \
[^-]----------------------------[^-]                ]]


  [[ "${lines[3]}"  =~  \
.*[.*1.*].*\ ✔️\ \ .*[\ ].*\ Example\ todo\ one\.    ]]
  [[ "${lines[4]}"  =~  \
[^-]----------------------------[^-]                ]]
}

@test "'list -e' exits with 0 and displays 5 line list items." {
  {
    _setup_list_excerpt
  }

  run "${_NB}" list -e

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0   ]]
  [[ "${#lines[@]}" -eq 15  ]]
}

@test "'list -e 2' exits with 0 and displays 4 line list items." {
  {
    _setup_list_excerpt
  }

  run "${_NB}" list -e 2

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0   ]]
  [[ "${#lines[@]}" -eq 12  ]]
}

@test "'list -e 0' exits with 0 and displays 1 line list items." {
  {
    _setup_list_excerpt
  }

  run "${_NB}" list -e 0

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0                   ]]
  [[ "${#lines[@]}" -eq 6                   ]]
  [[ "${lines[0]}"  =~  .*[.*3.*].*\ three  ]]
  [[ "${lines[1]}"  =~   [^-]---------[^-]  ]]
  [[ "${lines[2]}"  =~  .*[.*2.*].*\ two    ]]
  [[ "${lines[3]}"  =~   [^-]-------[^-]    ]]
  [[ "${lines[4]}"  =~  .*[.*1.*].*\ one    ]]
  [[ "${lines[5]}"  =~   [^-]-------[^-]    ]]
}

@test "'list --excerpt' exits with 0 and displays 5 line list items." {
  {
    _setup_list_excerpt
  }

  run "${_NB}" list --excerpt

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0   ]]
  [[ "${#lines[@]}" -eq 15  ]]
}

@test "'list --excerpt 2' exits with 0 and displays 4 line list items." {
  {
    _setup_list_excerpt
  }

  run "${_NB}" list --excerpt 2

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0   ]]
  [[ "${#lines[@]}" -eq 12  ]]
}

@test "'list --excerpt 0' exits with 0 and displays list item with line." {
  {
    _setup_list_excerpt
  }

  run "${_NB}" list --excerpt 0

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0                   ]]
  [[ "${#lines[@]}" -eq 6                   ]]
  [[ "${lines[0]}"  =~  .*[.*3.*].*\ three  ]]
  [[ "${lines[1]}"  =~   [^-]---------[^-]  ]]
  [[ "${lines[2]}"  =~  .*[.*2.*].*\ two    ]]
  [[ "${lines[3]}"  =~   [^-]-------[^-]    ]]
  [[ "${lines[4]}"  =~  .*[.*1.*].*\ one    ]]
  [[ "${lines[5]}"  =~   [^-]-------[^-]    ]]
}

# `list -n <limit>` ###########################################################

_setup_list_limit() {
  "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "one.md"
# one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "two.md"
# two
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "three.md"
# three
line two
line three
line four
HEREDOC
}

@test "'list -n' exits with 0 and displays full list." {
  {
    _setup_list_limit
  }

  run "${_NB}" list -n

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0 ]]
  [[ "${#lines[@]}" -eq 3 ]]
}

@test "'list -n 2' exits with 0 and displays list with 2 items." {
  {
    _setup_list_limit
  }

  run "${_NB}" list -n 2

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0                         ]]
  [[ "${#lines[@]}" -eq 3                         ]]
  [[ "${lines[2]}"  =~  1\ omitted\.\ 3\ total\.  ]]
}

@test "'list --limit 2' exits with 0 and displays list with 2 items." {
  {
    _setup_list_limit
  }

  run "${_NB}" list --limit 2

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0                         ]]
  [[ "${#lines[@]}" -eq 3                         ]]
  [[ "${lines[2]}"  =~  1\ omitted\.\ 3\ total\.  ]]
}

@test "'list -<limit>' exits with 0 and displays list with 2 items." {
  {
    _setup_list_limit
  }

  run "${_NB}" list -2

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0                         ]]
  [[ "${#lines[@]}" -eq 3                         ]]
  [[ "${lines[2]}"  =~  1\ omitted\.\ 3\ total\.  ]]
}

@test "'list -<limit>' exits with 0 and displays list with 11 items." {
  {
    "${_NB}" init

    declare _numbers=(
      One Two Three Four Five Six Seven Eight Nine Ten
      Eleven Twelve Thirteen Fourteen Fifteen Sixteen
      Seventeen Eighteen Nineteen Twenty
    )

    declare __number=
    for   __number in "${_numbers[@]}"
    do
      "${_NB}" add "File ${__number}.md" --title "Title ${__number}"
    done
  }

  run "${_NB}" list -13

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0                               ]]
  [[ "${#lines[@]}" -eq 14                              ]]
  [[ "${lines[12]}"  =~  .*\[.*8.*\].*\ \ Title\ Eight  ]]
  [[ "${lines[13]}"  =~  7\ omitted\.\ 20\ total\.      ]]
}

@test "'list --<limit>' exits with 0 and displays list with 2 items." {
  {
    _setup_list_limit
  }

  run "${_NB}" list --2

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0                         ]]
  [[ "${#lines[@]}" -eq 3                         ]]
  [[ "${lines[2]}"  =~  1\ omitted\.\ 3\ total\.  ]]
}

@test "'list <query> --limit <limit>' exits with 0 and includes message when matches are greater than limit." {
  {
    "${_NB}" init
      cat <<HEREDOC | "${_NB}" add "one.md"
# Example One
line two
line three
line four
HEREDOC
      cat <<HEREDOC | "${_NB}" add "two.md"
# Example Two
line two
line three
line four
HEREDOC
      cat <<HEREDOC | "${_NB}" add "three.md"
# Example Three
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list example --limit 2

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[    "${status}"     -eq 0                               ]]

  [[    "${#lines[@]}"  -eq 3                               ]]
  [[    "${lines[0]}"   =~  3.*Example\ Three               ]]
  [[    "${lines[1]}"   =~  2.*Example\ Two                 ]]
  [[    "${lines[2]}"   =~  1\ match\ omitted\.\ 3\ total\. ]]
  [[ !  "${output}"     =~  1.*Example\ Two                 ]]
}

@test "'list <query> --limit <limit>' exits with 0 and does not include message when matches are below limit." {
  {
    "${_NB}" init
      cat <<HEREDOC | "${_NB}" add "one.md"
# Example One
line two
line three
line four
HEREDOC
      cat <<HEREDOC | "${_NB}" add "two.md"
# Example Two
line two
line three
line four
HEREDOC
      cat <<HEREDOC | "${_NB}" add "three.md"
# Example Three
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list example --limit 10

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[    "${status}"     -eq 0                 ]]

  [[    "${#lines[@]}"  -eq 3                 ]]
  [[    "${lines[0]}"   =~  3.*Example\ Three ]]
  [[    "${lines[1]}"   =~  2.*Example\ Two   ]]
  [[    "${lines[2]}"   =~  1.*Example\ One   ]]
  [[ !  "${output}"     =~  omitted           ]]
}

@test "'list <query> --limit <limit>' exits with 0 and does not include message when matching one." {
  {
    "${_NB}" init
      for __number in One Two Three Four Five Six Seven Eight Nine Ten Eleven
      do
        "${_NB}" add                          \
          --filename  "File ${__number}.md"   \
          --title     "Example ${__number}"   \
          --content   "Content ${__number}."
      done
  }

  run "${_NB}" list two --limit 10

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[    "${status}"     -eq 0                 ]]

  [[    "${#lines[@]}"  -eq 1                 ]]
  [[    "${lines[0]}"   =~  2.*Example\ Two   ]]

  [[ !  "${output}"     =~  3.*Example\ Three ]]
  [[ !  "${output}"     =~  1.*Example\ One   ]]
  [[ !  "${output}"     =~  omitted           ]]
}

@test "'list <id> --limit <limit>' exits with 0 and does not include message when matching one." {
  {
    "${_NB}" init
      for __number in One Two Three Four Five Six Seven Eight Nine Ten Eleven
      do
        "${_NB}" add                          \
          --filename  "File ${__number}.md"   \
          --title     "Example ${__number}"   \
          --content   "Content ${__number}."
      done
  }

  run "${_NB}" list 2 --limit 10

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[    "${status}"     -eq 0                 ]]

  [[    "${#lines[@]}"  -eq 1                 ]]
  [[    "${lines[0]}"   =~  2.*Example\ Two   ]]

  [[ !  "${output}"     =~  3.*Example\ Three ]]
  [[ !  "${output}"     =~  1.*Example\ One   ]]
  [[ !  "${output}"     =~  omitted           ]]
}

# `list --titles` #############################################################

@test "'list --titles' exits with 0 and displays a list of titles." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "first.md"
# one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "second.md"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "third.md"
# three
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list --titles

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"
  printf "\${lines[0]}:   '%s'\\n" "${lines[0]}"
  printf "\${lines[1]}:   '%s'\\n" "${lines[1]}"
  printf "\${lines[2]}:   '%s'\\n" "${lines[2]}"

  [[ "${status}"    -eq 0             ]]

  [[ "${lines[0]}"  =~  3.*three      ]]
  [[ "${lines[1]}"  =~  3.*second.md  ]]
  [[ "${lines[2]}"  =~  3.*one        ]]
}

# `list --filenames` ##########################################################

@test "'list --filenames' exits with 0 and displays a list of filenames." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "first.md"
# one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "second.md"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "third.md"
# three
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list --filenames

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0           ]]

  [[ "${lines[0]}"  =~  3*third.md  ]]
  [[ "${lines[1]}"  =~  2*second.md ]]
  [[ "${lines[2]}"  =~  1*first.md  ]]
}

# `list --paths` ##############################################################

@test "'list --paths' exits with 0 and displays a list of paths." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "first.md"
# one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "second.md"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "third.md"
# three
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list --paths

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"
  printf "\${NB_DIR}:     '%s'\\n" "${NB_DIR}"

  [[ "${status}"    -eq 0                           ]]

  [[ "${lines[0]}"  =~  3*${NB_DIR}/home/third.md   ]]
  [[ "${lines[1]}"  =~  2*${NB_DIR}/home/second.md  ]]
  [[ "${lines[2]}"  =~  1*${NB_DIR}/home/first.md   ]]
}

# `ls -s` / `ls --sort` / `ls -r` / `ls --reverse` ############################

@test "'list --sort' sorts items." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "first-home.md"
# title one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "second-home.md"
# title two
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "third-example.md"
# title three
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list --sort

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0             ]]

  [[ "${#lines[@]}" -eq 3             ]]
  [[ "${lines[0]}"  =~  title\ one    ]]
  [[ "${lines[0]}"  =~  [*1*]         ]]
  [[ "${lines[1]}"  =~  title\ two    ]]
  [[ "${lines[1]}"  =~  [*2*]         ]]
  [[ "${lines[2]}"  =~  title\ three  ]]
  [[ "${lines[2]}"  =~  [*3*]         ]]
}

@test "'list --sort --reverse' reverse sorts items." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "first-home.md"
# title one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "second-home.md"
# title two
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "third-example.md"
# title three
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list --sort --reverse

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0             ]]

  [[ "${#lines[@]}" -eq 3             ]]
  [[ "${lines[0]}"  =~  title\ three  ]]
  [[ "${lines[0]}"  =~  [*3*]         ]]
  [[ "${lines[1]}"  =~  title\ two    ]]
  [[ "${lines[1]}"  =~  [*2*]         ]]
  [[ "${lines[2]}"  =~  title\ one    ]]
  [[ "${lines[2]}"  =~  [*1*]         ]]

}

@test "'list --sort' is not affected by NB_LIMIT." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "first-home.md"
# title one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "second-home.md"
# title two
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "third-example.md"
# title three
line two
line three
line four
HEREDOC

    "${_NB}" set limit 2
  }

  run "${_NB}" list --sort

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"
  printf "\${#lines[@]}: '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0             ]]

  [[ "${#lines[@]}" -eq 3             ]]
  [[ "${lines[0]}"  =~  title\ one    ]]
  [[ "${lines[0]}"  =~  [*1*]         ]]
  [[ "${lines[1]}"  =~  title\ two    ]]
  [[ "${lines[1]}"  =~  [*2*]         ]]
  [[ "${lines[2]}"  =~  title\ three  ]]
  [[ "${lines[2]}"  =~  [*3*]         ]]
}

# `list --bookmarks` ##########################################################

@test "'list --bookmarks' exits with 0 and displays a list of bookmarks." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "first.md"
# one
line two
line three
line four
HEREDOC
    "${_NB}" add "second.bookmark.md" -c "<${_BOOKMARK_URL}>"
    cat <<HEREDOC | "${_NB}" add "third.md"
line one
line two
line three
line four
HEREDOC
    "${_NB}" add "fourth.bookmark.md" -c "<${_BOOKMARK_URL}>"
    cat <<HEREDOC | "${_NB}" add "fifth.md"
# fifth
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list --bookmarks

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0                         ]]
  [[ "${lines[0]}"  =~  [*4*]*fourth.bookmark.md  ]]
  [[ "${lines[1]}"  =~  [*2*]*second.bookmark.md  ]]
}

# `list --type` ###############################################################

@test "'list --type todo' without todos prints message." {
  {
    "${_NB}" init

    "${_NB}" add "Example File One.md" --content "Example content one."
    "${_NB}" add "Example File Two.md" --content "Example content two."
  }

  run "${_NB}" list --type todo

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  _expected="0 todos.

Add a todo:
  $(_color_primary 'nb todo add <title>')
Help information:
  $(_color_primary 'nb help todo')"

  [[ "${status}"    -eq 0           ]]
  [[ "${_expected}" ==  "${output}" ]]
}

@test "'list --type todo' with container without todos prints message." {
  {
    "${_NB}" init

    "${_NB}" notebooks add "Example Notebook"

    "${_NB}" add folder "Example Notebook:Example Folder"
  }

  run "${_NB}" list Example\ Notebook:Example\ Folder/ --type todo

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  _expected="0 todos.

Add a todo:
  $(_color_primary 'nb todo add Example\ Notebook:1/ <title>')
Help information:
  $(_color_primary 'nb help todo')"

  [[ "${status}"    -eq 0           ]]
  [[ "${_expected}" ==  "${output}" ]]
}

@test "'list --type todo' with todos lists todos." {
  {
    "${_NB}" init

    "${_NB}" add "Example File One.md" --content "Example content one."
    "${_NB}" add "Example File Two.md" --content "Example content two."

    "${_NB}" add "Example Todo One.todo.md" --content "# [ ] Example not done todo."
    "${_NB}" add "Example Todo Two.todo.md" --content "# [x] Example done todo."
  }

  run "${_NB}" list --type todo

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[   "${status}"    -eq 0                                 ]]
  [[   "${lines[0]}"  =~  \
.*\[.*4.*\].*\ ✅\ .*\[.*x.*\].*\ Example\ done\ todo\.     ]]
  [[   "${lines[1]}"  =~  \
.*\[.*3.*\].*\ ✔️\ \ .*\[\ \].*\ Example\ not\ done\ todo\.  ]]

  [[ ! "${lines[0]}"  =~  \ \[x\]\                          ]]
  [[ ! "${lines[1]}"  =~  \ \[\ \]\                         ]]
}

@test "'list --document' exits with 0 and displays a list of documents." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "first.md"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "second.doc"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "third.md"
line one
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list --document

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0           ]]

  [[ "${#lines[@]}" ==  1           ]]
  [[ "${lines[0]}"  =~  second.doc  ]]
  [[ "${lines[0]}"  =~  2           ]]
}

@test "'list --documents' exits with 0 and displays a list of documents." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "first.md"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "second.doc"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "third.md"
line one
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list --documents

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0           ]]
  [[ "${#lines[@]}" ==  1           ]]
  [[ "${lines[0]}"  =~  second.doc  ]]
  [[ "${lines[0]}"  =~  2           ]]
}

@test "'list --document' exits with 0 and displays empty list." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "first.md"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "second.md"
line one
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list --document

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0                     ]]
  [[ "${#lines[@]}" ==  5                     ]]
  [[ "${lines[0]}"  =~  0\ document\ items\.  ]]
}


@test "'list --documents' exits with 0 and displays empty list." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "first.md"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "second.md"
line one
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list --documents

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0                     ]]
  [[ "${#lines[@]}" ==  5                     ]]
  [[ "${lines[0]}"  =~  0\ document\ items\.  ]]
}

@test "'list --js' exits with 0, displays empty list, and retains trailing 's'." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "first.md"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "second.md"
line one
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list --js

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0               ]]
  [[ "${#lines[@]}" ==  5               ]]
  [[ "${lines[0]}"  =~  0\ js\ items\.  ]]
}

@test "'list <selector> --type' filters by type." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "example.md"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "sample.doc"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "example.doc"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "sample.md"
line one
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list example --document

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0           ]]

  [[ "${#lines[@]}" ==  1           ]]
  [[ "${lines[0]}"  =~  example.doc ]]
  [[ "${lines[0]}"  =~  3           ]]
}

@test "'list <selector> --<invalid>' prints message." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "example.md"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "sample.doc"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "example.doc"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "sample.md"
line one
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list example --not-valid

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 1           ]]

  [[ "${#lines[@]}" ==  1           ]]
  [[ "${lines[0]}"  =~  Not\ found  ]]
  [[ "${lines[0]}"  =~  example     ]]
  [[ "${lines[0]}"  =~  Type        ]]
  [[ "${lines[0]}"  =~  not-valid   ]]
}

@test "'list <selector> --documents' with no matches prints message." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "example.md"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "sample.doc"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "example.doc"
line one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "sample.md"
line one
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list matchless-query --document

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 1               ]]

  [[ "${#lines[@]}" ==  1               ]]
  [[ "${lines[0]}"  =~  Not\ found      ]]
  [[ "${lines[0]}"  =~  matchless-query ]]
  [[ "${lines[0]}"  =~  Type            ]]
  [[ "${lines[0]}"  =~  document        ]]
}

# `list <selector>` ###########################################################

@test "'list <selector>' exits with 0 and displays the selector." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add "first.md"
# one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "second.md"
# two
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add "third.md"
# three
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list 1 --filenames

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0             ]]

  [[ "${#lines[@]}" -eq 1             ]]
  [[ "${lines[0]}"  =~  first.md      ]]
  [[ "${lines[0]}"  =~  [*1*]         ]]
}

@test "'list <query selector>' exits with 0 and displays the selectors." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add 'first.md'
# one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'second.md'
# two
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'third.md'
# three
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list 'r' --filenames

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0         ]]

  [[ "${#lines[@]}" -eq 2        ]]
  [[ "${lines[0]}"  =~  third.md ]]
  [[ "${lines[0]}"  =~  [*3*]    ]]
  [[ "${lines[1]}"  =~  first.md ]]
  [[ "${lines[1]}"  =~  [*1*]    ]]
}

@test "'list <query selector> --limit' exits with 0 and displays results and singular omitted message." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add 'first.md'
# one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'second.md'
# two
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'third.md'
# three
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list 'r' --filenames --limit 1

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0                               ]]

  [[ "${#lines[@]}" -eq 2                               ]]
  [[ "${lines[0]}"  =~  third.md                        ]]
  [[ "${lines[0]}"  =~  [*3*]                           ]]
  [[ "${lines[1]}"  =~  1\ match\ omitted\.\ 2\ total\. ]]
}

@test "'list <query selector> --limit' exits with 0 and displays results and plural omitted message." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add 'first.md'
# one
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'second.md'
# two
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'third.md'
# three
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'fourth.md'
# four
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list 'r' --filenames --limit 1

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0                                 ]]

  [[ "${#lines[@]}" -eq 2                                 ]]
  [[ "${lines[0]}"  =~  fourth.md                         ]]
  [[ "${lines[0]}"  =~  [*4*]                             ]]
  [[ "${lines[1]}"  =~  2\ matches\ omitted\.\ 3\ total\. ]]
}

@test "'list <multi-word selector>' successfully filters list." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add 'first.md'
# example plum
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'second.md'
# example pluot
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'third.md'
# sample pear
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'fourth.md'
# sample plum
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list 'example plum' --filenames

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0         ]]

  [[ "${#lines[@]}" -eq 1         ]]
  [[ "${lines[0]}"  =~  first.md  ]]
  [[ "${lines[0]}"  =~  [*1*]     ]]
}

@test "'list <multiple> <selectors>' successfully filters list." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add 'first.md'
# example plum
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'second.md'
# example pluot
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'third.md'
# sample pear
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'fourth.md'
# sample plum
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list example plum --filenames

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0         ]]

  [[ "${#lines[@]}" -eq 3         ]]
  [[ "${lines[0]}"  =~  fourth.md ]]
  [[ "${lines[0]}"  =~  [*4*]     ]]
  [[ "${lines[1]}"  =~  second.md ]]
  [[ "${lines[1]}"  =~  [*2*]     ]]
  [[ "${lines[2]}"  =~  first.md  ]]
  [[ "${lines[2]}"  =~  [*1*]     ]]
}

@test "'list <multiple> <selectors>' with exact match also includes filtered results." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add 'first.md'
# plum
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'second.md'
# example pluot
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'third.md'
# sample pear
line two
line three
line four
HEREDOC
    cat <<HEREDOC | "${_NB}" add 'fourth.md'
# example apple
line two
line three
line four
HEREDOC
  }

  run "${_NB}" list plum example --filenames

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0         ]]

  [[ "${#lines[@]}" -eq 3         ]]
  [[ "${lines[0]}"  =~  fourth.md ]]
  [[ "${lines[0]}"  =~  [*4*]     ]]
  [[ "${lines[1]}"  =~  second.md ]]
  [[ "${lines[1]}"  =~  [*2*]     ]]
  [[ "${lines[2]}"  =~  first.md  ]]
  [[ "${lines[2]}"  =~  [*1*]     ]]
}

@test "'list <invalid-selector>' exits with 1 and displays a message." {
  {
    "${_NB}" init
    cat <<HEREDOC | "${_NB}" add
# one
line two
line three
line four
HEREDOC
    sleep 1
  }

  run "${_NB}" list invalid

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 1             ]]

  [[ "${#lines[@]}" -eq 1             ]]
  [[ "${lines[0]}"  =~  Not\ found\:  ]]
  [[ "${lines[0]}"  =~  invalid       ]]
}

# `scoped:list` ###############################################################

@test "'scoped:list' exits with 0 and lists files in reverse order." {
  {
    "${_NB}" init

    "${_NB}" notebooks add "one"

    "${_NB}" one:add "one.md"   --title "one"
    "${_NB}" one:add "two.md"   --title "two"
    "${_NB}" one:add "three.md" --title "three"
  }

  run "${_NB}" one:list

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0       ]]

  [[ "${lines[0]}"  =~  one:3   ]]
  [[ "${lines[0]}"  =~  three   ]]
  [[ "${lines[1]}"  =~  one:2   ]]
  [[ "${lines[1]}"  =~  two     ]]
  [[ "${lines[2]}"  =~  one:1   ]]
  [[ "${lines[2]}"  =~  one     ]]
}

@test "'scoped:list' with empty notebook prints help info." {
  {
    "${_NB}" init
    "${_NB}" notebooks add "one"
  }

  run "${_NB}" one:list

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  _expected="0 items.

Add a note:
  $(_color_primary 'nb add one:')
Add a bookmark:
  $(_color_primary 'nb one: <url>')
Add a todo:
  $(_color_primary 'nb todo add one: <title>')
Import a file:
  $(_color_primary 'nb import (<path> | <url>) one:')
Help information:
  $(_color_primary 'nb help')"

  [[ "${status}"    -eq 0           ]]
  [[ "${_expected}" ==  "${output}" ]]
}

@test "'scoped:list' escapes multi-word notebook name." {
  {
    "${_NB}" init
    "${_NB}" notebooks add "multi word"
  }

  run "${_NB}" multi\ word:list

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  _expected="0 items.

Add a note:
  $(_color_primary 'nb add multi\ word:')
Add a bookmark:
  $(_color_primary 'nb multi\ word: <url>')
Add a todo:
  $(_color_primary 'nb todo add multi\ word: <title>')
Import a file:
  $(_color_primary 'nb import (<path> | <url>) multi\ word:')
Help information:
  $(_color_primary 'nb help')"

  [[ "${status}"    -eq 0           ]]
  [[ "${_expected}" ==  "${output}" ]]
}

@test "'scoped:list --bookmarks' with empty notebook prints help info." {
  {
    "${_NB}" init
    "${_NB}" notebooks add "one"
  }

  run "${_NB}" one:list --bookmarks

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  _expected="0 bookmarks.

Add a bookmark:
  $(_color_primary 'nb one: <url>')
Help information:
  $(_color_primary 'nb help bookmark')"

  [[ "${status}"    -eq 0           ]]
  [[ "${_expected}" ==  "${output}" ]]
}

@test "'scoped:list --documents' with empty notebook prints help info." {
  {
    "${_NB}" init
    "${_NB}" notebooks add "one"
  }

  run "${_NB}" one:list --documents

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  _expected="0 document items.

Import a file:
  $(_color_primary 'nb import (<path> | <url>) one:')
Help information:
  $(_color_primary 'nb help import')"

  [[ "${status}"    -eq 0           ]]
  [[ "${_expected}" ==  "${output}" ]]
}

# `list --error-on-empty` #####################################################

@test "'list --error-on-empty' with empty notebook returns 1." {
  {
    "${_NB}" init
    "${_NB}" notebooks add "one"
  }

  run "${_NB}" one:list

  [[ "${status}" -eq 0 ]]

  run "${_NB}" one:list --error-on-empty

  [[ "${status}" -eq 1 ]]

  "${_NB}" one:add "one.md" --title "one"

  run "${_NB}" one:list --error-on-empty

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}" -eq 0 ]]
}

# `list <notebook>` ###########################################################

@test "'list <notebook>' (no colon) exits with 1 and prints not found." {
  {
    "${_NB}" init

    "${_NB}" notebooks add "example"

    "${_NB}" example:add "one.md"   --title "one"
    "${_NB}" example:add "two.md"   --title "two"
    "${_NB}" example:add "three.md" --title "three"

    [[ "$("${_NB}" notebooks current)" == "home" ]]
  }

  run "${_NB}" list example

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 1           ]]
  [[ "${lines[0]}"  =~  Not\ found  ]]
  [[ "${lines[0]}"  =~  example     ]]
}

@test "'list <notebook>:' (colon) exits with 0 and lists files in <notebook> in reverse order." {
  {
    "${_NB}" init

    "${_NB}" notebooks add "example"

    "${_NB}" example:add "one.md"   --title "one"
    "${_NB}" example:add "two.md"   --title "two"
    "${_NB}" example:add "three.md" --title "three"
  }

  run "${_NB}" list example:

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${status}"    -eq 0         ]]
  [[ "${lines[0]}"  =~  example:3 ]]
  [[ "${lines[0]}"  =~  three     ]]
  [[ "${lines[1]}"  =~  example:2 ]]
  [[ "${lines[1]}"  =~  two       ]]
  [[ "${lines[2]}"  =~  example:1 ]]
  [[ "${lines[2]}"  =~  one       ]]
}

# help ########################################################################

@test "'help list' exits with status 0." {
  run "${_NB}" help list

  [[ "${status}" -eq 0 ]]
}

@test "'help list' prints help information." {
  run "${_NB}" help list

  printf "\${status}:     '%s'\\n" "${status}"
  printf "\${output}:     '%s'\\n" "${output}"
  printf "\${#lines[@]}:  '%s'\\n" "${#lines[@]}"

  [[ "${lines[0]}" =~ Usage.*\: ]]
  [[ "${lines[1]}" =~ nb\ list  ]]
}

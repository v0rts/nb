#!/usr/bin/env bats

load test_helper

# --and / --or ################################################################

@test "'browse --container -q \#tag2 --or \#tag3' performs OR search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    \
      --title "Title One"         \
      --content "Content one."

    "${_NB}" add "File Two.md"    \
      --title "Title Two"         \
      --content "Content #tag1 two."

    "${_NB}" add "File Three.md"  \
      --title "Title Three"       \
      --content "Content #tag2 three."

    "${_NB}" add "File Four.md"   \
      --title "Title Four"        \
      --content "Content #tag1 four."

    "${_NB}" add "File Five.md"   \
      --title "Title Five"        \
      --content "Content #tag2 #tag3 five."
  }

  run "${_NB}" browse --container -q \#tag2 --or \#tag3

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0               ]]

  [[ !  "${output}"   =~ Title${_S}One    ]]
  [[ !  "${output}"   =~ Title${_S}Four   ]]

  [[    "${output}"   =~  \
\<a.*\ href=\"//localhost:6789/home:5\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>    ]]
  [[    "${output}"   =~   \
class=\"list-item\"\>\<span\ class=\"muted\"\>\[\</span\>\<span\ class=\"identifier\"\>     ]]
  [[    "${output}"   =~   \
identifier\"\>home:5\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Five\</a\>\<br\>  ]]

  [[    "${output}"   =~   \
identifier\"\>home:3\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Three\</a\>\<br\> ]]
}

@test "'browse --container -q \#tag2 --and \#tag3' performs AND search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    \
      --title "Title One"         \
      --content "Content one."

    "${_NB}" add "File Two.md"    \
      --title "Title Two"         \
      --content "Content #tag1 two."

    "${_NB}" add "File Three.md"  \
      --title "Title Three"       \
      --content "Content #tag2 three."

    "${_NB}" add "File Four.md"   \
      --title "Title Four"        \
      --content "Content #tag1 four."

    "${_NB}" add "File Five.md"   \
      --title "Title Five"        \
      --content "Content #tag2 #tag3 five."
  }

  run "${_NB}" browse --container -q \#tag2 --and \#tag3

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0               ]]

  [[ !  "${output}"   =~ Title${_S}One    ]]
  [[ !  "${output}"   =~ Title${_S}Three  ]]
  [[ !  "${output}"   =~ Title${_S}Four   ]]

  [[    "${output}"   =~  \
\<a.*\ href=\"//localhost:6789/home:5\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>    ]]
  [[    "${output}"   =~   \
class=\"list-item\"\>\<span\ class=\"muted\"\>\[\</span\>\<span\ class=\"identifier\"\>     ]]
  [[    "${output}"   =~   \
identifier\"\>home:5\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Five\</a\>\<br\>  ]]
}

# -t / --tag / --tags #########################################################

@test "'browse --container -t tag2 --and -t tag3' performs AND search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    \
      --title "Title One"         \
      --content "Content one."

    "${_NB}" add "File Two.md"    \
      --title "Title Two"         \
      --content "Content #tag1 two."

    "${_NB}" add "File Three.md"  \
      --title "Title Three"       \
      --content "Content #tag2 three."

    "${_NB}" add "File Four.md"   \
      --title "Title Four"        \
      --content "Content #tag1 four."

    "${_NB}" add "File Five.md"   \
      --title "Title Five"        \
      --content "Content #tag2 #tag3 five."
  }

  run "${_NB}" browse --container -t tag2 --and -t tag3

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0               ]]

  [[ !  "${output}"   =~ Title${_S}One    ]]
  [[ !  "${output}"   =~ Title${_S}Three  ]]
  [[ !  "${output}"   =~ Title${_S}Four   ]]

  [[    "${output}"   =~  \
\<a.*\ href=\"//localhost:6789/home:5\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>    ]]
  [[    "${output}"   =~   \
class=\"list-item\"\>\<span\ class=\"muted\"\>\[\</span\>\<span\ class=\"identifier\"\>     ]]
  [[    "${output}"   =~   \
identifier\"\>home:5\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Five\</a\>\<br\>  ]]
}

@test "'browse --container -t tag2,tag3' performs AND search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    \
      --title "Title One"         \
      --content "Content one."

    "${_NB}" add "File Two.md"    \
      --title "Title Two"         \
      --content "Content #tag1 two."

    "${_NB}" add "File Three.md"  \
      --title "Title Three"       \
      --content "Content #tag2 three."

    "${_NB}" add "File Four.md"   \
      --title "Title Four"        \
      --content "Content #tag1 four."

    "${_NB}" add "File Five.md"   \
      --title "Title Five"        \
      --content "Content #tag2 #tag3 five."
  }

  run "${_NB}" browse --container -t tag2,tag3

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0               ]]

  [[ !  "${output}"   =~ Title${_S}One    ]]
  [[ !  "${output}"   =~ Title${_S}Three  ]]
  [[ !  "${output}"   =~ Title${_S}Four   ]]

  [[    "${output}"   =~  \
\<a.*\ href=\"//localhost:6789/home:5\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>    ]]
  [[    "${output}"   =~   \
class=\"list-item\"\>\<span\ class=\"muted\"\>\[\</span\>\<span\ class=\"identifier\"\>     ]]
  [[    "${output}"   =~   \
identifier\"\>home:5\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Five\</a\>\<br\>  ]]
}

@test "'browse --container -t tag2 --or -t tag3' performs OR search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    \
      --title "Title One"         \
      --content "Content one."

    "${_NB}" add "File Two.md"    \
      --title "Title Two"         \
      --content "Content #tag1 two."

    "${_NB}" add "File Three.md"  \
      --title "Title Three"       \
      --content "Content #tag2 three."

    "${_NB}" add "File Four.md"   \
      --title "Title Four"        \
      --content "Content #tag1 four."

    "${_NB}" add "File Five.md"   \
      --title "Title Five"        \
      --content "Content #tag2 #tag3 five."
  }

  run "${_NB}" browse --container -t tag2 --or -t tag3

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0               ]]

  [[ !  "${output}"   =~ Title${_S}One    ]]
  [[ !  "${output}"   =~ Title${_S}Four   ]]

  [[    "${output}"   =~  \
\<a.*\ href=\"//localhost:6789/home:5\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>    ]]
  [[    "${output}"   =~   \
class=\"list-item\"\>\<span\ class=\"muted\"\>\[\</span\>\<span\ class=\"identifier\"\>     ]]
  [[    "${output}"   =~   \
identifier\"\>home:5\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Five\</a\>\<br\>  ]]

  [[    "${output}"   =~   \
identifier\"\>home:3\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Three\</a\>\<br\> ]]
}

@test "'browse --container -t tag2 -t tag3' performs AND search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    \
      --title "Title One"         \
      --content "Content one."

    "${_NB}" add "File Two.md"    \
      --title "Title Two"         \
      --content "Content #tag1 two."

    "${_NB}" add "File Three.md"  \
      --title "Title Three"       \
      --content "Content #tag2 three."

    "${_NB}" add "File Four.md"   \
      --title "Title Four"        \
      --content "Content #tag1 four."

    "${_NB}" add "File Five.md"   \
      --title "Title Five"        \
      --content "Content #tag2 #tag3 five."
  }

  run "${_NB}" browse --container -t tag2 -t tag3

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0               ]]

  [[ !  "${output}"   =~ Title${_S}One    ]]
  [[ !  "${output}"   =~ Title${_S}Three  ]]
  [[ !  "${output}"   =~ Title${_S}Four   ]]

  [[    "${output}"   =~  \
\<a.*\ href=\"//localhost:6789/home:5\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>    ]]
  [[    "${output}"   =~   \
class=\"list-item\"\>\<span\ class=\"muted\"\>\[\</span\>\<span\ class=\"identifier\"\>     ]]
  [[    "${output}"   =~   \
identifier\"\>home:5\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Five\</a\>\<br\>  ]]
}

@test "'browse --container -t tag1' performs search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    \
      --title "Title One"         \
      --content "Content one."

    "${_NB}" add "File Two.md"    \
      --title "Title Two"         \
      --content "Content #tag1 two."

    "${_NB}" add "File Three.md"  \
      --title "Title Three"       \
      --content "Content #tag2 three."

    "${_NB}" add "File Four.md"   \
      --title "Title Four"        \
      --content "Content #tag1 four."

    "${_NB}" add "File Five.md"   \
      --title "Title Five"        \
      --content "Content #tag3 five."
  }

  run "${_NB}" browse --container -t tag1

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0               ]]

  [[ !  "${output}"   =~ Title${_S}One    ]]
  [[ !  "${output}"   =~ Title${_S}Three  ]]
  [[ !  "${output}"   =~ Title${_S}Five   ]]

  [[    "${output}"   =~   \
identifier\"\>home:4\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Four\</a\>\<br\>  ]]

  [[    "${output}"   =~  \
\<a.*\ href=\"//localhost:6789/home:2\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>    ]]
  [[    "${output}"   =~   \
class=\"list-item\"\>\<span\ class=\"muted\"\>\[\</span\>\<span\ class=\"identifier\"\>     ]]
  [[    "${output}"   =~   \
identifier\"\>home:2\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Two\</a\>\<br\>   ]]
}

@test "'browse --container --tag #tag1' (hash) performs search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    \
      --title "Title One"         \
      --content "Content one."

    "${_NB}" add "File Two.md"    \
      --title "Title Two"         \
      --content "Content #tag1 two."

    "${_NB}" add "File Three.md"  \
      --title "Title Three"       \
      --content "Content #tag2 three."

    "${_NB}" add "File Four.md"   \
      --title "Title Four"        \
      --content "Content #tag1 four."

    "${_NB}" add "File Five.md"   \
      --title "Title Five"        \
      --content "Content #tag3 five."
  }

  run "${_NB}" browse --container --tag "#tag1"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0           ]]

  [[ !  "${output}"   =~ Title${_S}One    ]]
  [[ !  "${output}"   =~ Title${_S}Three  ]]
  [[ !  "${output}"   =~ Title${_S}Five   ]]

  [[    "${output}"   =~   \
identifier\"\>home:4\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Four\</a\>\<br\>  ]]

  [[    "${output}"   =~  \
\<a.*\ href=\"//localhost:6789/home:2\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>    ]]
  [[    "${output}"   =~   \
class=\"list-item\"\>\<span\ class=\"muted\"\>\[\</span\>\<span\ class=\"identifier\"\>     ]]
  [[    "${output}"   =~   \
identifier\"\>home:2\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Two\</a\>\<br\>   ]]
}

@test "'browse --container --tag tag1' (no hash) performs search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    \
      --title "Title One"         \
      --content "Content one."

    "${_NB}" add "File Two.md"    \
      --title "Title Two"         \
      --content "Content #tag1 two."

    "${_NB}" add "File Three.md"  \
      --title "Title Three"       \
      --content "Content #tag2 three."

    "${_NB}" add "File Four.md"   \
      --title "Title Four"        \
      --content "Content #tag1 four."

    "${_NB}" add "File Five.md"   \
      --title "Title Five"        \
      --content "Content #tag3 five."
  }

  run "${_NB}" browse --container --tag "tag1"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0               ]]

  [[ !  "${output}"   =~ Title${_S}One    ]]
  [[ !  "${output}"   =~ Title${_S}Three  ]]
  [[ !  "${output}"   =~ Title${_S}Five   ]]

  [[    "${output}"   =~   \
identifier\"\>home:4\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Four\</a\>\<br\>  ]]

  [[    "${output}"   =~  \
\<a.*\ href=\"//localhost:6789/home:2\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>    ]]
  [[    "${output}"   =~   \
class=\"list-item\"\>\<span\ class=\"muted\"\>\[\</span\>\<span\ class=\"identifier\"\>     ]]
  [[    "${output}"   =~   \
identifier\"\>home:2\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Two\</a\>\<br\>   ]]
}

# notebook: selectors #########################################################

@test "'browse --query <query>' includes notebook selectors for results in the current notebook." {
  {
    "${_NB}" init

    "${_NB}" add "Example One.md" --content "Example 123 content."
    "${_NB}" add "Example Two.md" --content "Example content."

    "${_NB}" add "Sample Folder/Sample One.md" --content "Sample content."
    "${_NB}" add "Sample Folder/Sample Two.md" --content "Sample 123 content."
  }

  run "${_NB}" browse --query "123" --print

  printf "\${status}:   '%s'\\n" "${status}"
  printf "\${output}:   '%s'\\n" "${output}"

  [[    "${status}"   -eq 0 ]]

  [[    "${output}" =~  \
\[\</span\>\<span\ class=\"identifier\"\>home:1\</span\>\<span\ class=\"muted\"\>\]                   ]]
  [[    "${output}" =~  \
\[\</span\>\<span\ class=\"identifier\"\>home:Sample${_S}Folder/2\</span\>\<span\ class=\"muted\"\>\] ]]
}

@test "'browse --query <query>' includes notebook selectors for results in a selected notebook." {
  {
    "${_NB}" init

    "${_NB}" notebooks add "Example Notebook"

    "${_NB}" add "Example Notebook:Example One.md" --content "Example 123 content."
    "${_NB}" add "Example Notebook:Example Two.md" --content "Example content."

    "${_NB}" add "Example Notebook:Sample Folder/Sample One.md" --content "Sample content."
    "${_NB}" add "Example Notebook:Sample Folder/Sample Two.md" --content "Sample 123 content."
  }

  run "${_NB}" Example\ Notebook:browse --query "123" --print

  printf "\${status}:   '%s'\\n" "${status}"
  printf "\${output}:   '%s'\\n" "${output}"

  [[    "${status}"   -eq 0 ]]

  [[    "${output}" =~  \
\[\</span\>\<span\ class=\"identifier\"\>Example${_S}Notebook:1\</span\>\<span\ class=\"muted\"\>\]                   ]]
  [[    "${output}" =~  \
\[\</span\>\<span\ class=\"identifier\"\>Example${_S}Notebook:Sample${_S}Folder/2\</span\>\<span\ class=\"muted\"\>\] ]]
}

# local notebook ##############################################################

@test "'browse --query <query>' serves the search results from the local notebooks as a rendered HTML page with links to internal web server URLs." {
  {
    "${_NB}" init

    mkdir -p "${_TMP_DIR}/Local Notebook"
    cd "${_TMP_DIR}/Local Notebook"

    "${_NB}" notebooks init <<< "y${_NEWLINE}"

    "${_NB}" add  "File One.md"       \
      --title     "Title One"         \
      --content   "Example content."

    "${_NB}" add  "File Two.md"       \
      --title     "Title Two"         \
      --content   "Example abcd efgh content."

    "${_NB}" add  "Example Folder"    \
      --type      "folder"

    declare _expected_param_pattern="--local=${_TMP_DIR//$'/'/%2F}%2FLocal%20Notebook\&--columns=.*\&--limit=.*"

    sleep 1
  }

  run "${_NB}" browse --print --query "abcd efgh"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"  ==  0                                             ]]
  [[ "${output}"  =~  \<\!DOCTYPE\ html\>                           ]]

  # header crumbs

  [[ "${output}"  =~  \
\<nav\ class=\"header-crumbs\"\>.*\<a.*\ href=\"//localhost:6789/\?${_expected_param_pattern}\"\>   ]]
  [[ "${output}"  =~  \
href=\"//localhost:6789/\?${_expected_param_pattern}\"\>\<span\ class=\"muted\"\>❯\</span\>nb\</a\> ]]
  [[ "${output}"  =~  \
.*·.*\ \<a.*\ href=\"//localhost:6789/local:\?${_expected_param_pattern}\"\>local\</a\>.*\</nav\>   ]]

  # form

  [[ "${output}"  =~  \
action=\"/local:\?--columns=.*\&--limit=.*\&--local=${_TMP_DIR//$'/'/%2F}%2FLocal%20Notebook\"      ]]

  [[ "${output}"  =~  value=\"abcd\ efgh\"\>                                                ]]

  [[ "${output}"  =~  \
\<input\ type=\"hidden\"\ name=\"--local\"\ \ \ \ \ value=\"${_TMP_DIR}/Local\ Notebook\"\> ]]

  # list

  [[ !  "${output}" =~  \
\<a.*\ href=\"//localhost:6789/local:3\?--columns=.*\&--limit=.*\&--local=.*\"\ class=\"list-item\"\> ]]
  [[ !  "${output}" =~  .*\[.*local:3.*\].*${_S}📂${_S}Example${_S}Folder\</a\>\<br\>                 ]]

  [[    "${output}" =~  \
\<a.*\ href=\"//localhost:6789/local:2\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>   ]]
  [[    "${output}" =~  .*\[.*local:2.*\].*${_S}Title${_S}Two\</a\>\<br\>                   ]]

  [[ !  "${output}" =~  \
\<a.*\ href=\"//localhost:6789/local:1\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>   ]]
  [[ !  "${output}" =~  .*\[.*local:1.*\].*${_S}Title${_S}One\</a\>\<br\>                   ]]
}

# normalization ###############################################################

@test "'browse --query' with spaces performs search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md" --title "Title One" --content "Content one."
    "${_NB}" add "File Two.md" --title "Title Two" --content "Content abcd efgh two."

    (ncat                               \
      --exec "${_NB} browse --respond"  \
      --listen                          \
      --source-port "6789"              \
      2>/dev/null) &

    sleep 1
  }

  run curl -s "http://localhost:6789/home:?--query=abcd%20efgh"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0         ]]

  [[ !  "${output}"   =~ Title\ One ]]

  [[    "${output}"   =~  \
\<a.*\ href=\"//localhost:6789/home:2\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>  ]]
  [[    "${output}"   =~   \
class=\"list-item\"\>\<span\ class=\"muted\"\>\[\</span\>\<span\ class=\"identifier\"\>   ]]
  [[    "${output}"   =~   \
identifier\"\>home:2\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Two\</a\>\<br\> ]]

  {
    (ncat                               \
      --exec "${_NB} browse --respond"  \
      --listen                          \
      --source-port "6789"              \
      2>/dev/null) &

    sleep 1
  }

  run curl -s "http://localhost:6789/home:?--query=abcd+efgh"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0         ]]

  [[ !  "${output}"   =~ Title\ One ]]

  [[    "${output}"   =~  \
\<a.*\ href=\"//localhost:6789/home:2\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>  ]]
  [[    "${output}"   =~   \
class=\"list-item\"\>\<span\ class=\"muted\"\>\[\</span\>\<span\ class=\"identifier\"\>   ]]
  [[    "${output}"   =~   \
identifier\"\>home:2\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Two\</a\>\<br\> ]]
}

# no matches ##################################################################

@test "'browse --container --query' with no match displays page with message." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md" --title "Title One" --content "Content one."
    "${_NB}" add "File Two.md" --title "Title Two" --content "Content abcde two."
  }

  run "${_NB}" browse --container --query "non-matching-query"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0 ]]

  printf "%s\\n" "${output}" | grep   -q \
    "Not${_NBSP}found:${_NBSP}non-matching-query"

  printf "%s\\n" "${output}" | grep   -q \
    "placeholder=\"search\"${_NEWLINE}type=\"text\"${_NEWLINE}value=\"non-matching-query\">"
}

@test "'browse --container --query' with no match displays message with encoded query." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md" --title "Title One" --content "Content one."
    "${_NB}" add "File Two.md" --title "Title Two" --content "Content abcde two."
  }

  run "${_NB}" browse --container --query "<script>alert(document.cookie)</script>"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  declare _amp='\&'

  [[    "${status}"  -eq  0 ]]

  printf "%s\\n" "${output}" | grep   -q \
    "Not${_NBSP}found:${_NBSP}${_amp}#60;script${_amp}#62;alert${_amp}#40;document.cookie${_amp}#41;${_amp}#60;/script${_amp}#62;"

  printf "%s\\n" "${output}" | grep   -q \
    "placeholder=\"search\"${_NEWLINE}type=\"text\"${_NEWLINE}value=\"<script>alert(document.cookie)</script>\">"
}

# search form #################################################################

@test "'browse' with container displays search form." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md" --title "Title One" --content "Content one."
    "${_NB}" add "File Two.md" --title "Title Two" --content "Content abcde two."
  }

  run "${_NB}" browse --print

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0                       ]]

  [[    "${output}"  =~   placeholder=\"search\"  ]]
}

@test "'browse' with item does not display search form." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md" --title "Title One" --content "Content one."
    "${_NB}" add "File Two.md" --title "Title Two" --content "Content abcde two."
  }

  run "${_NB}" browse 1 --print

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0                       ]]

  [[ !  "${output}"  =~   placeholder=\"search\"  ]]
}

# query #######################################################################

@test "'browse --container --query' with quotes performs search." {
  {
    "${_NB}" init

    "${_NB}" add  "File One.md"     \
      --title     "Title One"       \
      --content   "One's content."
    "${_NB}" add  "File Two.md"     \
      --title     "Title Two"       \
      --content   "Two's \"quoted\" and unquoted content."
  }

  run "${_NB}" browse --container --query "Two's \"quoted\" and"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0         ]]

  [[ !  "${output}"   =~ Title\ One ]]

  [[    "${output}"   =~  \
\<a.*\ href=\"//localhost:6789/home:2\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>  ]]
  [[    "${output}"   =~   \
class=\"list-item\"\>\<span\ class=\"muted\"\>\[\</span\>\<span\ class=\"identifier\"\>   ]]
  [[    "${output}"   =~   \
identifier\"\>home:2\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Two\</a\>\<br\> ]]
}

@test "'browse --container --query' with tag performs search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md" --title "Title One" --content "Content one."
    "${_NB}" add "File Two.md" --title "Title Two" --content "Content #abcde two."
  }

  run "${_NB}" browse --container --query "#abcde"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0         ]]

  [[ !  "${output}"   =~ Title\ One ]]

  [[    "${output}"   =~  \
\<a.*\ href=\"//localhost:6789/home:2\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>  ]]
  [[    "${output}"   =~   \
class=\"list-item\"\>\<span\ class=\"muted\"\>\[\</span\>\<span\ class=\"identifier\"\>   ]]
  [[    "${output}"   =~   \
identifier\"\>home:2\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Two\</a\>\<br\> ]]
}

@test "'browse --container --query' performs search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md" --title "Title One" --content "Content one."
    "${_NB}" add "File Two.md" --title "Title Two" --content "Content abcde two."
  }

  run "${_NB}" browse --container --query "abcde"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0         ]]

  [[ !  "${output}"   =~ Title\ One ]]

  [[    "${output}"   =~  \
\<a.*\ href=\"//localhost:6789/home:2\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>  ]]
  [[    "${output}"   =~   \
class=\"list-item\"\>\<span\ class=\"muted\"\>\[\</span\>\<span\ class=\"identifier\"\>   ]]
  [[    "${output}"   =~   \
identifier\"\>home:2\</span\>\<span\ class=\"muted\"\>\]\</span\>\ Title\ Two\</a\>\<br\> ]]
}

@test "'browse --query' performs search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md" --title "Title One" --content "Content one."
    "${_NB}" add "File Two.md" --title "Title Two" --content "Content abcde two."
  }

  run "${_NB}" browse --query "abcde" --print

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0         ]]

  printf "%s\\n" "${output}" | grep -v  -q \
    "Title One"

  printf "%s\\n" "${output}" | grep     -q \
    "placeholder=\"search\"${_NEWLINE}type=\"text\"${_NEWLINE}value=\"abcde\">"

  printf "%s\\n" "${output}" | grep     -q \
    "<a.* href=\"//localhost:6789/home:2?--columns=.*&--limit=.*\" class=\"list-item\">"

  printf "%s\\n" "${output}" | grep     -q \
    "class=\"list-item\"><span class=\"muted\">\[</span><span class=\"identifier\">"

  printf "%s\\n" "${output}" | grep     -q \
    "identifier\">home:2</span><span class=\"muted\">\]</span> Title Two</a><br>"
}

@test "'browse --query \"<#hashtag>|<#hashtag>\"' performs OR search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    --title "Title One"   --content "Content one."
    "${_NB}" add "File Two.md"    --title "Title Two"   --content "Content #xyz two."
    "${_NB}" add "File Three.md"  --title "Title Three" --content "Content #abcde three. #xyz"
    "${_NB}" add "File Four.md"   --title "Title Four"  --content "Content #abcde four."
    "${_NB}" add "File Five.md"   --title "Title Five"  --content "Content #xyz five. #abcde"
  }


  run "${_NB}" browse --query "#xyz|#abcde" --print

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0                               ]]

  [[    "${output}" =~ value=\"\&#35\;xyz\|\&#35\;abcde\" ]]

  [[    "${output}" =~ \
\<a.*\ href=\"//localhost:6789/home:5\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>\<span\  ]]

  [[    "${output}" =~ \
\<a.*\ href=\"//localhost:6789/home:4\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>\<span\  ]]

  [[    "${output}" =~ \
\<a.*\ href=\"//localhost:6789/home:3\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>\<span\  ]]

  [[    "${output}" =~ \
\<a.*\ href=\"//localhost:6789/home:2\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>\<span\  ]]

  [[ !  "${output}" =~ \
\<a.*\ href=\"//localhost:6789/home:1\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>\<span\  ]]

}

@test "'browse --query <#hashtag> <#hashtag>' performs AND search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md"    --title "Title One"   --content "Content one."
    "${_NB}" add "File Two.md"    --title "Title Two"   --content "Content #xyz two."
    "${_NB}" add "File Three.md"  --title "Title Three" --content "Content #abcde three. #xyz"
    "${_NB}" add "File Four.md"   --title "Title Four"  --content "Content #abcde four."
    "${_NB}" add "File Five.md"   --title "Title Five"  --content "Content #xyz five. #abcde"
  }

  run "${_NB}" browse --query "#xyz #abcde" --print

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0                               ]]

  [[    "${output}" =~ value=\"\&#35\;xyz\ \&#35\;abcde\" ]]

  [[    "${output}" =~ \
\<a.*\ href=\"//localhost:6789/home:5\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>\<span\  ]]

  [[ !  "${output}" =~ \
\<a.*\ href=\"//localhost:6789/home:4\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>\<span\  ]]

  [[    "${output}" =~ \
\<a.*\ href=\"//localhost:6789/home:3\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>\<span\  ]]

  [[ !  "${output}" =~ \
\<a.*\ href=\"//localhost:6789/home:2\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>\<span\  ]]

  [[ !  "${output}" =~ \
\<a.*\ href=\"//localhost:6789/home:1\?--columns=.*\&--limit=.*\"\ class=\"list-item\"\>\<span\  ]]
}

@test "'browse --query <#hashtag>' performs search." {
  {
    "${_NB}" init

    "${_NB}" add "File One.md" --title "Title One" --content "Content one."
    "${_NB}" add "File Two.md" --title "Title Two" --content "Content #abcde two."
  }

  run "${_NB}" browse --query "#abcde" --print

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0         ]]

  printf "%s\\n" "${output}" | grep -v  -q \
    "Title One"

  printf "%s\\n" "${output}" | grep     -q \
    "placeholder=\"search\"${_NEWLINE}type=\"text\"${_NEWLINE}value=\"#abcde\">"

  printf "%s\\n" "${output}" | grep     -q \
    "<a.* href=\"//localhost:6789/home:2?--columns=.*&--limit=.*\" class=\"list-item\">"

  printf "%s\\n" "${output}" | grep     -q \
    "class=\"list-item\"><span class=\"muted\">\[</span><span class=\"identifier\">"

  printf "%s\\n" "${output}" | grep     -q \
    "identifier\">home:2</span><span class=\"muted\">\]</span> Title Two</a><br>"
}

@test "'browse --query' performs paginated search." {
  {
    "${_NB}" init

    local _counter=0
    local __number=
    for   __number in One Two Three Four Five Six Seven Eight Nine Ten
    do
      _counter="$((_counter+1))"

      if (($((_counter % 2))))
      then
        "${_NB}" add "File ${__number}.md" --title "Title ${__number}"
      else
        "${_NB}" add "File ${__number}.md" --title "Title ${__number}" \
          --content "abcde${_NEWLINE}${_NEWLINE}abcde"
      fi
    done
  }

  run "${_NB}" browse --query "abcde" --print --limit 2 --page 1

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0               ]]

  [[    "${output}"   =~ Title${_S}Eight  ]]
  [[    "${output}"   =~ Title${_S}Four   ]]

  [[ !  "${output}"   =~ Title${_S}Six    ]]
  [[ !  "${output}"   =~ Title${_S}Ten    ]]

  [[ !  "${output}"   =~ Title${_S}Two    ]]

  run "${_NB}" browse --query "abcde" --print --limit 2 --page 2

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0               ]]

  [[ !  "${output}"   =~ Title${_S}Eight  ]]
  [[ !  "${output}"   =~ Title${_S}Four   ]]

  [[    "${output}"   =~ Title${_S}Six    ]]
  [[    "${output}"   =~ Title${_S}Ten    ]]

  [[ !  "${output}"   =~ Title${_S}Two    ]]

  run "${_NB}" browse --query "abcde" --print --limit 2 --page 3

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[    "${status}"  -eq  0               ]]

  [[ !  "${output}"   =~ Title${_S}Eight  ]]
  [[ !  "${output}"   =~ Title${_S}Four   ]]

  [[ !  "${output}"   =~ Title${_S}Six    ]]
  [[ !  "${output}"   =~ Title${_S}Ten    ]]

  [[    "${output}"   =~ Title${_S}Two    ]]
}

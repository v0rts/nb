#!/usr/bin/env bats

load test_helper

# import bookmarks ############################################################

@test "'import bookmarks <path> <folder>/' imports chrome bookmarks into <folder>." {
  {
    "${_NB}" init

    {
      cat "${NB_TEST_BASE_PATH}/fixtures/example-chrome-bookmarks.html"
    } | {
      sed                                                                                     \
        -e "s|https://example.com\/|file://${NB_TEST_BASE_PATH}/fixtures/example.com.html|g"  \
        -e "s|https://example.org\/|file://${NB_TEST_BASE_PATH}/fixtures/example.org.html|g"  \
        -e "s|https://example.net\/|file://${NB_TEST_BASE_PATH}/fixtures/example.net.html|g"  \
        -e "s|https://example.edu\/|file://${NB_TEST_BASE_PATH}/fixtures/example.edu.html|g"
    } | {
      cat > "${_TMP_DIR}/example-chome-bookmarks-local.html"
    }
  }

  run "${_NB}" import bookmarks                       \
    "${_TMP_DIR}/example-chome-bookmarks-local.html"  \
    Example\ Folder/

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]

  [[ "${#lines[@]}" -eq 8 ]]

  [[ "${lines[0]}"  =~ \
Added:\ .*[.*Example\ Folder/toolbar/1.*].*\ 🔖\ .*Example\ Folder/toolbar/20220731185400\.bookmark\.md.*\ \"Example\ Com\" ]]

  [[ "${lines[1]}"  =~ \
Added:\ .*[.*Example\ Folder/toolbar/Example\ Bookmark\ Folder/Example\ Nested\ Folder/1.*].*\ 🔖\          ]]
  [[ "${lines[1]}"  =~ \
🔖\ .*Example\ Folder/toolbar/Example\ Bookmark\ Folder/Example\ Nested\ Folder/                            ]]
  [[ "${lines[1]}"  =~ \
Example\ Nested\ Folder/20220731185404\.bookmark\.md.*\ \"Example\ Org\"                                    ]]

  [[ "${lines[2]}"  =~ \
Added:\ .*[.*Example\ Folder/toolbar/Example\ Bookmark\ Folder/1.*].*\ 🔖\                                  ]]
  [[ "${lines[2]}"  =~ \
🔖\ .*Example\ Folder/toolbar/Example\ Bookmark\ Folder/20220731185402\.bookmark\.md.*\ \"Example\ Net\"    ]]

  [[ "${lines[3]}"  =~ \
Added:\ .*[.*Example\ Folder/toolbar/3.*].*\ 🔖\ .*Example\ Folder/toolbar/20220731185602\.bookmark\.md.*\ \"Example\ Edu\" ]]
  [[ "${lines[4]}"  =~ \
Added:\ .*[.*Example\ Folder/2.*].*\ 🔖\ .*Example\ Folder/20220731190230\.bookmark\.md.*\ \"Example\ Org\ Other\"          ]]
  [[ "${lines[5]}"  =~ \
Added:\ .*[.*Example\ Folder/3.*].*\ 🔖\ .*Example\ Folder/20220731190235\.bookmark\.md.*\ \"Example\ Net\ Other\"          ]]

  [[ "${lines[6]}"  =~ \
Added:\ .*[.*Example\ Folder/Example\ Folder\ Other/1.*].*\ 🔖\                                             ]]
  [[ "${lines[6]}"  =~ \
🔖\ .*Example\ Folder/Example\ Folder\ Other/20220731190222\.bookmark\.md.*\ \"Example\ Edu\ Other\"        ]]

  [[ "${lines[7]}"  =~ \
Added:\ .*[.*Example\ Folder/Example\ Folder\ Other/Example\ Nested\ Folder\ Other/1.*].*\ 🔖\              ]]
  [[ "${lines[7]}"  =~ \
🔖\ .*Example\ Folder/Example\ Folder\ Other/Example\ Nested\ Folder\ Other/                                ]]
  [[ "${lines[7]}"  =~ \
Example\ Nested\ Folder\ Other/20220731190214\.bookmark\.md.*\ \"Example\ Com\ Other\"                      ]]

  # Adds files.

  [[ -e "${NB_DIR}/home/Example Folder/toolbar/20220731185400.bookmark.md"                                                ]]
  [[ -e "${NB_DIR}/home/Example Folder/toolbar/Example Bookmark Folder/Example Nested Folder/20220731185404.bookmark.md"  ]]
  [[ -e "${NB_DIR}/home/Example Folder/toolbar/Example Bookmark Folder/20220731185402.bookmark.md"                        ]]
  [[ -e "${NB_DIR}/home/Example Folder/toolbar/20220731185602.bookmark.md"                                                ]]
  [[ -e "${NB_DIR}/home/Example Folder/20220731190230.bookmark.md"                                                        ]]
  [[ -e "${NB_DIR}/home/Example Folder/20220731190235.bookmark.md"                                                        ]]
  [[ -e "${NB_DIR}/home/Example Folder/Example Folder Other/20220731190222.bookmark.md"                                   ]]
  [[ -e "${NB_DIR}/home/Example Folder/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md"       ]]

  diff                                                                        \
    <(cat "${NB_DIR}/home/Example Folder/toolbar/20220731185400.bookmark.md") \
    <(cat << HEREDOC
# Example Com

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  diff                                                                                                                  \
    <(cat "${NB_DIR}/home/Example Folder/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md")  \
    <(cat << HEREDOC
# Example Com Other

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html#example>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  # Adds to index.

  [[ -e "${NB_DIR}/home/.index"                               ]]

  diff                                                        \
    <(ls -t -r "${NB_DIR}/home")                              \
    <(cat "${NB_DIR}/home/.index")

  # Creates git commit.

  while [[ -n "$(git -C "${NB_DIR}/home" status --porcelain)" ]]
  do
    sleep 1
  done

  git -C "${NB_DIR}/home" log | grep -q '\[nb\] Add'
}

@test "'import bookmarks <folder>/ <path>' imports chrome bookmarks into <folder>." {
  {
    "${_NB}" init

    {
      cat "${NB_TEST_BASE_PATH}/fixtures/example-chrome-bookmarks.html"
    } | {
      sed                                                                                     \
        -e "s|https://example.com\/|file://${NB_TEST_BASE_PATH}/fixtures/example.com.html|g"  \
        -e "s|https://example.org\/|file://${NB_TEST_BASE_PATH}/fixtures/example.org.html|g"  \
        -e "s|https://example.net\/|file://${NB_TEST_BASE_PATH}/fixtures/example.net.html|g"  \
        -e "s|https://example.edu\/|file://${NB_TEST_BASE_PATH}/fixtures/example.edu.html|g"
    } | {
      cat > "${_TMP_DIR}/example-chome-bookmarks-local.html"
    }
  }

  run "${_NB}" import bookmarks \
    Example\ Folder/            \
    "${_TMP_DIR}/example-chome-bookmarks-local.html"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]

  [[ "${#lines[@]}" -eq 8 ]]

  [[ "${lines[0]}"  =~ \
Added:\ .*[.*Example\ Folder/toolbar/1.*].*\ 🔖\ .*Example\ Folder/toolbar/20220731185400\.bookmark\.md.*\ \"Example\ Com\" ]]

  [[ "${lines[1]}"  =~ \
Added:\ .*[.*Example\ Folder/toolbar/Example\ Bookmark\ Folder/Example\ Nested\ Folder/1.*].*\ 🔖\          ]]
  [[ "${lines[1]}"  =~ \
🔖\ .*Example\ Folder/toolbar/Example\ Bookmark\ Folder/Example\ Nested\ Folder/                            ]]
  [[ "${lines[1]}"  =~ \
Example\ Nested\ Folder/20220731185404\.bookmark\.md.*\ \"Example\ Org\"                                    ]]

  [[ "${lines[2]}"  =~ \
Added:\ .*[.*Example\ Folder/toolbar/Example\ Bookmark\ Folder/1.*].*\ 🔖\                                  ]]
  [[ "${lines[2]}"  =~ \
🔖\ .*Example\ Folder/toolbar/Example\ Bookmark\ Folder/20220731185402\.bookmark\.md.*\ \"Example\ Net\"    ]]

  [[ "${lines[3]}"  =~ \
Added:\ .*[.*Example\ Folder/toolbar/3.*].*\ 🔖\ .*Example\ Folder/toolbar/20220731185602\.bookmark\.md.*\ \"Example\ Edu\" ]]
  [[ "${lines[4]}"  =~ \
Added:\ .*[.*Example\ Folder/2.*].*\ 🔖\ .*Example\ Folder/20220731190230\.bookmark\.md.*\ \"Example\ Org\ Other\"          ]]
  [[ "${lines[5]}"  =~ \
Added:\ .*[.*Example\ Folder/3.*].*\ 🔖\ .*Example\ Folder/20220731190235\.bookmark\.md.*\ \"Example\ Net\ Other\"          ]]

  [[ "${lines[6]}"  =~ \
Added:\ .*[.*Example\ Folder/Example\ Folder\ Other/1.*].*\ 🔖\                                             ]]
  [[ "${lines[6]}"  =~ \
🔖\ .*Example\ Folder/Example\ Folder\ Other/20220731190222\.bookmark\.md.*\ \"Example\ Edu\ Other\"        ]]

  [[ "${lines[7]}"  =~ \
Added:\ .*[.*Example\ Folder/Example\ Folder\ Other/Example\ Nested\ Folder\ Other/1.*].*\ 🔖\              ]]
  [[ "${lines[7]}"  =~ \
🔖\ .*Example\ Folder/Example\ Folder\ Other/Example\ Nested\ Folder\ Other/                                ]]
  [[ "${lines[7]}"  =~ \
Example\ Nested\ Folder\ Other/20220731190214\.bookmark\.md.*\ \"Example\ Com\ Other\"                      ]]

  # Adds files.

  [[ -e "${NB_DIR}/home/Example Folder/toolbar/20220731185400.bookmark.md"                                                ]]
  [[ -e "${NB_DIR}/home/Example Folder/toolbar/Example Bookmark Folder/Example Nested Folder/20220731185404.bookmark.md"  ]]
  [[ -e "${NB_DIR}/home/Example Folder/toolbar/Example Bookmark Folder/20220731185402.bookmark.md"                        ]]
  [[ -e "${NB_DIR}/home/Example Folder/toolbar/20220731185602.bookmark.md"                                                ]]
  [[ -e "${NB_DIR}/home/Example Folder/20220731190230.bookmark.md"                                                        ]]
  [[ -e "${NB_DIR}/home/Example Folder/20220731190235.bookmark.md"                                                        ]]
  [[ -e "${NB_DIR}/home/Example Folder/Example Folder Other/20220731190222.bookmark.md"                                   ]]
  [[ -e "${NB_DIR}/home/Example Folder/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md"       ]]

  diff                                                                        \
    <(cat "${NB_DIR}/home/Example Folder/toolbar/20220731185400.bookmark.md") \
    <(cat << HEREDOC
# Example Com

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  diff                                                                                                                  \
    <(cat "${NB_DIR}/home/Example Folder/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md")  \
    <(cat << HEREDOC
# Example Com Other

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html#example>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  # Adds to index.

  [[ -e "${NB_DIR}/home/.index"                               ]]

  diff                                                        \
    <(ls -t -r "${NB_DIR}/home")                              \
    <(cat "${NB_DIR}/home/.index")

  # Creates git commit.

  while [[ -n "$(git -C "${NB_DIR}/home" status --porcelain)" ]]
  do
    sleep 1
  done

  git -C "${NB_DIR}/home" log | grep -q '\[nb\] Add'
}

@test "'import bookmarks <path> <notebook>:<folder>/' imports chrome bookmarks into <notebook>:<folder>." {
  {
    "${_NB}" init

    "${_NB}" notebooks add "Example Notebook"

    {
      cat "${NB_TEST_BASE_PATH}/fixtures/example-chrome-bookmarks.html"
    } | {
      sed                                                                                     \
        -e "s|https://example.com\/|file://${NB_TEST_BASE_PATH}/fixtures/example.com.html|g"  \
        -e "s|https://example.org\/|file://${NB_TEST_BASE_PATH}/fixtures/example.org.html|g"  \
        -e "s|https://example.net\/|file://${NB_TEST_BASE_PATH}/fixtures/example.net.html|g"  \
        -e "s|https://example.edu\/|file://${NB_TEST_BASE_PATH}/fixtures/example.edu.html|g"
    } | {
      cat > "${_TMP_DIR}/example-chome-bookmarks-local.html"
    }
  }

  run "${_NB}" import bookmarks                       \
    "${_TMP_DIR}/example-chome-bookmarks-local.html"  \
    Example\ Notebook:Example\ Folder/

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]

  [[ "${#lines[@]}" -eq 8 ]]

  [[ "${lines[0]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/toolbar/1.*].*\ 🔖\ .*Example\ Notebook:Example\ Folder/toolbar/20220731185400\.bookmark\.md.*\ \"Example\ Com\" ]]

  [[ "${lines[1]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/toolbar/Example\ Bookmark\ Folder/Example\ Nested\ Folder/1.*].*\ 🔖\          ]]
  [[ "${lines[1]}"  =~ \
🔖\ .*Example\ Notebook:Example\ Folder/toolbar/Example\ Bookmark\ Folder/Example\ Nested\ Folder/                            ]]
  [[ "${lines[1]}"  =~ \
Example\ Nested\ Folder/20220731185404\.bookmark\.md.*\ \"Example\ Org\"                                                      ]]

  [[ "${lines[2]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/toolbar/Example\ Bookmark\ Folder/1.*].*\ 🔖\                                  ]]
  [[ "${lines[2]}"  =~ \
🔖\ .*Example\ Notebook:Example\ Folder/toolbar/Example\ Bookmark\ Folder/20220731185402\.bookmark\.md.*\ \"Example\ Net\"    ]]

  [[ "${lines[3]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/toolbar/3.*].*\ 🔖\ .*Example\ Notebook:Example\ Folder/toolbar/20220731185602\.bookmark\.md.*\ \"Example\ Edu\" ]]
  [[ "${lines[4]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/2.*].*\ 🔖\ .*Example\ Notebook:Example\ Folder/20220731190230\.bookmark\.md.*\ \"Example\ Org\ Other\"          ]]
  [[ "${lines[5]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/3.*].*\ 🔖\ .*Example\ Notebook:Example\ Folder/20220731190235\.bookmark\.md.*\ \"Example\ Net\ Other\"          ]]

  [[ "${lines[6]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/Example\ Folder\ Other/1.*].*\ 🔖\                                             ]]
  [[ "${lines[6]}"  =~ \
🔖\ .*Example\ Notebook:Example\ Folder/Example\ Folder\ Other/20220731190222\.bookmark\.md.*\ \"Example\ Edu\ Other\"        ]]

  [[ "${lines[7]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/Example\ Folder\ Other/Example\ Nested\ Folder\ Other/1.*].*\ 🔖\              ]]
  [[ "${lines[7]}"  =~ \
🔖\ .*Example\ Notebook:Example\ Folder/Example\ Folder\ Other/Example\ Nested\ Folder\ Other/                                ]]
  [[ "${lines[7]}"  =~ \
Example\ Nested\ Folder\ Other/20220731190214\.bookmark\.md.*\ \"Example\ Com\ Other\"                                        ]]

  # Adds files.

  [[ -e "${NB_DIR}/Example Notebook/Example Folder/toolbar/20220731185400.bookmark.md"                                               ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder/toolbar/Example Bookmark Folder/Example Nested Folder/20220731185404.bookmark.md" ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder/toolbar/Example Bookmark Folder/20220731185402.bookmark.md"                       ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder/toolbar/20220731185602.bookmark.md"                                               ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder/20220731190230.bookmark.md"                                                       ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder/20220731190235.bookmark.md"                                                       ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder/Example Folder Other/20220731190222.bookmark.md"                                  ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md"      ]]

  diff                                                                                    \
    <(cat "${NB_DIR}/Example Notebook/Example Folder/toolbar/20220731185400.bookmark.md") \
    <(cat << HEREDOC
# Example Com

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  diff                                                                                                                              \
    <(cat "${NB_DIR}/Example Notebook/Example Folder/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md")  \
    <(cat << HEREDOC
# Example Com Other

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html#example>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  # Adds to index.

  [[ -e "${NB_DIR}/Example Notebook/.index"                               ]]

  diff                                                                    \
    <(ls -t -r "${NB_DIR}/Example Notebook")                              \
    <(cat "${NB_DIR}/Example Notebook/.index")

  # Creates git commit.

  while [[ -n "$(git -C "${NB_DIR}/Example Notebook" status --porcelain)" ]]
  do
    sleep 1
  done

  git -C "${NB_DIR}/Example Notebook" log | grep -q '\[nb\] Add'
}

@test "'import bookmarks <notebook>:<folder>/ <path>' imports chrome bookmarks into <notebook>:<folder>." {
  {
    "${_NB}" init

    "${_NB}" notebooks add "Example Notebook"

    {
      cat "${NB_TEST_BASE_PATH}/fixtures/example-chrome-bookmarks.html"
    } | {
      sed                                                                                     \
        -e "s|https://example.com\/|file://${NB_TEST_BASE_PATH}/fixtures/example.com.html|g"  \
        -e "s|https://example.org\/|file://${NB_TEST_BASE_PATH}/fixtures/example.org.html|g"  \
        -e "s|https://example.net\/|file://${NB_TEST_BASE_PATH}/fixtures/example.net.html|g"  \
        -e "s|https://example.edu\/|file://${NB_TEST_BASE_PATH}/fixtures/example.edu.html|g"
    } | {
      cat > "${_TMP_DIR}/example-chome-bookmarks-local.html"
    }
  }

  run "${_NB}" import bookmarks         \
    Example\ Notebook:Example\ Folder/  \
    "${_TMP_DIR}/example-chome-bookmarks-local.html"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]

  [[ "${#lines[@]}" -eq 8 ]]

  [[ "${lines[0]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/toolbar/1.*].*\ 🔖\ .*Example\ Notebook:Example\ Folder/toolbar/20220731185400\.bookmark\.md.*\ \"Example\ Com\" ]]

  [[ "${lines[1]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/toolbar/Example\ Bookmark\ Folder/Example\ Nested\ Folder/1.*].*\ 🔖\          ]]
  [[ "${lines[1]}"  =~ \
🔖\ .*Example\ Notebook:Example\ Folder/toolbar/Example\ Bookmark\ Folder/Example\ Nested\ Folder/                            ]]
  [[ "${lines[1]}"  =~ \
Example\ Nested\ Folder/20220731185404\.bookmark\.md.*\ \"Example\ Org\"                                                      ]]

  [[ "${lines[2]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/toolbar/Example\ Bookmark\ Folder/1.*].*\ 🔖\                                  ]]
  [[ "${lines[2]}"  =~ \
🔖\ .*Example\ Notebook:Example\ Folder/toolbar/Example\ Bookmark\ Folder/20220731185402\.bookmark\.md.*\ \"Example\ Net\"    ]]

  [[ "${lines[3]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/toolbar/3.*].*\ 🔖\ .*Example\ Notebook:Example\ Folder/toolbar/20220731185602\.bookmark\.md.*\ \"Example\ Edu\" ]]
  [[ "${lines[4]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/2.*].*\ 🔖\ .*Example\ Notebook:Example\ Folder/20220731190230\.bookmark\.md.*\ \"Example\ Org\ Other\"          ]]
  [[ "${lines[5]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/3.*].*\ 🔖\ .*Example\ Notebook:Example\ Folder/20220731190235\.bookmark\.md.*\ \"Example\ Net\ Other\"          ]]

  [[ "${lines[6]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/Example\ Folder\ Other/1.*].*\ 🔖\                                             ]]
  [[ "${lines[6]}"  =~ \
🔖\ .*Example\ Notebook:Example\ Folder/Example\ Folder\ Other/20220731190222\.bookmark\.md.*\ \"Example\ Edu\ Other\"        ]]

  [[ "${lines[7]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder/Example\ Folder\ Other/Example\ Nested\ Folder\ Other/1.*].*\ 🔖\              ]]
  [[ "${lines[7]}"  =~ \
🔖\ .*Example\ Notebook:Example\ Folder/Example\ Folder\ Other/Example\ Nested\ Folder\ Other/                                ]]
  [[ "${lines[7]}"  =~ \
Example\ Nested\ Folder\ Other/20220731190214\.bookmark\.md.*\ \"Example\ Com\ Other\"                                        ]]

  # Adds files.

  [[ -e "${NB_DIR}/Example Notebook/Example Folder/toolbar/20220731185400.bookmark.md"                                               ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder/toolbar/Example Bookmark Folder/Example Nested Folder/20220731185404.bookmark.md" ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder/toolbar/Example Bookmark Folder/20220731185402.bookmark.md"                       ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder/toolbar/20220731185602.bookmark.md"                                               ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder/20220731190230.bookmark.md"                                                       ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder/20220731190235.bookmark.md"                                                       ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder/Example Folder Other/20220731190222.bookmark.md"                                  ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md"      ]]

  diff                                                                                    \
    <(cat "${NB_DIR}/Example Notebook/Example Folder/toolbar/20220731185400.bookmark.md") \
    <(cat << HEREDOC
# Example Com

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  diff                                                                                                                              \
    <(cat "${NB_DIR}/Example Notebook/Example Folder/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md")  \
    <(cat << HEREDOC
# Example Com Other

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html#example>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  # Adds to index.

  [[ -e "${NB_DIR}/Example Notebook/.index"                               ]]

  diff                                                                    \
    <(ls -t -r "${NB_DIR}/Example Notebook")                              \
    <(cat "${NB_DIR}/Example Notebook/.index")

  # Creates git commit.

  while [[ -n "$(git -C "${NB_DIR}/Example Notebook" status --porcelain)" ]]
  do
    sleep 1
  done

  git -C "${NB_DIR}/Example Notebook" log | grep -q '\[nb\] Add'
}

@test "'import bookmarks <path> <notebook>:' imports chrome bookmarks into <notebook>." {
  {
    "${_NB}" init

    "${_NB}" notebooks add "Example Notebook"

    {
      cat "${NB_TEST_BASE_PATH}/fixtures/example-chrome-bookmarks.html"
    } | {
      sed                                                                                     \
        -e "s|https://example.com\/|file://${NB_TEST_BASE_PATH}/fixtures/example.com.html|g"  \
        -e "s|https://example.org\/|file://${NB_TEST_BASE_PATH}/fixtures/example.org.html|g"  \
        -e "s|https://example.net\/|file://${NB_TEST_BASE_PATH}/fixtures/example.net.html|g"  \
        -e "s|https://example.edu\/|file://${NB_TEST_BASE_PATH}/fixtures/example.edu.html|g"
    } | {
      cat > "${_TMP_DIR}/example-chome-bookmarks-local.html"
    }
  }

  run "${_NB}" import bookmarks                       \
    "${_TMP_DIR}/example-chome-bookmarks-local.html"  \
    Example\ Notebook:

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]

  [[ "${#lines[@]}" -eq 8 ]]

  [[ "${lines[0]}"  =~ \
Added:\ .*[.*Example\ Notebook:toolbar/1.*].*\ 🔖\ .*Example\ Notebook:toolbar/20220731185400\.bookmark\.md.*\ \"Example\ Com\" ]]

  [[ "${lines[1]}"  =~ \
Added:\ .*[.*Example\ Notebook:toolbar/Example\ Bookmark\ Folder/Example\ Nested\ Folder/1.*].*\ 🔖\          ]]
  [[ "${lines[1]}"  =~ \
🔖\ .*Example\ Notebook:toolbar/Example\ Bookmark\ Folder/Example\ Nested\ Folder/                            ]]
  [[ "${lines[1]}"  =~ \
Example\ Nested\ Folder/20220731185404\.bookmark\.md.*\ \"Example\ Org\"                                      ]]

  [[ "${lines[2]}"  =~ \
Added:\ .*[.*Example\ Notebook:toolbar/Example\ Bookmark\ Folder/1.*].*\ 🔖\                                  ]]
  [[ "${lines[2]}"  =~ \
🔖\ .*Example\ Notebook:toolbar/Example\ Bookmark\ Folder/20220731185402\.bookmark\.md.*\ \"Example\ Net\"    ]]

  [[ "${lines[3]}"  =~ \
Added:\ .*[.*Example\ Notebook:toolbar/3.*].*\ 🔖\ .*Example\ Notebook:toolbar/20220731185602\.bookmark\.md.*\ \"Example\ Edu\" ]]
  [[ "${lines[4]}"  =~ \
Added:\ .*[.*Example\ Notebook:2.*].*\ 🔖\ .*Example\ Notebook:20220731190230\.bookmark\.md.*\ \"Example\ Org\ Other\"          ]]
  [[ "${lines[5]}"  =~ \
Added:\ .*[.*Example\ Notebook:3.*].*\ 🔖\ .*Example\ Notebook:20220731190235\.bookmark\.md.*\ \"Example\ Net\ Other\"          ]]

  [[ "${lines[6]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder\ Other/1.*].*\ 🔖\                                             ]]
  [[ "${lines[6]}"  =~ \
🔖\ .*Example\ Notebook:Example\ Folder\ Other/20220731190222\.bookmark\.md.*\ \"Example\ Edu\ Other\"        ]]

  [[ "${lines[7]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder\ Other/Example\ Nested\ Folder\ Other/1.*].*\ 🔖\              ]]
  [[ "${lines[7]}"  =~ \
🔖\ .*Example\ Notebook:Example\ Folder\ Other/Example\ Nested\ Folder\ Other/                                ]]
  [[ "${lines[7]}"  =~ \
Example\ Nested\ Folder\ Other/20220731190214\.bookmark\.md.*\ \"Example\ Com\ Other\"                        ]]

  # Adds files.

  [[ -e "${NB_DIR}/Example Notebook/toolbar/20220731185400.bookmark.md"                                               ]]
  [[ -e "${NB_DIR}/Example Notebook/toolbar/Example Bookmark Folder/Example Nested Folder/20220731185404.bookmark.md" ]]
  [[ -e "${NB_DIR}/Example Notebook/toolbar/Example Bookmark Folder/20220731185402.bookmark.md"                       ]]
  [[ -e "${NB_DIR}/Example Notebook/toolbar/20220731185602.bookmark.md"                                               ]]
  [[ -e "${NB_DIR}/Example Notebook/20220731190230.bookmark.md"                                                       ]]
  [[ -e "${NB_DIR}/Example Notebook/20220731190235.bookmark.md"                                                       ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder Other/20220731190222.bookmark.md"                                  ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md"      ]]

  diff                                                                      \
    <(cat "${NB_DIR}/Example Notebook/toolbar/20220731185400.bookmark.md")  \
    <(cat << HEREDOC
# Example Com

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  diff                                                                                                              \
    <(cat "${NB_DIR}/Example Notebook/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md") \
    <(cat << HEREDOC
# Example Com Other

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html#example>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  # Adds to index.

  [[ -e "${NB_DIR}/Example Notebook/.index"                               ]]

  diff                                                                    \
    <(ls -t -r "${NB_DIR}/Example Notebook")                              \
    <(cat "${NB_DIR}/Example Notebook/.index")

  # Creates git commit.

  while [[ -n "$(git -C "${NB_DIR}/Example Notebook" status --porcelain)" ]]
  do
    sleep 1
  done

  git -C "${NB_DIR}/Example Notebook" log | grep -q '\[nb\] Add'
}

@test "'import bookmarks <notebook>: <path>' imports chrome bookmarks into <notebook>." {
  {
    "${_NB}" init

    "${_NB}" notebooks add "Example Notebook"

    {
      cat "${NB_TEST_BASE_PATH}/fixtures/example-chrome-bookmarks.html"
    } | {
      sed                                                                                     \
        -e "s|https://example.com\/|file://${NB_TEST_BASE_PATH}/fixtures/example.com.html|g"  \
        -e "s|https://example.org\/|file://${NB_TEST_BASE_PATH}/fixtures/example.org.html|g"  \
        -e "s|https://example.net\/|file://${NB_TEST_BASE_PATH}/fixtures/example.net.html|g"  \
        -e "s|https://example.edu\/|file://${NB_TEST_BASE_PATH}/fixtures/example.edu.html|g"
    } | {
      cat > "${_TMP_DIR}/example-chome-bookmarks-local.html"
    }
  }

  run "${_NB}" import bookmarks \
    Example\ Notebook:          \
    "${_TMP_DIR}/example-chome-bookmarks-local.html"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]

  [[ "${#lines[@]}" -eq 8 ]]

  [[ "${lines[0]}"  =~ \
Added:\ .*[.*Example\ Notebook:toolbar/1.*].*\ 🔖\ .*Example\ Notebook:toolbar/20220731185400\.bookmark\.md.*\ \"Example\ Com\" ]]

  [[ "${lines[1]}"  =~ \
Added:\ .*[.*Example\ Notebook:toolbar/Example\ Bookmark\ Folder/Example\ Nested\ Folder/1.*].*\ 🔖\          ]]
  [[ "${lines[1]}"  =~ \
🔖\ .*Example\ Notebook:toolbar/Example\ Bookmark\ Folder/Example\ Nested\ Folder/                            ]]
  [[ "${lines[1]}"  =~ \
Example\ Nested\ Folder/20220731185404\.bookmark\.md.*\ \"Example\ Org\"                                      ]]

  [[ "${lines[2]}"  =~ \
Added:\ .*[.*Example\ Notebook:toolbar/Example\ Bookmark\ Folder/1.*].*\ 🔖\                                  ]]
  [[ "${lines[2]}"  =~ \
🔖\ .*Example\ Notebook:toolbar/Example\ Bookmark\ Folder/20220731185402\.bookmark\.md.*\ \"Example\ Net\"    ]]

  [[ "${lines[3]}"  =~ \
Added:\ .*[.*Example\ Notebook:toolbar/3.*].*\ 🔖\ .*Example\ Notebook:toolbar/20220731185602\.bookmark\.md.*\ \"Example\ Edu\" ]]
  [[ "${lines[4]}"  =~ \
Added:\ .*[.*Example\ Notebook:2.*].*\ 🔖\ .*Example\ Notebook:20220731190230\.bookmark\.md.*\ \"Example\ Org\ Other\"          ]]
  [[ "${lines[5]}"  =~ \
Added:\ .*[.*Example\ Notebook:3.*].*\ 🔖\ .*Example\ Notebook:20220731190235\.bookmark\.md.*\ \"Example\ Net\ Other\"          ]]

  [[ "${lines[6]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder\ Other/1.*].*\ 🔖\                                             ]]
  [[ "${lines[6]}"  =~ \
🔖\ .*Example\ Notebook:Example\ Folder\ Other/20220731190222\.bookmark\.md.*\ \"Example\ Edu\ Other\"        ]]

  [[ "${lines[7]}"  =~ \
Added:\ .*[.*Example\ Notebook:Example\ Folder\ Other/Example\ Nested\ Folder\ Other/1.*].*\ 🔖\              ]]
  [[ "${lines[7]}"  =~ \
🔖\ .*Example\ Notebook:Example\ Folder\ Other/Example\ Nested\ Folder\ Other/                                ]]
  [[ "${lines[7]}"  =~ \
Example\ Nested\ Folder\ Other/20220731190214\.bookmark\.md.*\ \"Example\ Com\ Other\"                        ]]

  # Adds files.

  [[ -e "${NB_DIR}/Example Notebook/toolbar/20220731185400.bookmark.md"                                               ]]
  [[ -e "${NB_DIR}/Example Notebook/toolbar/Example Bookmark Folder/Example Nested Folder/20220731185404.bookmark.md" ]]
  [[ -e "${NB_DIR}/Example Notebook/toolbar/Example Bookmark Folder/20220731185402.bookmark.md"                       ]]
  [[ -e "${NB_DIR}/Example Notebook/toolbar/20220731185602.bookmark.md"                                               ]]
  [[ -e "${NB_DIR}/Example Notebook/20220731190230.bookmark.md"                                                       ]]
  [[ -e "${NB_DIR}/Example Notebook/20220731190235.bookmark.md"                                                       ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder Other/20220731190222.bookmark.md"                                  ]]
  [[ -e "${NB_DIR}/Example Notebook/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md"      ]]

  diff                                                                      \
    <(cat "${NB_DIR}/Example Notebook/toolbar/20220731185400.bookmark.md")  \
    <(cat << HEREDOC
# Example Com

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  diff                                                                                                              \
    <(cat "${NB_DIR}/Example Notebook/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md") \
    <(cat << HEREDOC
# Example Com Other

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html#example>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  # Adds to index.

  [[ -e "${NB_DIR}/Example Notebook/.index"                               ]]

  diff                                                                    \
    <(ls -t -r "${NB_DIR}/Example Notebook")                              \
    <(cat "${NB_DIR}/Example Notebook/.index")

  # Creates git commit.

  while [[ -n "$(git -C "${NB_DIR}/Example Notebook" status --porcelain)" ]]
  do
    sleep 1
  done

  git -C "${NB_DIR}/Example Notebook" log | grep -q '\[nb\] Add'
}

@test "'import bookmarks <path>' imports firefox bookmarks." {
  {
    "${_NB}" init

    {
      cat "${NB_TEST_BASE_PATH}/fixtures/example-firefox-bookmarks.html"
    } | {
      sed                                                                                             \
        -e "s|https://example.com\/|file://${NB_TEST_BASE_PATH}/fixtures/example.com.html|g"          \
        -e "s|https://example.org\/|file://${NB_TEST_BASE_PATH}/fixtures/example.org.html|g"          \
        -e "s|https://example.net\/|file://${NB_TEST_BASE_PATH}/fixtures/example.net.html|g"          \
        -e "s|https://example.edu\/|file://${NB_TEST_BASE_PATH}/fixtures/example.edu.html|g"          \
        -e "s|https://support.mozilla.org\/|file://${NB_TEST_BASE_PATH}/fixtures/example.com.html#|g" \
        -e "s|https://www.mozilla.org\/|file://${NB_TEST_BASE_PATH}/fixtures/example.com.html#|g"
    } | {
      cat > "${_TMP_DIR}/example-firefox-bookmarks-local.html"
    }
  }

  run "${_NB}" import bookmarks \
    "${_TMP_DIR}/example-firefox-bookmarks-local.html"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0   ]]

  [[ "${#lines[@]}" -eq 17  ]]

  [[ "${lines[0]}"  =~ \
Added:\ .*[.*Example\ Folder\ Menu/Example\ Nested\ Folder\ Menu/1.*].*\ 🔖\                                    ]]
  [[ "${lines[0]}"  =~ \
🔖\ .*Example\ Folder\ Menu/Example\ Nested\ Folder\ Menu/20220801022006.bookmark.md.*\ \"Example\ Org\ Menu\"  ]]

  [[ "${lines[1]}"  =~ \
Added:\ .*[.*Example\ Folder\ Menu/2.*].*\ 🔖\                                        ]]
  [[ "${lines[1]}"  =~ \
🔖\ .*Example\ Folder\ Menu/20220801022006.bookmark.md.*\ \"Example\ Net\ Menu\"      ]]

  [[ "${lines[2]}"  =~ \
Added:\ .*[.*2.*].*\ 🔖\ .*20220801022006.bookmark.md.*\ \"Example\ Edu\ Menu\"       ]]

  [[ "${lines[3]}"  =~ \
Added:\ .*[.*3*].*\ 🔖\ .*20220801022006-1.bookmark.md.*\ \"Example\ Com\ Menu\"      ]]

  [[ "${lines[4]}"  =~ \
Added:\ .*[.*Mozilla\ Firefox/1.*].*\ 🔖\                                             ]]
  [[ "${lines[4]}"  =~ \
🔖\ .*Mozilla\ Firefox/20200819025841.bookmark.md.*\ \"Help\ and\ Tutorials\"         ]]

  [[ "${lines[5]}"  =~ \
Added:\ .*[.*Mozilla\ Firefox/2.*].*\ 🔖\                                             ]]
  [[ "${lines[5]}"  =~ \
.*Mozilla\ Firefox/20200819025841-1.bookmark.md.*\ \"Customize\ Firefox\"             ]]

  [[ "${lines[6]}"  =~ \
Added:\ .*[.*Mozilla\ Firefox/3.*].*\ 🔖\                                             ]]
  [[ "${lines[6]}"  =~ \
.*Mozilla\ Firefox/20200819025841-2.bookmark.md.*\ \"Get\ Involved\"                  ]]

  [[ "${lines[7]}"  =~ \
Added:\ .*[.*Mozilla\ Firefox/4.*].*\ 🔖\                                             ]]
  [[ "${lines[7]}"  =~ \
🔖\ .*Mozilla\ Firefox/20200819025841-3.bookmark.md.*\ \"About\ Us\"                  ]]

  [[ "${lines[8]}"  =~ \
Added:\ .*[.*toolbar/1.*].*\ 🔖\                                                      ]]
  [[ "${lines[8]}"  =~ \
🔖\ .*toolbar/20200819025841.bookmark.md.*\ \"Getting\ Started\"                      ]]

  [[ "${lines[9]}"  =~ \
Added:\ .*[.*toolbar/Example\ Folder\ Toolbar/Example\ Nested\ Folder\ Toolbar/1.*].*\ 🔖\          ]]
  [[ "${lines[9]}"  =~ \
🔖\ .*toolbar/Example\ Folder\ Toolbar/Example\ Nested\ Folder\ Toolbar/                            ]]
  [[ "${lines[9]}"  =~ \
Example\ Nested\ Folder\ Toolbar/20220801021734.bookmark.md.*\ \"Example\ Org\ Toolbar\"            ]]

  [[ "${lines[10]}" =~ \
Added:\ .*[.*toolbar/Example\ Folder\ Toolbar/2.*].*\ 🔖\                                           ]]
  [[ "${lines[10]}" =~ \
🔖\ .*toolbar/Example\ Folder\ Toolbar/                                                             ]]
  [[ "${lines[10]}" =~ \
20220801021651.bookmark.md.*\ \"Example\ Net\ Toolbar\"                                             ]]

  [[ "${lines[11]}" =~ \
Added:\ .*[.*toolbar/3.*].*\ 🔖\ .*toolbar/20220801021806.bookmark.md.*\ \"Example\ Edu\ Toolbar\"  ]]

  [[ "${lines[12]}" =~ \
Added:\ .*[.*toolbar/4.*].*\ 🔖\ .*toolbar/20220801021558.bookmark.md.*\ \"Example\ Com\ Toolbar\"  ]]

  [[ "${lines[13]}" =~ \
Added:\ .*[.*Other\ Bookmarks/4.*].*\ 🔖\                                                           ]]
  [[ "${lines[13]}" =~ \
🔖\ .*Other\ Bookmarks/20220801022030.bookmark.md.*\ \"Example\ Com\ Other\"                        ]]

  [[ "${lines[14]}" =~ \
Added:\ .*[.*Other\ Bookmarks/Example\ Folder\ Other/Example\ Nested\ Folder\ Other/1.*].*\ 🔖\                                     ]]
  [[ "${lines[14]}" =~ \
🔖\ .*Other\ Bookmarks/Example\ Folder\ Other/Example\ Nested\ Folder\ Other/20220801022010.bookmark.md.*\ \"Example\ Org\ Other\"  ]]

  [[ "${lines[15]}" =~ \
Added:\ .*[.*Other\ Bookmarks/Example\ Folder\ Other/2.*].*\ 🔖\                                    ]]
  [[ "${lines[15]}" =~ \
🔖\ .*Other\ Bookmarks/Example\ Folder\ Other/20220801022010.bookmark.md.*\ \"Example\ Net\ Other\" ]]

  [[ "${lines[16]}" =~ \
Added:\ .*[.*Other\ Bookmarks/3.*].*\ 🔖\                                                           ]]
  [[ "${lines[16]}" =~ \
🔖\ .*Other\ Bookmarks/20220801022010.bookmark.md.*\ \"Example\ Edu\ Other\"                        ]]

  # Adds files.

  [[ -e "${NB_DIR}/home/Example Folder Menu/Example Nested Folder Menu/20220801022006.bookmark.md"                    ]]
  [[ -e "${NB_DIR}/home/Example Folder Menu/20220801022006.bookmark.md"                                               ]]
  [[ -e "${NB_DIR}/home/20220801022006.bookmark.md"                                                                   ]]
  [[ -e "${NB_DIR}/home/20220801022006-1.bookmark.md"                                                                 ]]
  [[ -e "${NB_DIR}/home/Mozilla Firefox/20200819025841.bookmark.md"                                                   ]]
  [[ -e "${NB_DIR}/home/Mozilla Firefox/20200819025841-1.bookmark.md"                                                 ]]
  [[ -e "${NB_DIR}/home/Mozilla Firefox/20200819025841-2.bookmark.md"                                                 ]]
  [[ -e "${NB_DIR}/home/Mozilla Firefox/20200819025841-3.bookmark.md"                                                 ]]
  [[ -e "${NB_DIR}/home/toolbar/20200819025841.bookmark.md"                                                           ]]
  [[ -e "${NB_DIR}/home/toolbar/Example Folder Toolbar/Example Nested Folder Toolbar/20220801021734.bookmark.md"      ]]
  [[ -e "${NB_DIR}/home/toolbar/Example Folder Toolbar/20220801021651.bookmark.md"                                    ]]
  [[ -e "${NB_DIR}/home/toolbar/20220801021806.bookmark.md"                                                           ]]
  [[ -e "${NB_DIR}/home/toolbar/20220801021558.bookmark.md"                                                           ]]
  [[ -e "${NB_DIR}/home/Other Bookmarks/20220801022030.bookmark.md"                                                   ]]
  [[ -e "${NB_DIR}/home/Other Bookmarks/Example Folder Other/Example Nested Folder Other/20220801022010.bookmark.md"  ]]
  [[ -e "${NB_DIR}/home/Other Bookmarks/Example Folder Other/20220801022010.bookmark.md"                              ]]
  [[ -e "${NB_DIR}/home/Other Bookmarks/20220801022010.bookmark.md"                                                   ]]

  diff                                                                                                    \
    <(cat "${NB_DIR}/home/Example Folder Menu/Example Nested Folder Menu/20220801022006.bookmark.md")     \
    <(cat << HEREDOC
# Example Org Menu

<file://${NB_TEST_BASE_PATH}/fixtures/example.org.html#menu>

## Tags

#tag2 #tag6 #tag7

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  diff                                                                      \
    <(cat "${NB_DIR}/home/Example Folder Menu/20220801022006.bookmark.md")  \
    <(cat << HEREDOC
# Example Net Menu

<file://${NB_TEST_BASE_PATH}/fixtures/example.net.html#menu>

## Tags

#tag1 #tag4 #tag5

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  # Adds to index.

  [[ -e "${NB_DIR}/home/.index"                               ]]

  diff                                                        \
    <(ls -t -r "${NB_DIR}/home")                              \
    <(cat "${NB_DIR}/home/.index")

  # Creates git commit.

  while [[ -n "$(git -C "${NB_DIR}/home" status --porcelain)" ]]
  do
    sleep 1
  done

  git -C "${NB_DIR}/home" log | grep -q '\[nb\] Add'
}

@test "'import bookmarks <path>' imports chrome bookmarks." {
  {
    "${_NB}" init

    {
      cat "${NB_TEST_BASE_PATH}/fixtures/example-chrome-bookmarks.html"
    } | {
      sed                                                                                     \
        -e "s|https://example.com\/|file://${NB_TEST_BASE_PATH}/fixtures/example.com.html|g"  \
        -e "s|https://example.org\/|file://${NB_TEST_BASE_PATH}/fixtures/example.org.html|g"  \
        -e "s|https://example.net\/|file://${NB_TEST_BASE_PATH}/fixtures/example.net.html|g"  \
        -e "s|https://example.edu\/|file://${NB_TEST_BASE_PATH}/fixtures/example.edu.html|g"
    } | {
      cat > "${_TMP_DIR}/example-chome-bookmarks-local.html"
    }
  }

  run "${_NB}" import bookmarks \
    "${_TMP_DIR}/example-chome-bookmarks-local.html"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]

  [[ "${#lines[@]}" -eq 8 ]]

  [[ "${lines[0]}"  =~ \
Added:\ .*[.*toolbar/1.*].*\ 🔖\ .*toolbar/20220731185400\.bookmark\.md.*\ \"Example\ Com\" ]]

  [[ "${lines[1]}"  =~ \
Added:\ .*[.*toolbar/Example\ Bookmark\ Folder/Example\ Nested\ Folder/1.*].*\ 🔖\          ]]
  [[ "${lines[1]}"  =~ \
🔖\ .*toolbar/Example\ Bookmark\ Folder/Example\ Nested\ Folder/                            ]]
  [[ "${lines[1]}"  =~ \
Example\ Nested\ Folder/20220731185404\.bookmark\.md.*\ \"Example\ Org\"                    ]]

  [[ "${lines[2]}"  =~ \
Added:\ .*[.*toolbar/Example\ Bookmark\ Folder/1.*].*\ 🔖\                                  ]]
  [[ "${lines[2]}"  =~ \
🔖\ .*toolbar/Example\ Bookmark\ Folder/20220731185402\.bookmark\.md.*\ \"Example\ Net\"    ]]

  [[ "${lines[3]}"  =~ \
Added:\ .*[.*toolbar/3.*].*\ 🔖\ .*toolbar/20220731185602\.bookmark\.md.*\ \"Example\ Edu\" ]]
  [[ "${lines[4]}"  =~ \
Added:\ .*[.*2.*].*\ 🔖\ .*20220731190230\.bookmark\.md.*\ \"Example\ Org\ Other\"          ]]
  [[ "${lines[5]}"  =~ \
Added:\ .*[.*3.*].*\ 🔖\ .*20220731190235\.bookmark\.md.*\ \"Example\ Net\ Other\"          ]]

  [[ "${lines[6]}"  =~ \
Added:\ .*[.*Example\ Folder\ Other/1.*].*\ 🔖\                                             ]]
  [[ "${lines[6]}"  =~ \
🔖\ .*Example\ Folder\ Other/20220731190222\.bookmark\.md.*\ \"Example\ Edu\ Other\"        ]]

  [[ "${lines[7]}"  =~ \
Added:\ .*[.*Example\ Folder\ Other/Example\ Nested\ Folder\ Other/1.*].*\ 🔖\              ]]
  [[ "${lines[7]}"  =~ \
🔖\ .*Example\ Folder\ Other/Example\ Nested\ Folder\ Other/                                ]]
  [[ "${lines[7]}"  =~ \
Example\ Nested\ Folder\ Other/20220731190214\.bookmark\.md.*\ \"Example\ Com\ Other\"      ]]

  # Adds files.

  [[ -e "${NB_DIR}/home/toolbar/20220731185400.bookmark.md"                                               ]]
  [[ -e "${NB_DIR}/home/toolbar/Example Bookmark Folder/Example Nested Folder/20220731185404.bookmark.md" ]]
  [[ -e "${NB_DIR}/home/toolbar/Example Bookmark Folder/20220731185402.bookmark.md"                       ]]
  [[ -e "${NB_DIR}/home/toolbar/20220731185602.bookmark.md"                                               ]]
  [[ -e "${NB_DIR}/home/20220731190230.bookmark.md"                                                       ]]
  [[ -e "${NB_DIR}/home/20220731190235.bookmark.md"                                                       ]]
  [[ -e "${NB_DIR}/home/Example Folder Other/20220731190222.bookmark.md"                                  ]]
  [[ -e "${NB_DIR}/home/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md"      ]]

  diff                                                          \
    <(cat "${NB_DIR}/home/toolbar/20220731185400.bookmark.md")  \
    <(cat << HEREDOC
# Example Com

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  diff                                                                                                  \
    <(cat "${NB_DIR}/home/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md") \
    <(cat << HEREDOC
# Example Com Other

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html#example>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  # Adds to index.

  [[ -e "${NB_DIR}/home/.index"                               ]]

  diff                                                        \
    <(ls -t -r "${NB_DIR}/home")                              \
    <(cat "${NB_DIR}/home/.index")

  # Creates git commit.

  while [[ -n "$(git -C "${NB_DIR}/home" status --porcelain)" ]]
  do
    sleep 1
  done

  git -C "${NB_DIR}/home" log | grep -q '\[nb\] Add'
}

@test "'import bookmarks <path>' imports edge bookmarks." {
  {
    "${_NB}" init

    {
      cat "${NB_TEST_BASE_PATH}/fixtures/example-edge-bookmarks.html"
    } | {
      sed                                                                                     \
        -e "s|https://example.com\/|file://${NB_TEST_BASE_PATH}/fixtures/example.com.html|g"  \
        -e "s|https://example.org\/|file://${NB_TEST_BASE_PATH}/fixtures/example.org.html|g"  \
        -e "s|https://example.net\/|file://${NB_TEST_BASE_PATH}/fixtures/example.net.html|g"  \
        -e "s|https://example.edu\/|file://${NB_TEST_BASE_PATH}/fixtures/example.edu.html|g"
    } | {
      cat > "${_TMP_DIR}/example-edge-bookmarks-local.html"
    }
  }

  run "${_NB}" import bookmarks \
    "${_TMP_DIR}/example-edge-bookmarks-local.html"

  printf "\${status}: '%s'\\n" "${status}"
  printf "\${output}: '%s'\\n" "${output}"

  [[ "${status}"    -eq 0 ]]

  [[ "${#lines[@]}" -eq 8 ]]

  [[ "${lines[0]}"  =~ \
Added:\ .*[.*toolbar/Bookmarks/1.*].*\ 🔖\ .*toolbar/Bookmarks/20220731185400\.bookmark\.md.*\ \"Example\ Com\" ]]

  [[ "${lines[1]}"  =~ \
Added:\ .*[.*toolbar/Bookmarks/Example\ Bookmark\ Folder/Example\ Nested\ Folder/1.*].*\ 🔖\          ]]
  [[ "${lines[1]}"  =~ \
🔖\ .*toolbar/Bookmarks/Example\ Bookmark\ Folder/Example\ Nested\ Folder/                            ]]
  [[ "${lines[1]}"  =~ \
Example\ Nested\ Folder/20220731185404\.bookmark\.md.*\ \"Example\ Org\"                              ]]

  [[ "${lines[2]}"  =~ \
Added:\ .*[.*toolbar/Bookmarks/Example\ Bookmark\ Folder/1.*].*\ 🔖\                                  ]]
  [[ "${lines[2]}"  =~ \
🔖\ .*toolbar/Bookmarks/Example\ Bookmark\ Folder/20220731185402\.bookmark\.md.*\ \"Example\ Net\"    ]]

  [[ "${lines[3]}"  =~ \
Added:\ .*[.*toolbar/Bookmarks/3.*].*\ 🔖\ .*toolbar/Bookmarks/20220731185602\.bookmark\.md.*\ \"Example\ Edu\" ]]
  [[ "${lines[4]}"  =~ \
Added:\ .*[.*2.*].*\ 🔖\ .*20220731190230\.bookmark\.md.*\ \"Example\ Org\ Other\"      ]]
  [[ "${lines[5]}"  =~ \
Added:\ .*[.*3.*].*\ 🔖\ .*20220731190235\.bookmark\.md.*\ \"Example\ Net\ Other\"      ]]

  [[ "${lines[6]}"  =~ \
Added:\ .*[.*Example\ Folder\ Other/1.*].*\ 🔖\                                         ]]
  [[ "${lines[6]}"  =~ \
🔖\ .*Example\ Folder\ Other/20220731190222\.bookmark\.md.*\ \"Example\ Edu\ Other\"    ]]

  [[ "${lines[7]}"  =~ \
Added:\ .*[.*Example\ Folder\ Other/Example\ Nested\ Folder\ Other/1.*].*\ 🔖\          ]]
  [[ "${lines[7]}"  =~ \
🔖\ .*Example\ Folder\ Other/Example\ Nested\ Folder\ Other/                            ]]
  [[ "${lines[7]}"  =~ \
Example\ Nested\ Folder\ Other/20220731190214\.bookmark\.md.*\ \"Example\ Com\ Other\"  ]]

  # Adds files.

  [[ -e "${NB_DIR}/home/toolbar/Bookmarks/20220731185400.bookmark.md"                                               ]]
  [[ -e "${NB_DIR}/home/toolbar/Bookmarks/Example Bookmark Folder/Example Nested Folder/20220731185404.bookmark.md" ]]
  [[ -e "${NB_DIR}/home/toolbar/Bookmarks/Example Bookmark Folder/20220731185402.bookmark.md"                       ]]
  [[ -e "${NB_DIR}/home/toolbar/Bookmarks/20220731185602.bookmark.md"                                               ]]
  [[ -e "${NB_DIR}/home/20220731190230.bookmark.md"                                                                 ]]
  [[ -e "${NB_DIR}/home/20220731190235.bookmark.md"                                                                 ]]
  [[ -e "${NB_DIR}/home/Example Folder Other/20220731190222.bookmark.md"                                            ]]
  [[ -e "${NB_DIR}/home/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md"                ]]

  diff                                                          \
    <(cat "${NB_DIR}/home/toolbar/Bookmarks/20220731185400.bookmark.md")  \
    <(cat << HEREDOC
# Example Com

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  diff                                                                                                  \
    <(cat "${NB_DIR}/home/Example Folder Other/Example Nested Folder Other/20220731190214.bookmark.md") \
    <(cat << HEREDOC
# Example Com Other

<file://${NB_TEST_BASE_PATH}/fixtures/example.com.html#example>

## Description

Example description.

## Content

# Example Domain

This domain is for use in illustrative examples in documents. You may use this
domain in literature without prior coordination or asking for permission.

[More information\...](https://www.iana.org/domains/example)
HEREDOC
    )

  # Adds to index.

  [[ -e "${NB_DIR}/home/.index"                               ]]

  diff                                                        \
    <(ls -t -r "${NB_DIR}/home")                              \
    <(cat "${NB_DIR}/home/.index")

  # Creates git commit.

  while [[ -n "$(git -C "${NB_DIR}/home" status --porcelain)" ]]
  do
    sleep 1
  done

  git -C "${NB_DIR}/home" log | grep -q '\[nb\] Add'
}

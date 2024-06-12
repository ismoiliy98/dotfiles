# Helper function to find the position of the next word
function find_next_word_pos() {
  local line="$1" current_pos="$2"
  local target_pos=-1 in_word=0
  local index=0

  for ((index = current_pos + 1; index <= ${#line}; index++)); do
    if [[ "${line:$index-1:1}" =~ [[:alnum:]_-] ]]; then
      in_word=1
    else
      if ((in_word == 1)); then
        index=$((index - 1))
        target_pos=$index
        break
      fi
    fi
  done

  if ((in_word == 1 && target_pos == -1)); then
    target_pos=${#line}
  fi

  echo "$target_pos"
}

# Helper function to find the position of the previous word
function find_prev_word_pos() {
  local line="$1" current_pos="$2"
  local target_pos=-1 in_word=0

  for ((i = current_pos - 1; i >= 0; i--)); do
    if [[ "${line:$i:1}" =~ [[:alnum:]_-] && (i == 0 || "${line:$i-1:1}" != [[:alnum:]_-]) ]]; then
      target_pos=$i
      break
    fi
  done

  echo "$target_pos"
}

# Smart word movement function
function move_cursor() {
  local line="${BUFFER}"
  local current_pos="$CURSOR"
  local direction="$1"
  local target_pos=-1

  if [[ "$direction" == "forward" ]]; then
    target_pos=$(find_next_word_pos "$line" "$current_pos")
  elif [[ "$direction" == "backward" ]]; then
    target_pos=$(find_prev_word_pos "$line" "$current_pos")
    if ((target_pos == -1)); then
      target_pos=0
    fi
  else
    return 1 # Invalid direction
  fi

  if ((target_pos == -1)); then
    target_pos=${#line}
  fi

  CURSOR="$target_pos"
}

# Wrapper functions for convenience
function move_cursor_backward() {
  move_cursor "backward"
}

function move_cursor_forward() {
  move_cursor "forward"
}

# Bind the functions to desired keyboard shortcuts
zle -N move_cursor_backward
zle -N move_cursor_forward
bindkey "^[[1;9D" move_cursor_backward
bindkey "^[[1;9C" move_cursor_forward

# vim: expandtab softtabstop=2 shiftwidth=2
# vim: foldmethod=marker
# vim: filetype=fish

# See Also: https://zenn.dev/kyoh86/articles/291618538dcf0d
function gobin-update
  set -f gobin "$(go env GOBIN)"

  for file in "$gobin"/*
    set -f pkg "$(go version -m "$file" 2> /dev/null | head -n2 | tail -n1 | awk '{print $2}')"
    if test -n "$pkg"
      go install "$pkg@latest"
    end
  end
end


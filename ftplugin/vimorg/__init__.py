import vim
import re

shift_regex = re.compile(r'^(\s*)')
project_regex = re.compile(r'^(\s*)\*\s(.*)$')
property_regex = re.compile(r'^(\s*):(.+):$')
def FoldLevel(lnum):
    shiftwidth = int(vim.eval("&shiftwidth"))
    foldlevel = 0
    line = lnum
    level_prefix = ""
    level_add = 0
    b = vim.current.buffer

    match = shift_regex.match(b[line-1])
    if match:
        spaces = match.group(1)
        foldlevel = len(spaces) / shiftwidth

        project_match = project_regex.match(b[line - 1])
        if project_match:
            foldlevel = foldlevel + 1
            level_prefix = ">"

    while(line > 0):
        property_match = property_regex.match(b[line - 1])
        project_match = project_regex.match(b[line - 1])
        if property_match:
            prop_name = property_match.group(2)
            foldlevel = foldlevel + 1

            if prop_name == "END":
                if line == lnum:
                    level_prefix = "<"
                    break
                else:
                    foldlevel = foldlevel - 2
            elif line == lnum:
                level_prefix = ">"
                break
        elif project_match:
            break

        line = line - 1


    vim.command("let l:foldLevel=\"{0}{1}\"".format(level_prefix, foldlevel + level_add))


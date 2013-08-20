import vim
import re

shift_regex = re.compile(r'^(\s*)')
project_regex = re.compile(r'^(\s*)\*\s(.*)$')
property_regex = re.compile(r'^(\s*):(.+):$')

def level(line, shiftwidth):
    return len(shift_regex.match(line).group(1)) / shiftwidth

class Project(object):

    def __init__(self, buf, line):
        shiftwidth = int(vim.eval("&shiftwidth"))
        self.buf = buf
        self.line = line
        self.subprojects = []
        self.project_desc = None

        self.level = level(buf[line - 1], shiftwidth)

        self.project_line = line
        l = line
        while l > 0:
            project = project_regex.match(buf[l - 1])
            cur_level = level(buf[l-1], shiftwidth)
            if project and line == l:
                self.level = self.level + 1
                self.project_line = l
                self.project_desc = project.group(2)
                break
            elif project and cur_level < self.level:
                self.project_line = l
                self.project_desc = project.group(2)
                break
            elif project and cur_level == self.level:
                # child project
                self.subprojects.append(Project(buf, l))
            l = l - 1

        l = line + 1
        while l < len(buf):
            project = project_regex.match(buf[l-1])
            cur_level = level(buf[l-1], shiftwidth)
            if project and cur_level == self.level:
                self.subprojects.append(Project(buf, l))
            l = l + 1

        if not self.project_desc:
            raise Exception("Not in a project")



def clock_in():
    (cur_line, cur_col) = vim.current.window.cursor
    try:
        project = Project(vim.current.buffer, cur_line)
        print "Clocking In to {0}".format(project.project_desc)
    except Exception as e:
        print e

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


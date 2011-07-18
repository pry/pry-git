pry-git
===========

(C) John Mair (banisterfiend) 2011

_A Ruby-aware git layer_

Retrieve blame, perform diffs, make commits using the natural units of
Ruby code.

pry-git enables you to diff an individual _method_ , it can show you
the blame for a method  and ultimately allow you to commit 'methods' (rather than amorphous
'hunks' of code).

pry-git is a plugin for the [pry](http://pry.github.com)
REPL.

pry-git is very much proof of concept right now, stay tuned!

* Install the [gem](https://rubygems.org/gems/pry-git): `gem install pry-git`
* See the [source code](http://github.com/pry/pry-git)

Example: blame
--------

    pry(main)> git blame Pry#repl
    John Mair   def repl(target=TOPLEVEL_BINDING)
    John Mair     target = Pry.binding_for(target)
    John Mair     target_self = target.eval('self')
    John Mair
    John Mair     repl_prologue(target)
    Mon ouïe
    John Mair     # cannot rely on nesting.level as
    John Mair     # nesting.level changes with new sessions
    John Mair     nesting_level = nesting.size
    John Mair
    John Mair     break_data = catch(:breakout) do
    John Mair       nesting.push [nesting.size, target_self, self]
    John Mair       loop do
    John Mair         rep(target)
    John Mair       end
    John Mair     end
    John Mair
    John Mair     return_value = repl_epilogue(target, nesting_level, break_data)
    Lee Jarvis    return_value || target_self
    John Mair   end

Example: diff
--------

    pry(main)> git diff Pry#repl
       def repl(target=TOPLEVEL_BINDING)
    +
    +    # hey baby
         target = Pry.binding_for(target)
         target_self = target.eval('self')

    +    # bink
         repl_prologue(target)

         # cannot rely on nesting.level as
         # nesting.level changes with new sessions
         nesting_level = nesting.size

         break_data = catch(:breakout) do
           nesting.push [nesting.size, target_self, self]
           loop do
             rep(target)
           end
         end

         return_value = repl_epilogue(target, nesting_level, break_data)
         return_value || target_self
       end

Example: add
--------

Note that `.git` invokes the system `git` command (a `.` prefix
forwards the line to the shell, see: [shell commands](https://github.com/pry/pry/wiki/Shell-Integration#Execute_shell_commands))

    pry(main) git add Pry#repl
    pry(main) .git diff --cached
    diff --git a/lib/pry/pry_instance.rb b/lib/pry/pry_instance.rb
    index 7a4c403..6483a4a 100644
    --- a/lib/pry/pry_instance.rb
    +++ b/lib/pry/pry_instance.rb
    @@ -164,9 +164,11 @@ class Pry
       #   Pry.new.repl(Object.new)
       def repl(target=TOPLEVEL_BINDING)

    +    # hey baby
         target = Pry.binding_for(target)
         target_self = target.eval('self')

    +    # bink
         repl_prologue(target)

         # cannot rely on nesting.level as

Features and limitations
-------------------------

* Just a proof of concept at this stage.
* The methods you're invoking the git commands on must be part of a
  git repo (of course).
* Commands currently just work with respect to `HEAD`; this
  restriction will be lifted in a later version.
* BETA software, beware!

Contact
-------

Problems or questions contact me at [github](http://github.com/banister)


License
-------

(The MIT License)

Copyright (c) 2011 John Mair (banisterfiend)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

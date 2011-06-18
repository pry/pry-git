pry-git
===========

(C) John Mair (banisterfiend) 2011

_ruby aware git_

Retrieve blame, perform diffs, make commits using the natural units of
Ruby code.

pry-git enables you to diff an individual _method_ , it can show you
the blame for a method  and ultimately allow you to commit 'methods' (rather than amorphous
'hunks' of code).

pry-git is a plugin for the [pry](http://github.com/banister/pry)
REPL, a powerful IRB alternative.

pry-git is very much proof of concept right now, stay tuned!

* NOT AVAILABLE: Install the [gem](https://rubygems.org/gems/pry-git): `gem install pry-git`
* NOT AVAILABLE: Read the [documentation](http://rdoc.info/github/banister/pry-git/master/file/README.md)
* See the [source code](http://github.com/banister/pry-git)

Example: blame
--------

    pry(main)> blame Pry#repl
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

    pry(main)> diff Pry#repl
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
    -
    -  # Perform a read-eval-print.
    -  # If no parameter is given, default to top-level (main).

Features and limitations
-------------------------

* commit-method not yet implemented
* BETA software, not guaranteed to work properly yet, stay tuned.

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

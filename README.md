# asm

A few assembly programs (GNU Assmbler) I have written.
Most use x86-64 conventions and Linux syscalls.
Most can be assembled (`as a.s -o a.o`), linked (`ld a.o -o a.out`) and run (`./a.out`).
If they require extra steps, there is probably a Makefile in the folder.

## Bare Metal / Operating Systems

### Books

#### Practical

- [Writing a Simple Operating System from Scratch](https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf) [(HackerNews)](https://news.ycombinator.com/item?id=8380822)
- [The little book about OS development](https://littleosbook.github.io/) [(HackerNews)](https://news.ycombinator.com/item?id=13258063)
- [Operating Systems: From 0 to 1](https://github.com/tuhdo/os01) [(HackerNews)](https://news.ycombinator.com/item?id=13641949)
- [How to Make a Computer Operating System](https://samypesse.gitbook.io/how-to-create-an-operating-system/)
- [Operating System Development Series](http://www.brokenthorn.com/Resources/OSDevIndex.html)
- [linux-insides](https://0xax.gitbooks.io/linux-insides/content/index.html)

#### Textbooks/Reference

- [Operating Systems: Three Easy Pieces](https://pages.cs.wisc.edu/~remzi/OSTEP/)

### Lectures/Notes

- [6.828: Operating System Engineering - MIT](https://ocw.mit.edu/courses/electrical-engineering-and-computer-science/6-828-operating-system-engineering-fall-2012/index.htm)
- [CS 140: Operating Systems - Stanford](https://web.stanford.edu/~ouster/cgi-bin/cs140-spring20/index.php)
- [Hack the Kernel - ops-class.org](https://ops-class.org/)

### Web

- [OSDev Wiki](https://wiki.osdev.org/Main_Page)
- [x86-bare-metal-examples cirosantilli - Github](https://github.com/cirosantilli/x86-bare-metal-examples)
- [osdever.net](http://www.osdever.net/tutorials/)

### Youtube

- [Poncho](https://www.youtube.com/channel/UC15iQ_QzTPxB6yGzzifJfKA)
- [Daedalus Community](https://www.youtube.com/c/DaedalusCommunity)

### Examples

- [MellOS](https://github.com/mell-o-tron/MellOs)
- [PonchoOS](https://github.com/Absurdponcho/PonchoOS)

## Forth

- [Gforth Manual](https://www.complang.tuwien.ac.at/forth/gforth/Docs-html)
- [A Beginner's Guide to Forth - J.V. Noble](http://galileo.phys.virginia.edu/classes/551.jvn.fall01/primer.htm)
- [Annexia Forth (archive.org)](https://web.archive.org/web/20080509082146/http://www.annexia.org/forth)
- [Starting Forth - Leo Brodie](https://www.forth.com/starting-forth/)
- [Forth Tutorials](http://www.forth.org/tutorials.html)
- [Decompilation of Forth code with 'see' - StackOverflow](https://stackoverflow.com/questions/44014281/dissassembly-of-forth-code-words-with-see)

## Assembly

### References

- [Intel® 64 and IA-32 Architectures Software Developer Manuals](https://software.intel.com/content/www/us/en/develop/articles/intel-sdm.html)
- [AMD64 Architecture Programmer’s Manual](https://developer.amd.com/resources/developer-guides-manuals/)
- [System V x86-64 psABI](https://gitlab.com/x86-psABIs/x86-64-ABI)
- [The Art of Assembly Language (DOS/16-bit)](https://www.plantation-productions.com/Webster/www.artofasm.com/DOS/index.html)

### Books

- [Programming from the Ground Up - Jonathan Bartlett](https://download-mirror.savannah.gnu.org/releases/pgubook/ProgrammingGroundUp-1-0-booksize.pdf)
- [PC Assembly Language - Paul Carter](https://pacman128.github.io/pcasm/)
- [Introduction to 64 Bit Assembly Language Programming for Linux - Ray Seyfarth (Not free)](http://rayseyfarth.com/asm/)
- [x86-64 Assembly Language Programming with Ubuntu - Ed Jorgensen](http://www.egr.unlv.edu/~ed/x86.html)
- [Linux Assembly - Peter Berends (Dutch)](http://www.posix.nl/linuxassembly/)
- [Linux Assembly Language Programming by Bob Neveln](https://www.oreilly.com/library/view/linux-assembly-language/0130879401/)

### Web

- [x86 Assembly - Wikibooks](https://en.wikibooks.org/wiki/X86_Assembly)
- [GNU as docs](https://sourceware.org/binutils/docs/as/)
- [Felix Clourtier x86 instruction reference](https://www.felixcloutier.com/x86/)
- [Linux Assembly](http://asm.sourceforge.net/)

## Interpreter/Compiler

- [Let's Build a Compiler - Crenshaw](https://compilers.iecc.com/crenshaw/)
- [Build Your Own Lisp](http://www.buildyourownlisp.com/)

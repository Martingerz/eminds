#This code contains fragments from this article:
#http://aurelianito.blogspot.com/2008/02/compilando-latex-con-rake.html

require "rake/clean"

CLEAN.include(FileList["*.aux", "*.bbl", "*.blg", "*.log"] )
CLOBBER.include(FileList["*.pdf"] )
SOURCES = FileList["*.tex", "*.bib", "*.cls", "*.sty", "Rakefile.rb"]

MASTER = "volume-master"
MASTER_OUTPUT_FILE = MASTER.ext("pdf")

PDFLATEX = "pdflatex"
BIBTEX = "bibtex"


def pdflatex(file)
  sh PDFLATEX, "-halt-on-error", file do 
    |ok, res|
    unless ok
      puts "Error compiling LaTeX file (status=#{res.exitstatus})\n"
      exit
    end
  end
end

namespace :volume  do

  file MASTER_OUTPUT_FILE => SOURCES  do
    1.upto 3 do
      pdflatex MASTER
    end
  end
  
  task :pdf => MASTER_OUTPUT_FILE
end




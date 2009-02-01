#This code contains fragments from this article:
#http://aurelianito.blogspot.com/2008/02/compilando-latex-con-rake.html

$LOAD_PATH << "../../"

require "rake/clean"
require "lib/volumeCommands"


INSTRUCTIONS_MASTER = "paper-master"
INSTRUCTIONS_MASTER_OUTPUT_FILE = INSTRUCTIONS_MASTER.ext("pdf")

namespace :instructions  do

  file INSTRUCTIONS_MASTER_OUTPUT_FILE => SOURCES  do
    1.upto 3 do
      pdflatex INSTRUCTIONS_MASTER
    end
  end
  
  task :pdf => INSTRUCTIONS_MASTER_OUTPUT_FILE
end




#This code contains fragments from this article:
#http://aurelianito.blogspot.com/2008/02/compilando-latex-con-rake.html

$LOAD_PATH << "../../"

require "rake/clean"
require "lib/volumeCommands"


VOLUME_MASTER = "volume-master"
VOLUME_MASTER_OUTPUT_FILE = VOLUME_MASTER.ext("pdf")

namespace :volume  do

  file VOLUME_MASTER_OUTPUT_FILE => SOURCES  do
    1.upto 3 do
      pdflatex VOLUME_MASTER
    end
  end
  
  task :pdf => VOLUME_MASTER_OUTPUT_FILE
end




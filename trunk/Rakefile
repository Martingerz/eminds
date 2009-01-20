require "rake/clean"
require "sources/volume/core/Rakefile"
require "lib/EmindsDataFile"

SOURCES_PATH = "sources"
BUILD_PATH = "build"
OUTPUT_PATH = "output"

VOLUME = "volume"
VOLUME_CORE = File.join(VOLUME, 'core', '.')
VOLUME_SPECIFIC = File.join('volume', 'specific', '.')

CLEAN.include(BUILD_PATH)
CLOBBER.include(OUTPUT_PATH)

FILE_OPTIONS = {:preserve=>true, :verbose=>true}

def at_build(path)
  File.join("#{BUILD_PATH}", path)
end

def at_sources(path)
  File.join("#{SOURCES_PATH}", path)
end

def at_output(path)
  File.join("#{OUTPUT_PATH}", path)
end

def generate_output_file_name
  eminds_data_file = EmindsDataFile.new(at_sources(File.join(VOLUME, "core", "volume-data.tex")))
  volume_count = eminds_data_file.read("emindsVolumeCount")
  volume_number = eminds_data_file.read("emindsVolumeNumber")
  
  "#{Date.today.to_s}_#{MASTER}_Vol_#{volume_count}_#{volume_number}.pdf"
end


directory "#{BUILD_PATH}/#{VOLUME}"
directory "#{OUTPUT_PATH}/#{VOLUME}"

namespace :volume  do
  
  desc "Prepare volume sources to build"
  task :prepare  => "#{BUILD_PATH}/#{VOLUME}" do
    puts "Copying files to build to #{at_build(VOLUME)}..."
    
    cp_r at_sources(VOLUME_CORE), at_build("#{VOLUME}"), FILE_OPTIONS
    cp_r at_sources(VOLUME_SPECIFIC), at_build("#{VOLUME}"), FILE_OPTIONS
  end
  
  desc "Invoke latex commands in order to compile the volume"
  task :build => :prepare do
    cd "#{BUILD_PATH}/#{VOLUME}" do
      # Rake::Task["volume:pdf"].invoke
      sh "rake volume:pdf"
    end
  end
  
  desc "Generate the volume final PDF file"
  task :generate => [:build, "#{OUTPUT_PATH}/#{VOLUME}"] do
    cp at_build(File.join(VOLUME, MASTER_OUTPUT_FILE)), at_output("#{VOLUME}/#{generate_output_file_name}")
  end
  
end




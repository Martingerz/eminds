require "rake/clean"
require 'rake/packagetask'
require "sources/volume/core/Rakefile"
require "sources/instructions/Rakefile"
require "lib/EmindsDataFile"
require "lib/volumeCommands"
require "date"



namespace :volume  do
  directory "#{BUILD_PATH}/#{VOLUME}"
  directory "#{OUTPUT_PATH}/#{VOLUME}"

  desc "Prepare the volume build directory"
  task :prepare  => "#{BUILD_PATH}/#{VOLUME}" do
    puts "Copying files to build to #{at_build(VOLUME)}..."
    
    cp_r at_sources(VOLUME_CORE), at_build("#{VOLUME}"), FILE_OPTIONS
    cp_r at_sources(VOLUME_SPECIFIC), at_build("#{VOLUME}"), FILE_OPTIONS
  end
  
  desc "Invoke latex compilation commands in order to build the volume"
  task :build => :prepare do
    cd "#{BUILD_PATH}/#{VOLUME}" do
      # Rake::Task["volume:pdf"].invoke
      sh "rake volume:pdf"
    end
  end
  
  desc "Generate the volume final PDF file"
  task :generate => [:build, "#{OUTPUT_PATH}/#{VOLUME}"] do
    cp at_build(File.join(VOLUME, VOLUME_MASTER_OUTPUT_FILE)), at_output("#{VOLUME}/#{generate_output_file_name(VOLUME_MASTER)}.pdf")
    
    target_specific_package_file = "../../#{File.join(at_output(VOLUME), generate_output_file_name(VOLUME_SPECIFIC_OUTPUT_FILE))}.zip"
    cd at_sources(VOLUME) do
      sh %{zip -r #{target_specific_package_file} specific}
    end
  end
  
end

namespace :instructions do
  directory "#{BUILD_PATH}/#{INSTRUCTIONS}"
  directory "#{OUTPUT_PATH}/#{INSTRUCTIONS}/#{INSTRUCTIONS_OUTPUT_BASE_NAME}/#{AUTHOR_KIT}" 
  

  desc "Prepare the instructions build directory"
  task :prepare => "#{BUILD_PATH}/#{INSTRUCTIONS}" do
    
    puts "Copying files to build to #{at_build(INSTRUCTIONS)}"
    
    cp_r at_sources(INSTRUCTIONS_CORE), at_build("#{INSTRUCTIONS}"), FILE_OPTIONS
    cp_r at_sources(File.join(VOLUME_CORE, EMINDS_PAPER_CLASS_FILE)), at_build("#{INSTRUCTIONS}"), FILE_OPTIONS
    cp_r at_sources(File.join(INSTRUCTIONS, "Rakefile.rb")), at_build("#{INSTRUCTIONS}"), FILE_OPTIONS
  end
  
  desc "Invoke latex compilation commands in order to build the instructions for authors"
  task :build => :prepare do
    cd "#{BUILD_PATH}/#{INSTRUCTIONS}" do
      sh "rake instructions:pdf"
    end
  end
  
  desc "Generate the directory containing the instructions' structure"
  task :generate => [:build, "#{OUTPUT_PATH}/#{INSTRUCTIONS}/#{INSTRUCTIONS_OUTPUT_BASE_NAME}/#{AUTHOR_KIT}"  ] do
    target_instructions_dir = File.join(at_output(INSTRUCTIONS), INSTRUCTIONS_OUTPUT_BASE_NAME)
    target_author_kit_dir = File.join(target_instructions_dir, AUTHOR_KIT)
    
    cp_r File.join(at_build(INSTRUCTIONS), INSTRUCTIONS_MASTER_OUTPUT_FILE),
      File.join(target_instructions_dir, "#{INSTRUCTIONS_OUTPUT_MASTER_FILE}.pdf"), FILE_OPTIONS
    cp_r at_sources(INSTRUCTIONS_CORE), target_author_kit_dir, FILE_OPTIONS
    cp_r at_sources(File.join(VOLUME_CORE, EMINDS_PAPER_CLASS_FILE)), target_author_kit_dir, FILE_OPTIONS
    cp_r at_sources(INSTRUCTIONS_FILES), target_instructions_dir, FILE_OPTIONS
    
    cd "#{target_instructions_dir}/.." do
      sh %{zip -r \"#{Date.today.to_s}-#{INSTRUCTIONS_OUTPUT_BASE_NAME}.zip\" .}
    end
  end
  
end






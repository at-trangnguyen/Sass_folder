require "scss_folder/version"

module ScssFolder
  # Your code goes here...
  SASS_DIR = "sass"
  BASE_DIR = "base"
  ALL_FILE = "all"
  STYLE_FILE = "style"
  SECTIONS_DIR = ["base", "layout", "module", "state", "page"]
  SECTION_BASE_FILE = ["reset", "variable", "mixin", "extend", "base"]
  def self.build
    Dir.mkdir SASS_DIR unless Dir.exists?SASS_DIR
    Dir.chdir SASS_DIR
    SECTIONS_DIR.each do |f|
      Dir.mkdir f unless Dir.exists?f
      Dir.chdir f do
        File.new("#{ALL_FILE}.scss", "w+").close  
      end
    end
    File.new("#{STYLE_FILE}.scss", "w+").close
    Dir.chdir BASE_DIR
    SECTION_BASE_FILE.each do |f|
      File.new("_#{f}.scss", "w+").close
    end
    File.open("#{ALL_FILE}.scss", "w+") do |file|
      SECTION_BASE_FILE.each do |f|
        file.write("@import \"#{f}\";\n")
      end
    end
    Dir.chdir ".."
    File.open("#{STYLE_FILE}.scss", "w+") do |file|
      SECTIONS_DIR.each do |f|
        file.write("@import \"#{f}/#{ALL_FILE}\";\n")
      end
    end
  end
end

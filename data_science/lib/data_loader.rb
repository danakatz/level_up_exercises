class DataLoader
  require "json"
  
  def self.load(file_name)
    JSON.parse(File.read(file_name))
  end
end
